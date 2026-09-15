const fs = require('fs');
const path = require('path');

const rootDir = 'E:/hindi_voice_two/hindi_voice_part_two';
const baseAppDir = path.join(rootDir, '26_hindi_daily_words');
const masterAudioCacheHi = 'E:/hindi_voice_two/master_audio_cache/hi';
const masterAudioCacheEn = 'E:/hindi_voice_two/master_audio_cache/en';

// Helper to recursively copy directory
function copyDirSync(src, dest) {
  if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// Helper to write file safely
function writeFile(filePath, content) {
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(filePath, content, 'utf8');
}

console.log('Master generator script initialized.');
