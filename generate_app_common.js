const fs = require('fs');
const path = require('path');

const rootDir = 'E:/hindi_voice_two/hindi_voice_part_two';
const baseAppDir = path.join(rootDir, '26_hindi_daily_words');
const masterAudioCacheHi = 'E:/hindi_voice_two/master_audio_cache/hi';
const masterAudioCacheEn = 'E:/hindi_voice_two/master_audio_cache/en';

function copyDirSync(src, dest) {
  if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    if (['build', '.dart_tool', '.idea', 'test', 'ephemeral', '.plugin_symlinks', '.gradle'].includes(entry.name)) continue;
    if (entry.isSymbolicLink && entry.isSymbolicLink()) continue;
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      try {
        fs.copyFileSync(srcPath, destPath);
      } catch (err) {
        // ignore symlink or locked errors
      }
    }
  }
}

function writeFile(filePath, content) {
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(filePath, content, 'utf8');
}

function setupScaffolding(appDirName, pkgName, appTitle) {
  const appPath = path.join(rootDir, appDirName);
  console.log(`Setting up scaffolding for ${appDirName} (${pkgName})...`);

  // 1. Create Android directory from 26_hindi_daily_words
  const androidSrc = path.join(baseAppDir, 'android');
  const androidDest = path.join(appPath, 'android');
  copyDirSync(androidSrc, androidDest);

  // 2. Pubspec.yaml
  const pubspec = `name: ${pkgName}
description: "${appTitle} - Hindi Voice Learning App for Kids"
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.13.0

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.5+1
  shared_preferences: ^2.5.5
  audioplayers: ^6.8.1
  google_fonts: ^8.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/audio/hi/
    - assets/audio/en/
`;
  writeFile(path.join(appPath, 'pubspec.yaml'), pubspec);

  // 3. Analysis options
  const analysisOptions = `include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    deprecated_member_use: ignore
    unnecessary_underscores: ignore
    unused_import: ignore
  exclude:
    - build/**
    - android/**
`;
  writeFile(path.join(appPath, 'analysis_options.yaml'), analysisOptions);

  // 4. Update Android build.gradle.kts and AndroidManifest.xml
  const buildGradleKtsPath = path.join(appPath, 'android', 'app', 'build.gradle.kts');
  if (fs.existsSync(buildGradleKtsPath)) {
    let bg = fs.readFileSync(buildGradleKtsPath, 'utf8');
    bg = bg.replace(/com\.hindivoice\.app26_hindi_daily_words/g, `com.hindivoice.${pkgName}`);
    fs.writeFileSync(buildGradleKtsPath, bg, 'utf8');
  }

  const manifestPath = path.join(appPath, 'android', 'app', 'src', 'main', 'AndroidManifest.xml');
  if (fs.existsSync(manifestPath)) {
    let mf = fs.readFileSync(manifestPath, 'utf8');
    mf = mf.replace(/android:label="[^"]*"/, `android:label="${appTitle}"`);
    fs.writeFileSync(manifestPath, mf, 'utf8');
  }

  // 5. Copy audio assets and ensure images directory exists
  const imagesDest = path.join(appPath, 'assets', 'images');
  if (!fs.existsSync(imagesDest)) fs.mkdirSync(imagesDest, { recursive: true });
  writeFile(path.join(imagesDest, '.gitkeep'), '');

  const hiDest = path.join(appPath, 'assets', 'audio', 'hi');
  const enDest = path.join(appPath, 'assets', 'audio', 'en');
  copyDirSync(masterAudioCacheHi, hiDest);
  copyDirSync(masterAudioCacheEn, enDest);

  // 6. Common Services: AudioService and StorageService
  const audioServiceCode = fs.readFileSync(path.join(baseAppDir, 'lib', 'services', 'audio_service.dart'), 'utf8');
  writeFile(path.join(appPath, 'lib', 'services', 'audio_service.dart'), audioServiceCode);

  const storageServiceCode = fs.readFileSync(path.join(baseAppDir, 'lib', 'services', 'storage_service.dart'), 'utf8');
  writeFile(path.join(appPath, 'lib', 'services', 'storage_service.dart'), storageServiceCode);

  // 7. Common AppLocalizations delegate
  const appLocalizationsCode = `import 'package:flutter/material.dart';
import 'hi.dart';
import 'en.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('hi'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String translate(String key) {
    if (locale.languageCode == 'en') {
      return enStrings[key] ?? key;
    }
    return hiStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['hi', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
`;
  writeFile(path.join(appPath, 'lib', 'localization', 'app_localizations.dart'), appLocalizationsCode);

  console.log(`Scaffolding complete for ${appDirName}!`);
}

module.exports = {
  rootDir,
  writeFile,
  setupScaffolding
};
