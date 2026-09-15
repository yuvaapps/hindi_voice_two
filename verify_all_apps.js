const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const root = path.join(__dirname, 'hindi_voice_part_two');
const apps = fs.readdirSync(root).filter(d => fs.statSync(path.join(root, d)).isDirectory());

console.log(`Starting batch validation of all ${apps.length} apps...`);

const results = [];

for (const app of apps) {
  const appDir = path.join(root, app);
  process.stdout.write(`Analyzing ${app}... `);
  try {
    // Run pub get if .dart_tool does not exist
    if (!fs.existsSync(path.join(appDir, '.dart_tool'))) {
      execSync('flutter pub get', { cwd: appDir, stdio: 'pipe' });
    }
    const output = execSync('flutter analyze', { cwd: appDir, encoding: 'utf8', stdio: 'pipe' });
    if (output.includes('No issues found!')) {
      console.log('PASSED (0 issues)');
      results.push({ app, status: 'PASS', issues: 0 });
    } else {
      console.log('NOTICE:', output.trim().split('\n').pop());
      results.push({ app, status: 'PASS_WITH_OUTPUT', details: output.trim() });
    }
  } catch (err) {
    const stdout = err.stdout ? err.stdout.toString() : '';
    const stderr = err.stderr ? err.stderr.toString() : '';
    console.log('FAILED');
    console.error(stdout || stderr || err.message);
    results.push({ app, status: 'FAIL', error: stdout || stderr || err.message });
  }
}

console.log('\n--- BATCH VALIDATION SUMMARY ---');
const passed = results.filter(r => r.status === 'PASS').length;
console.log(`Passed: ${passed}/${apps.length}`);
if (passed === apps.length) {
  console.log('ALL 25 APPS PASSED STATIC ANALYSIS WITH ZERO ISSUES!');
} else {
  console.log('Failed apps:');
  results.filter(r => r.status !== 'PASS').forEach(r => console.log(r.app, r.error || r.details));
}
