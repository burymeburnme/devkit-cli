#!/usr/bin/env node
// ============================================================
// Simple test runner for devkit-cli
// ============================================================

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CLI_PATH = path.join(__dirname, '..', 'src', 'cli.js');
const TEST_DIR = path.join(__dirname, '..', '.test-output');

let passed = 0;
let failed = 0;

function test(name, fn) {
  try {
    fn();
    console.log(`  PASS: ${name}`);
    passed++;
  } catch (err) {
    console.error(`  FAIL: ${name}`);
    console.error(`    ${err.message}`);
    failed++;
  }
}

function assert(cond, msg) {
  if (!cond) throw new Error(msg || 'Assertion failed');
}

// Cleanup test output
function cleanup() {
  try { fs.rmSync(TEST_DIR, { recursive: true, force: true }); } catch {}
}

// Setup
process.chdir(path.join(__dirname, '..'));
cleanup();

console.log('\nRunning devkit-cli tests...\n');

test('CLI --help returns usage info', () => {
  const out = execSync(`node ${CLI_PATH} --help`, { encoding: 'utf-8' });
  assert(out.includes('devkit-cli'), 'Should show devkit-cli in help');
});

test('CLI --version returns version', () => {
  const out = execSync(`node ${CLI_PATH} --version`, { encoding: 'utf-8' });
  assert(out.includes('1.0.0'), 'Should show version 1.0.0');
});

test('CLI list shows available templates', () => {
  const out = execSync(`node ${CLI_PATH} list`, { encoding: 'utf-8' });
  assert(out.includes('NODE'), 'Should list NODE templates');
  assert(out.includes('PYTHON'), 'Should list PYTHON templates');
  assert(out.includes('GO'), 'Should list GO templates');
});

test('CLI new scaffolds a Node.js basic project', () => {
  execSync(`node ${CLI_PATH} new test-app --lang node --template basic`, { encoding: 'utf-8' });
  assert(fs.existsSync(path.join('test-app', 'package.json')), 'Should create package.json');
  assert(fs.existsSync(path.join('test-app', 'index.js')), 'Should create index.js');
  assert(fs.existsSync(path.join('test-app', '.gitignore')), 'Should create .gitignore');
  assert(fs.existsSync(path.join('test-app', 'README.md')), 'Should create README.md');
  fs.rmSync('test-app', { recursive: true, force: true });
});

test('CLI new scaffolds a Python CLI project', () => {
  execSync(`node ${CLI_PATH} new test-py --lang python --template cli`, { encoding: 'utf-8' });
  assert(fs.existsSync(path.join('test-py', 'main.py')), 'Should create main.py');
  assert(fs.existsSync(path.join('test-py', 'requirements.txt')), 'Should create requirements.txt');
  fs.rmSync('test-py', { recursive: true, force: true });
});

test('CLI new scaffolds a Go API project', () => {
  execSync(`node ${CLI_PATH} new test-go --lang go --template api`, { encoding: 'utf-8' });
  assert(fs.existsSync(path.join('test-go', 'main.go')), 'Should create main.go');
  assert(fs.existsSync(path.join('test-go', 'go.mod')), 'Should create go.mod');
  fs.rmSync('test-go', { recursive: true, force: true });
});

// Summary
console.log(`\n${'='.repeat(40)}`);
console.log(`Results: ${passed} passed, ${failed} failed`);
console.log(`${'='.repeat(40)}\n`);

process.exit(failed > 0 ? 1 : 0);
