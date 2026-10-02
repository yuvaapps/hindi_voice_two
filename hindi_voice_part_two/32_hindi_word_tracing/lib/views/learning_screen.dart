import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/tracing_word.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String _search = '';

  void _shuffleWords() {
    setState(() {
      AppData.words.shuffle();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Text('🔀', style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text('Tracing words shuffled! नए शब्द क्रम तैयार हैं'),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.words.where((item) {
      final q = _search.toLowerCase().trim();
      return q.isEmpty || item.hindi.contains(q) || item.english.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(loc.translate('start_learning'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle_rounded),
            onPressed: _shuffleWords,
            tooltip: 'Shuffle Words',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar & Word Count
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              color: AppTheme.primaryLight.withOpacity(0.5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) => setState(() => _search = val),
                      decoration: InputDecoration(
                        hintText: isHindi ? 'शब्द खोजें (1000+ शब्द)...' : 'Search word (1000+ words)...',
                        prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF9FA8DA)),
                    ),
                    child: Text(
                      '${filtered.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            // Words List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        isHindi ? 'कोई शब्द नहीं मिला' : 'No words found',
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      itemBuilder: (context, idx) {
                        final item = filtered[idx];
                        final isPlaying = vm.currentPlayingId == item.id;
                        final isDone = vm.completedIds.contains(item.id);

                        return StaggeredEntrance(
                          index: idx,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isPlaying
                                    ? AppTheme.primaryColor
                                    : (isDone ? const Color(0xFF81C784) : const Color(0xFFC5CAE9)),
                                width: isPlaying ? 2.5 : 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isPlaying
                                      ? AppTheme.primaryColor.withOpacity(0.25)
                                      : AppTheme.primaryColor.withOpacity(0.06),
                                  blurRadius: isPlaying ? 12 : 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Row(
                                children: [
                                  // Emoji with subtle float
                                  FloatingAnimation(
                                    offset: 3.0,
                                    duration: const Duration(milliseconds: 2000),
                                    child: Text(item.emoji, style: const TextStyle(fontSize: 36)),
                                  ),
                                  const SizedBox(width: 14),

                                  // Word Hindi & English
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.hindi,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
                                          ),
                                        ),
                                        Text(
                                          item.english,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppTheme.subtitleColor.withOpacity(0.85),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Audio Button with ripple
                                  AudioRippleEffect(
                                    isPlaying: isPlaying,
                                    rippleColor: AppTheme.primaryColor,
                                    child: BouncingWidget(
                                      onTap: () {
                                        vm.playWordAudio(item);
                                        vm.markCompleted(item.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                          color: isPlaying ? Colors.white : AppTheme.primaryColor,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  // Trace Shortcut Button
                                  BouncingWidget(
                                    onTap: () {
                                      final actualIdx = AppData.words.indexOf(item);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PracticeScreen(initialIndex: actualIdx >= 0 ? actualIdx : idx),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: isDone
                                            ? const LinearGradient(colors: [Color(0xFF43A047), Color(0xFF2E7D32)])
                                            : AppTheme.headerGradient,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.primaryColor.withOpacity(0.25),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isDone ? Icons.check_rounded : Icons.gesture_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            isDone ? (isHindi ? 'सफल' : 'Done') : (isHindi ? 'ट्रेस' : 'Trace'),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
