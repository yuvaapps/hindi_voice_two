
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/matching_pair.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late List<MatchingPair> _currentPairs;
  late List<MatchingPair> _shuffledNames;
  int? _selectedNum;
  int? _selectedName;
  final Set<int> _matched = {};
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<MatchingPair>.from(AppData.pairs)..shuffle(_rnd);
    _currentPairs = list.take(3).toList();
    _shuffledNames = List<MatchingPair>.from(_currentPairs)..shuffle(_rnd);
    _selectedNum = null;
    _selectedName = null;
    _matched.clear();
  }

  void _onSelectNum(int n) {
    setState(() => _selectedNum = n);
    _check();
  }

  void _onSelectName(int n) {
    setState(() => _selectedName = n);
    _check();
  }

  void _check() {
    if (_selectedNum != null && _selectedName != null) {
      final vm = context.read<AppViewModel>();
      if (_selectedNum == _selectedName) {
        final pair = _currentPairs.firstWhere((p) => p.number == _selectedNum);
        vm.playAudio(pair.audio);
        vm.markCompleted(pair.number);
        setState(() {
          _matched.add(_selectedNum!);
          _selectedNum = null;
          _selectedName = null;
        });
      } else {
        vm.playAudio('assets/audio/hi/feedback_try.mp3');
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() { _selectedNum = null; _selectedName = null; });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('prompt'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                // Numerals column
                Expanded(
                  child: Column(
                    children: _currentPairs.map((p) {
                      final isM = _matched.contains(p.number);
                      final isS = _selectedNum == p.number;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isM ? Colors.green.shade100 : (isS ? Colors.orange.shade100 : Colors.white),
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: isM ? null : () => _onSelectNum(p.number),
                          child: Text(p.devanagari, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 24),
                // Names column
                Expanded(
                  child: Column(
                    children: _shuffledNames.map((p) {
                      final isM = _matched.contains(p.number);
                      final isS = _selectedName == p.number;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isM ? Colors.green.shade100 : (isS ? Colors.orange.shade100 : Colors.white),
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: isM ? null : () => _onSelectName(p.number),
                          child: Text(p.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (_matched.length == _currentPairs.length)
              Text(loc.translate('great_job'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => setState(_load),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला स्तर'),
            ),
          ],
        ),
      ),
    );
  }
}
