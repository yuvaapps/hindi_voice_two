import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/reading_num.dart';
import '../services/audio_service.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialCategory;
  const LearningScreen({super.key, this.initialCategory = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _categoryIndex = 0;
  int _itemIndex = 0;
  bool _showConfetti = false;
  bool _isFlipped = false; // card flip state
  final AudioService _audio = AudioService();

  // Gradients per category
  static const List<List<Color>> _gradients = [
    [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
    [Color(0xFF1565C0), Color(0xFF42A5F5)],
    [Color(0xFFAD1457), Color(0xFFEC407A)],
    [Color(0xFF2E7D32), Color(0xFF66BB6A)],
    [Color(0xFFE65100), Color(0xFFFF9800)],
    [Color(0xFF00695C), Color(0xFF26A69A)],
    [Color(0xFFC62828), Color(0xFFEF5350)],
    [Color(0xFF283593), Color(0xFF5C6BC0)],
    [Color(0xFF4527A0), Color(0xFF7E57C2)],
    [Color(0xFF558B2F), Color(0xFF9CCC65)],
    [Color(0xFFBF360C), Color(0xFFFF7043)],
  ];

  List<ReadingNum> get _currentList => AppData.getCategory(_categoryIndex);
  ReadingNum get _item => _currentList[_itemIndex % _currentList.length];
  List<Color> get _grad => _gradients[_categoryIndex % _gradients.length];

  @override
  void initState() {
    super.initState();
    _categoryIndex = widget.initialCategory;
  }

  void _next() {
    final vm = context.read<AppViewModel>();
    vm.markCompleted(_item.number);
    setState(() {
      _itemIndex = (_itemIndex + 1) % _currentList.length;
      _showConfetti = false;
      _isFlipped = false;
    });
  }

  void _prev() {
    setState(() {
      _itemIndex =
          (_itemIndex - 1 + _currentList.length) % _currentList.length;
      _showConfetti = false;
      _isFlipped = false;
    });
  }

  void _onPlayAudio() {
    _audio.playAudio(_item.audio);
    final vm = context.read<AppViewModel>();
    vm.markCompleted(_item.number);
    setState(() => _showConfetti = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showConfetti = false);
    });
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      backgroundColor: Colors.white,
      builder: (ctx) => ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        itemCount: AppData.categoryNames.length,
        itemBuilder: (_, i) => ListTile(
          leading: Text(AppData.categoryEmojis[i],
              style: const TextStyle(fontSize: 28)),
          title: Text(AppData.categoryNames[i],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${AppData.getCategory(i).length} items'),
          trailing: i == _categoryIndex
              ? Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor)
              : null,
          onTap: () {
            setState(() {
              _categoryIndex = i;
              _itemIndex = 0;
              _showConfetti = false;
              _isFlipped = false;
            });
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final total = _currentList.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: Text(
          AppData.categoryNames[_categoryIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.category_rounded),
            onPressed: _showCategoryPicker,
            tooltip: 'Category',
          ),
        ],
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Column(
            children: [
              // ── Category tabs ──────────────────────────────────────────
              SizedBox(
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  itemCount: AppData.categoryNames.length,
                  itemBuilder: (ctx, i) {
                    final selected = i == _categoryIndex;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _categoryIndex = i;
                        _itemIndex = 0;
                        _showConfetti = false;
                        _isFlipped = false;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppTheme.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: selected
                                  ? AppTheme.primaryColor.withOpacity(0.35)
                                  : Colors.black12,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(AppData.categoryEmojis[i],
                                style: const TextStyle(fontSize: 15)),
                            const SizedBox(width: 4),
                            Text(
                              AppData.categoryNames[i],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    selected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
                  child: Column(
                    children: [
                      // ── Main card (flip on tap) ────────────────────────
                      Expanded(
                        flex: 5,
                        child: StaggeredEntrance(
                          key: ValueKey('$_categoryIndex-$_itemIndex'),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _isFlipped = !_isFlipped),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (child, anim) =>
                                  RotationYTransition(
                                turns: anim,
                                child: child,
                              ),
                              child: _isFlipped
                                  ? _BackCard(
                                      key: const ValueKey('back'),
                                      item: _item,
                                      grad: _grad,
                                    )
                                  : _FrontCard(
                                      key: const ValueKey('front'),
                                      item: _item,
                                      grad: _grad,
                                      showConfetti: _showConfetti,
                                      onPlay: _onPlayAudio,
                                      audio: _audio,
                                    ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── Progress bar ──────────────────────────────────
                      Row(
                        children: [
                          Text(
                            '${_itemIndex + 1} / $total',
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 13),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (_itemIndex + 1) / total,
                                backgroundColor: Colors.purple.shade50,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.primaryColor),
                                minHeight: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${((_itemIndex + 1) / total * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // ── Flip hint ──────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app_rounded,
                              size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            'Tap card to flip',
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade500),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ── Navigation buttons ────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _prev,
                              icon: const Icon(Icons.arrow_back_rounded),
                              label: const Text('पिछला'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.primaryColor,
                                side: BorderSide(
                                    color: AppTheme.primaryColor),
                                minimumSize: const Size(0, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Play audio button (center)
                          GestureDetector(
                            onTap: _onPlayAudio,
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: _grad,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _grad[0].withOpacity(0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.volume_up_rounded,
                                  color: Colors.white, size: 28),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _next,
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: Text(loc.translate('next')),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(0, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14)),
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Front card — shows Devanagari + Hindi name + audio wave
// ─────────────────────────────────────────────────────────────────────────────
class _FrontCard extends StatelessWidget {
  final ReadingNum item;
  final List<Color> grad;
  final bool showConfetti;
  final VoidCallback onPlay;
  final AudioService audio;

  const _FrontCard({
    super.key,
    required this.item,
    required this.grad,
    required this.showConfetti,
    required this.onPlay,
    required this.audio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: grad, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: grad[0].withOpacity(0.45),
              blurRadius: 22,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Decorative ring
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
            child: Center(
              child: NumberPulseAura(
                active: showConfetti,
                color: Colors.white,
                child: BouncingWidget(
                  amplitude: 6,
                  child: Text(
                    item.devanagari,
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            item.hindiName,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            item.roman,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 16),

          // Audio button + soundwave
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onPlay,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.volume_up, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 12),
              ValueListenableBuilder<bool>(
                valueListenable: audio.isPlayingNotifier,
                builder: (_, playing, __) => AudioSoundwaveWave(
                  isPlaying: playing,
                  color: Colors.white,
                  barCount: 5,
                  height: 32,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Emoji
          Text(item.emoji, style: const TextStyle(fontSize: 36)),

          const SizedBox(height: 8),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Tap to see translation →',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Back card — shows English + Tamil + emoji detail
// ─────────────────────────────────────────────────────────────────────────────
class _BackCard extends StatelessWidget {
  final ReadingNum item;
  final List<Color> grad;

  const _BackCard({super.key, required this.item, required this.grad});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [grad[1], grad[0]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: grad[1].withOpacity(0.45),
              blurRadius: 22,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large emoji
          Text(item.emoji, style: const TextStyle(fontSize: 72)),

          const SizedBox(height: 16),

          // English
          _TranslationRow(
            flag: '🇬🇧',
            text: item.englishName,
            size: 30,
          ),

          const SizedBox(height: 10),

          // Tamil
          _TranslationRow(
            flag: '🇮🇳',
            text: item.tamil,
            size: 26,
          ),

          const SizedBox(height: 14),

          // Hindi + number
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.devanagari,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  '•',
                  style: const TextStyle(fontSize: 20, color: Colors.white60),
                ),
                const SizedBox(width: 10),
                Text(
                  item.hindiName,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '← Tap to go back',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class _TranslationRow extends StatelessWidget {
  final String flag;
  final String text;
  final double size;
  const _TranslationRow(
      {required this.flag, required this.text, required this.size});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(flag, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// RotationYTransition — card flip effect helper
// ─────────────────────────────────────────────────────────────────────────────
class RotationYTransition extends AnimatedWidget {
  final Widget child;
  const RotationYTransition(
      {super.key, required Animation<double> turns, required this.child})
      : super(listenable: turns);

  @override
  Widget build(BuildContext context) {
    final anim = listenable as Animation<double>;
    final angle = anim.value * 3.1415926535897932;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: child,
    );
  }
}
