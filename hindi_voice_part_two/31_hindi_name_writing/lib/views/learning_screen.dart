import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/name_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class LearningScreen extends StatefulWidget {
  final bool isTab;
  const LearningScreen({super.key, this.isTab = false});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String _searchQuery = '';

  void _shuffleNames() {
    setState(() {
      AppData.names.shuffle();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Text('🔀', style: TextStyle(fontSize: 18)),
            SizedBox(width: 8),
            Text('Names shuffled! नए नाम क्रम तैयार हैं'),
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

    final filtered = AppData.names.where((item) {
      final q = _searchQuery.toLowerCase().trim();
      return q.isEmpty ||
          item.hindi.contains(q) ||
          item.english.toLowerCase().contains(q) ||
          item.meaning.toLowerCase().contains(q);
    }).toList();

    final bodyContent = Column(
      children: [
        // Search & Shuffle bar
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          color: AppTheme.primaryLight.withOpacity(0.5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: isHindi ? 'नाम या अर्थ खोजें...' : 'Search name or meaning...',
                    prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              BouncingWidget(
                onTap: _shuffleNames,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shuffle_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),

        // Names List
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text(
                    isHindi ? 'कोई नाम नहीं मिला' : 'No names found',
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
                                : (isDone ? const Color(0xFF80DEEA) : const Color(0xFFB2EBF2)),
                            width: isPlaying ? 2.5 : 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isPlaying
                                  ? AppTheme.primaryColor.withOpacity(0.2)
                                  : AppTheme.primaryColor.withOpacity(0.06),
                              blurRadius: isPlaying ? 12 : 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              // Number / Initials Badge
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  gradient: isDone
                                      ? const LinearGradient(colors: [Color(0xFF00E676), Color(0xFF00B0FF)])
                                      : AppTheme.headerGradient,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${idx + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Name & Meaning
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          item.hindi,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '(${item.english})',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.subtitleColor.withOpacity(0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '✨ ${item.meaning}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Audio ripple speaker button
                              AudioRippleEffect(
                                isPlaying: isPlaying,
                                rippleColor: AppTheme.primaryColor,
                                child: BouncingWidget(
                                  onTap: () {
                                    vm.playNameAudio(item);
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

                              const SizedBox(width: 8),

                              // Practice Pencil Button
                              BouncingWidget(
                                onTap: () {
                                  final actualIdx = AppData.names.indexOf(item);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PracticeScreen(initialIndex: actualIdx >= 0 ? actualIdx : idx),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3E0),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFFFB74D)),
                                  ),
                                  child: const Icon(
                                    Icons.edit_rounded,
                                    color: Color(0xFFE65100),
                                    size: 18,
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
    );

    if (widget.isTab) return bodyContent;
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
            onPressed: _shuffleNames,
            tooltip: 'Shuffle Names',
          ),
        ],
      ),
      body: SafeArea(child: bodyContent),
    );
  }
}
