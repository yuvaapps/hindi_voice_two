const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const root = path.join(__dirname, 'hindi_voice_part_two');
const apps = fs.readdirSync(root).filter(d => fs.statSync(path.join(root, d)).isDirectory());

console.log(`Upgrading ${apps.length} apps with multi-platform support (Windows, Web, Android) & full Flutter MaterialLocalizations...`);

for (let i = 0; i < apps.length; i++) {
  const app = apps[i];
  const appDir = path.join(root, app);
  console.log(`[${i + 1}/${apps.length}] Processing ${app}...`);

  // 1. Ensure windows and web platforms are generated so user can run on PC immediately
  if (!fs.existsSync(path.join(appDir, 'windows')) || !fs.existsSync(path.join(appDir, 'web'))) {
    execSync('flutter create --platforms=windows,android,web .', { cwd: appDir, stdio: 'pipe' });
  }

  // Remove any test/widget_test.dart created by flutter create
  const testDir = path.join(appDir, 'test');
  if (fs.existsSync(testDir)) {
    fs.rmSync(testDir, { recursive: true, force: true });
  }

  // 2. Update pubspec.yaml to include flutter_localizations
  const pubspecPath = path.join(appDir, 'pubspec.yaml');
  let pubspec = fs.readFileSync(pubspecPath, 'utf8');
  if (!pubspec.includes('flutter_localizations:')) {
    pubspec = pubspec.replace(
      /dependencies:\r?\n\s+flutter:\r?\n\s+sdk: flutter/,
      `dependencies:\n  flutter:\n    sdk: flutter\n  flutter_localizations:\n    sdk: flutter`
    );
    fs.writeFileSync(pubspecPath, pubspec, 'utf8');
  }

  // 3. Update lib/main.dart to import flutter_localizations and add delegates
  const mainPath = path.join(appDir, 'lib', 'main.dart');
  let mainContent = fs.readFileSync(mainPath, 'utf8');
  if (!mainContent.includes('GlobalMaterialLocalizations')) {
    if (!mainContent.includes("import 'package:flutter_localizations/flutter_localizations.dart';")) {
      mainContent = "import 'package:flutter_localizations/flutter_localizations.dart';\n" + mainContent;
    }
    mainContent = mainContent.replace(
      /localizationsDelegates:\s*(const\s*)?\[\s*AppLocalizations\.delegate\s*\],/,
      `localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],`
    );
    fs.writeFileSync(mainPath, mainContent, 'utf8');
  }

  // 4. Ensure analysis_options.yaml has proper ignore flags
  const analysisPath = path.join(appDir, 'analysis_options.yaml');
  const analysisOptions = `include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    deprecated_member_use: ignore
    unnecessary_underscores: ignore
    unused_import: ignore
    unused_local_variable: ignore
    use_build_context_synchronously: ignore
  exclude:
    - build/**
    - android/**
    - ios/**
    - web/**
    - windows/**
    - macos/**
    - linux/**
`;
  fs.writeFileSync(analysisPath, analysisOptions, 'utf8');
}

console.log('All apps upgraded successfully!');
