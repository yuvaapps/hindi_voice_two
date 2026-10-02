import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/notebook_word.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _shuffleWords() {
    setState(() {
      AppData.words.shuffle();
      _page = 0;
    });
    if (_controller.hasClients) {
      _controller.jumpToPage(0);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Text('🔀', style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text('Notebook pages shuffled! नया क्रम तैयार है'),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showJumpDialog() {
    final loc = AppLocalizations.of(context);
    final textCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('${loc.translate('page')} (1 - ${AppData.words.length})'),
          content: TextField(
            controller: textCtrl,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter page number...',
              filled: true,
              fillColor: AppTheme.primaryLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(loc.translate('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                final num = int.tryParse(textCtrl.text.trim());
                if (num != null && num >= 1 && num <= AppData.words.length) {
                  Navigator.pop(ctx);
                  _controller.jumpToPage(num - 1);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Go'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.words.length;
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppTheme.notebookBg,
      appBar: AppBar(
        title: Text(
          '${loc.translate('page')} ${_page + 1} / $total',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle_rounded),
            onPressed: _shuffleWords,
            tooltip: 'Shuffle Pages',
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: _showJumpDialog,
            tooltip: 'Go to page',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Notebook Card Area
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: total,
                onPageChanged: (idx) {
                  setState(() => _page = idx);
                },
                itemBuilder: (context, idx) {
                  final word = AppData.words[idx];
                  final isCompleted = vm.completedIds.contains(word.id);
                  final isPlaying = vm.currentPlayingId == word.id;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: isPlaying ? AppTheme.primaryColor : const Color(0xFFFFCC80),
                          width: isPlaying ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isPlaying
                                ? AppTheme.primaryColor.withOpacity(0.35)
                                : AppTheme.primaryColor.withOpacity(0.12),
                            blurRadius: isPlaying ? 16 : 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: CustomPaint(
                          painter: _NotebookLinesPainter(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isCompleted)
                                      NotebookStampSlam(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                          margin: const EdgeInsets.only(bottom: 12),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE8F5E9),
                                            borderRadius: BorderRadius.circular(14),
                                            border: Border.all(color: const Color(0xFF81C784)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.green.withOpacity(0.15),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 16),
                                              const SizedBox(width: 6),
                                              Text(
                                                loc.translate('stamped'),
                                                style: const TextStyle(
                                                  color: Color(0xFF2E7D32),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    // Floating Emoji
                                    FloatingAnimation(
                                      offset: 6.0,
                                      duration: const Duration(milliseconds: 1800),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(word.emoji, style: const TextStyle(fontSize: 88)),
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Main Word text (Hindi / English)
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        isHindi ? word.hindi : word.english,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Secondary Translation text
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        isHindi ? word.english : word.hindi,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.subtitleColor.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Example Sentence (Notebook style)
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF8E1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: const Color(0xFFFFE082)),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            '📝 उदाहरण वाक्य / Example:',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF8D6E63),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            word.exampleSentence,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                              color: Color(0xFF4E342E),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 22),

                                    // Audio Ripple Speaker Button
                                    AudioRippleEffect(
                                      isPlaying: isPlaying,
                                      rippleColor: AppTheme.primaryColor,
                                      child: BouncingWidget(
                                        onTap: () {
                                          vm.playWordAudio(word);
                                          vm.markCompleted(word.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            gradient: AppTheme.headerGradient,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.primaryColor.withOpacity(0.4),
                                                blurRadius: 12,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.volume_up_rounded,
                                            size: 36,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation Prev / Next
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: BouncingWidget(
                      onTap: _page > 0
                          ? () => _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                              )
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _page > 0 ? Colors.white : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _page > 0 ? AppTheme.primaryColor : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              color: _page > 0 ? AppTheme.primaryColor : Colors.grey.shade400,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              loc.translate('prev_page'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _page > 0 ? AppTheme.primaryColor : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: BouncingWidget(
                      onTap: _page < total - 1
                          ? () => _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                              )
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: _page < total - 1 ? AppTheme.headerGradient : null,
                          color: _page < total - 1 ? null : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _page < total - 1
                              ? [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              loc.translate('next_page'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _page < total - 1 ? Colors.white : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: _page < total - 1 ? Colors.white : Colors.grey.shade600,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Notebook lined paper background custom painter
class _NotebookLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Red left margin line
    final marginPaint = Paint()
      ..color = const Color(0xFFFFAB91).withOpacity(0.4)
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(38, 0), Offset(38, size.height), marginPaint);

    // Horizontal faint ruled lines
    final linePaint = Paint()
      ..color = const Color(0xFFFFE0B2).withOpacity(0.35)
      ..strokeWidth = 1.0;

    const lineSpacing = 32.0;
    for (double y = 48.0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
