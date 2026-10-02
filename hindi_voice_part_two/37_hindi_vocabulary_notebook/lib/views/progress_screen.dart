import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const Map<String, String> _categoryIcons = {
    'animals': '🦁',
    'fruits': '🍎',
    'vegetables': '🥕',
    'body': '👁️',
    'nature': '🌳',
    'family': '👨‍👩‍👧',
    'colors': '🎨',
    'school': '🎒',
    'house': '🏠',
    'food': '🍲',
    'clothes': '👕',
    'vehicles': '🚗',
    'professions': '👨‍⚕️',
    'numbers': '🔢',
    'actions': '🏃',
    'emotions': '😊',
    'places': '🏛️',
    'flowers': '🌸',
    'festivals': '🪔',
    'opposites': '⚖️',
    'adjectives': '✨',
    'spices': '🌶️',
    'instruments': '🪕',
    'materials': '💎',
    'kitchen': '🍳',
    'sports': '⚽',
    'time': '⏰',
    'tech': '💻',
    'geography': '🏔️',
    'daily': '💬',
    'shopping': '🛍️',
    'health': '🩺',
    'arts': '🎭',
    'office': '🏢',
    'environment': '🌍',
  };

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final totalWords = AppData.items.length;
    final doneWords = vm.completedIds.length;
    final percent = totalWords > 0 ? (doneWords / totalWords) : 0.0;

    // Group items by category
    final Map<String, List<String>> categoryItems = {};
    for (final item in AppData.items) {
      categoryItems.putIfAbsent(item.category, () => []).add(item.id);
    }

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          loc.translate('progress'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Master Progress Header Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00796B), Color(0xFF004D40)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF004D40).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const FloatingAnimation(
                    distance: 5,
                    child: Text('🏆', style: TextStyle(fontSize: 56)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$doneWords / $totalWords',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    loc.translate('completed_items'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percent,
                      minHeight: 12,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB300)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(percent * 100).toStringAsFixed(1)}% Mastered',
                    style: const TextStyle(
                      color: Color(0xFFFFB300),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Category Breakdown Section
            Text(
              loc.translate('categories_count'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryItems.keys.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final cat = categoryItems.keys.elementAt(index);
                final itemIds = categoryItems[cat]!;
                final catTotal = itemIds.length;
                final catDone = itemIds.where((id) => vm.completedIds.contains(id)).length;
                final catPercent = catTotal > 0 ? (catDone / catTotal) : 0.0;
                final icon = _categoryIcons[cat] ?? '🏷️';
                final title = loc.translate(cat);

                return BouncingWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LearningScreen(initialCategory: cat),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: catDone == catTotal && catTotal > 0
                            ? const Color(0xFF81C784)
                            : Colors.grey.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(icon, style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  Text(
                                    '$catDone / $catTotal',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: catPercent,
                                  minHeight: 6,
                                  backgroundColor: Colors.grey.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    catDone == catTotal && catTotal > 0
                                        ? const Color(0xFF2E7D32)
                                        : AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
