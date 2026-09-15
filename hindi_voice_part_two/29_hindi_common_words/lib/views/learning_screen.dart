
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.words.where((w) {
      final matchCat = vm.category == 'all' || w.category == vm.category;
      final q = vm.searchQuery.toLowerCase().trim();
      final matchQ = q.isEmpty || w.hindi.contains(q) || w.english.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: vm.setSearch,
              decoration: InputDecoration(
                hintText: loc.translate('search_hint'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isFav = vm.favoriteIds.contains(word.id);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: ListTile(
                    leading: Text(word.emoji, style: const TextStyle(fontSize: 32)),
                    title: Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(isHindi ? word.english : word.hindi, style: const TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(isFav ? Icons.star : Icons.star_border, color: Colors.amber),
                          onPressed: () => vm.toggleFavorite(word.id),
                        ),
                        IconButton(
                          icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_down, color: AppTheme.primaryColor),
                          onPressed: () {
                            vm.playWordAudio(word);
                            vm.markCompleted(word.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
