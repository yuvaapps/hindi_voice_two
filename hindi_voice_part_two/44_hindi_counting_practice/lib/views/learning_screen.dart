
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/counting_item.dart';
import '../services/audio_service.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with SingleTickerProviderStateMixin {
  late CountingItem _target;
  late List<int> _options;
  bool? _isCorrect;
  bool _showConfetti = false;
  final Random _rnd = Random();
  final AudioService _audio = AudioService();
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeCtrl)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) _shakeCtrl.reset();
      });
    _load();
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _load() {
    final list = List<CountingItem>.from(AppData.items)..shuffle(_rnd);
    _target = list.first;
    final opts = {_target.count};
    while (opts.length < 4) {
      opts.add(_rnd.nextInt(AppData.items.length) + 1);
    }
    _options = opts.toList()..shuffle(_rnd);
    _isCorrect = null;
    _showConfetti = false;
  }

  void _check(int ans) {
    if (_isCorrect == true) return;
    final correct = (ans == _target.count);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      _audio.playAudio(_target.audio);
      vm.markCompleted(_target.count);
      setState(() => _showConfetti = true);
    } else {
      _shakeCtrl.forward();
      _audio.playAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  void _next() => setState(_load);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final gradients = [
      [const Color(0xFF6C63FF), const Color(0xFF48CAE4)],
      [const Color(0xFFFF6584), const Color(0xFFFFBE76)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA8231), const Color(0xFFF7B731)],
    ];
    final grad = gradients[(_target.count - 1) % gradients.length];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text(
          loc.translate('start_learning'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Question label
                StaggeredEntrance(
                  delayMs: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      loc.translate('question'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Emoji grid card
                Expanded(
                  flex: 3,
                  child: StaggeredEntrance(
                    delayMs: 100,
                    child: AnimatedBuilder(
                      animation: _shakeAnim,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(
                          _isCorrect == false
                              ? 8 * sin(_shakeAnim.value * pi * 5)
                              : 0,
                          0,
                        ),
                        child: child,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: grad,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: grad[0].withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Hindi numeral + soundwave
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NumberPulseAura(
                                  active: _isCorrect == true,
                                  color: Colors.white,
                                  child: Text(
                                    _target.devanagari,
                                    style: const TextStyle(
                                      fontSize: 52,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ValueListenableBuilder<bool>(
                                  valueListenable: _audio.isPlayingNotifier,
                                  builder: (_, playing, __) => AudioSoundwaveWave(
                                    isPlaying: playing,
                                    color: Colors.white,
                                    barCount: 5,
                                    height: 36,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => _audio.playAudio(_target.audio),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.volume_up, color: Colors.white, size: 28),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _target.english,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Emoji objects
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: List.generate(_target.count, (i) {
                                return BouncingWidget(
                                  animate: _isCorrect == true,
                                  child: Text(
                                    _target.emoji,
                                    style: TextStyle(
                                      fontSize: _target.count <= 5 ? 48 : _target.count <= 10 ? 38 : 28,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Answer options
                StaggeredEntrance(
                  delayMs: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.5,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _options.map((opt) {
                      Color bg = Colors.white;
                      Color fg = AppTheme.primaryColor;
                      if (_isCorrect != null) {
                        if (opt == _target.count) {
                          bg = Colors.green.shade400;
                          fg = Colors.white;
                        } else if (opt != _target.count && _isCorrect == false) {
                          bg = Colors.red.shade100;
                        }
                      }
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _check(opt),
                            borderRadius: BorderRadius.circular(18),
                            child: Center(
                              child: Text(
                                '$opt',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: fg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // Feedback + Next button
                if (_isCorrect != null)
                  StaggeredEntrance(
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            color: _isCorrect! ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _isCorrect! ? Colors.green : Colors.orange,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _isCorrect! ? '🎉' : '💪',
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isCorrect!
                                    ? loc.translate('great_job')
                                    : loc.translate('try_again'),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _isCorrect! ? Colors.green.shade700 : Colors.orange.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                ElevatedButton.icon(
                  onPressed: _next,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(loc.translate('next')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
