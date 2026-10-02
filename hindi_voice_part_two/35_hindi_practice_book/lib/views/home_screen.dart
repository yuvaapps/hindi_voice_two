import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.items.length;
    final done = vm.completedIds.length;
    final progressPercent = total > 0 ? (done / total).clamp(0.0, 1.0) : 0.0;

    // Distinct categories for quick jumping
    final categories = <String, int>{};
    for (int i = 0; i < AppData.items.length; i++) {
      final cat = AppData.items[i].category;
      if (!categories.containsKey(cat)) {
        categories[cat] = i;
      }
    }

    const categoryEmojis = {
      'स्वर (Vowels)': '🍎',
      'व्यंजन (Consonants)': '🪷',
      'मात्राएं (Matras)': '✨',
      'दो अक्षर वाले शब्द': '💧',
      'तीन अक्षर वाले शब्द': '✒️',
      'चार अक्षर वाले शब्द': '🐍',
      'आ की मात्रा': '🥭',
      'इ एवं ई की मात्रा': '🐘',
      'उ एवं ऊ की मात्रा': '🌸',
      'ए एवं ऐ की मात्रा': '🍏',
      'ओ एवं औ की मात्रा': '🦚',
      'अनुस्वार व चंद्रबिंदु': '🍇',
      'गिनती (Numbers 1-100)': '🔢',
      'फल, सब्ज़ी व भोजन': '🍉',
      'पशु, पक्षी व प्रकृति': '🦁',
      'रिश्ते व परिवार': '👨‍👩‍👧‍👦',
      'शरीर के अंग': '👁️',
      'रंग, आकार व समय': '🎨',
      'स्कूल व घरेलू वस्तुएं': '🎒',
      'प्रकृति व पर्यावरण': '☀️',
      'अभ्यास वाक्य (Sentences)': '✍️',
      'त्योहार, व्यवसाय व मूल्य': '🪔',
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Action Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BouncingWidget(
                    onTap: vm.toggleLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
                        ],
                      ),
                      child: Text(
                        vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.amber.shade300),
                        ),
                        child: Row(
                          children: [
                            const Text('🌟', style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 4),
                            Text(
                              '${vm.score}',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        onPressed: vm.toggleSound,
                        icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Hero Banner Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD81B60), Color(0xFF8E24AA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD81B60).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  '✨ 1000+ हिंदी अभ्यास एवं आवाज़',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                loc.translate('app_title'),
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                loc.translate('subtitle'),
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        const FloatingAnimation(
                          offset: 5,
                          child: Text('📕', style: TextStyle(fontSize: 48)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressPercent,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.25),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$done / $total पूरा हुआ',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(progressPercent * 100).toInt()}%',
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Primary "Open Workbook" CTA
              BouncingWidget(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LearningScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCE4EC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text('✍️', style: TextStyle(fontSize: 26)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('start_learning'),
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                            ),
                            const Text(
                              'ट्रेसिंग और लिखावट स्लेट खोलें',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: AppTheme.primaryColor),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Categories Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'अभ्यास श्रेणियाँ (Categories)',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF880E4F)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LearningScreen()),
                      );
                    },
                    child: const Text('सभी देखें', style: TextStyle(color: AppTheme.primaryColor)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Category Cards Grid
              GridView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  final catName = categories.keys.elementAt(i);
                  final firstIdx = categories[catName]!;
                  final catEmoji = categoryEmojis[catName] ?? '📝';
                  final count = AppData.items.where((it) => it.category == catName).length;

                  return BouncingWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LearningScreen(initialIndex: firstIdx)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF8BBD0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(catEmoji, style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  catName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$count शब्द',
                                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // Quick Navigation Cards
              Row(
                children: [
                  Expanded(
                    child: BouncingWidget(
                      onTap: () {
                        final randIdx = math.Random().nextInt(AppData.items.length);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LearningScreen(initialIndex: randIdx)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🎲', style: TextStyle(fontSize: 22)),
                            SizedBox(width: 8),
                            Text('रैंडम शब्द', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BouncingWidget(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProgressScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🌟', style: TextStyle(fontSize: 22)),
                            SizedBox(width: 8),
                            Text('प्रगति', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BouncingWidget(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('⚙️', style: TextStyle(fontSize: 22)),
                            SizedBox(width: 8),
                            Text('सेटिंग्स', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
