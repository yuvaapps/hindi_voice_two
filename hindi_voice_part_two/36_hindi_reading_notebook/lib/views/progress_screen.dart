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

  static const List<Map<String, dynamic>> _levelInfo = [
    {'level': 1, 'title': 'स्तर १: वर्णमाला व बारहखड़ी', 'icon': '🔤'},
    {'level': 2, 'title': 'स्तर २: दो अक्षर वाले सरल शब्द', 'icon': '📖'},
    {'level': 3, 'title': 'स्तर ३: तीन अक्षर वाले शब्द', 'icon': '📝'},
    {'level': 4, 'title': 'स्तर ४: चार अक्षर व वाक्यांश', 'icon': '📚'},
    {'level': 5, 'title': 'स्तर ५: पठन वाक्य व कहानियाँ', 'icon': '📜'},
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final totalItems = AppData.items.length;
    final doneItems = vm.completedIds.length;
    final percent = totalItems > 0 ? (doneItems / totalItems) : 0.0;

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
            // Master Progress Card
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
                    '$doneItems / $totalItems',
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

            // Level Breakdown Header
            Text(
              'स्तर अनुसार प्रगति (Progress by Levels)',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),

            // Level breakdown cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _levelInfo.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, idx) {
                final info = _levelInfo[idx];
                final lvl = info['level'] as int;
                final lvlItems = AppData.items.where((i) => i.level == lvl).toList();
                final lvlTotal = lvlItems.length;
                final lvlDone = lvlItems.where((i) => vm.completedIds.contains(i.hindi)).length;
                final lvlPercent = lvlTotal > 0 ? (lvlDone / lvlTotal) : 0.0;

                return BouncingWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LearningScreen(initialLevel: lvl),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: lvlDone == lvlTotal && lvlTotal > 0
                            ? const Color(0xFF81C784)
                            : Colors.grey.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(info['icon'] as String, style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    info['title'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  Text(
                                    '$lvlDone / $lvlTotal',
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
                                  value: lvlPercent,
                                  minHeight: 6,
                                  backgroundColor: Colors.grey.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    lvlDone == lvlTotal && lvlTotal > 0
                                        ? const Color(0xFF2E7D32)
                                        : AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
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
