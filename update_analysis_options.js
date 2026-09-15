const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, 'hindi_voice_part_two');
const apps = fs.readdirSync(root).filter(d => fs.statSync(path.join(root, d)).isDirectory());

const content = `include: package:flutter_lints/flutter.yaml

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

for (const app of apps) {
  const p = path.join(root, app, 'analysis_options.yaml');
  fs.writeFileSync(p, content, 'utf8');
}
console.log(`Updated analysis_options.yaml for ${apps.length} apps!`);
