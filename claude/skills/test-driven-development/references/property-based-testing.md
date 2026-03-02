---
name: property-based-testing
description: Reference for property-based testing and fuzzing - load when testing parsers, serializers, validators, or security-critical input handling
---

# Property-Based Testing & Fuzzing

## Overview

Example-based tests verify "this input produces this output." Property-based testing verifies "properties that hold for all inputs." Fuzzing verifies "no crashes on unexpected inputs."

**Core principle:** Example-based tests are necessary. Property-based testing and fuzzing approach sufficiency.

## Property-Based Testing

### Concept

Instead of specific inputs, define "properties" of inputs and verify with many randomly generated inputs.

```
例示ベース: reverse([1, 2, 3]) === [3, 2, 1]
Property-based: reverse(reverse(xs)) === xs  # 任意の xs に対して
```

### When to Use

| Situation | Fit |
|-----------|-----|
| Inverse operations (encode/decode, serialize/deserialize) | ✅ Ideal |
| Mathematical properties (commutativity, associativity, idempotence) | ✅ Ideal |
| Invariants hold for any input | ✅ Ideal |
| Integration tests with external APIs | ⚠️ Poor fit |
| UI component tests | ⚠️ Poor fit |

### Common Property Patterns

#### Round-trip

```typescript
// TypeScript (fast-check)
import fc from 'fast-check';

fc.assert(
  fc.property(fc.json(), (json) => {
    const encoded = JSON.stringify(json);
    const decoded = JSON.parse(encoded);
    return deepEqual(decoded, json);
  })
);
```

```python
# Python (hypothesis)
from hypothesis import given
import hypothesis.strategies as st

@given(st.binary())
def test_base64_roundtrip(data):
    encoded = base64.b64encode(data)
    decoded = base64.b64decode(encoded)
    assert decoded == data
```

```go
// Go (testing/quick or gopter)
func TestReverse(t *testing.T) {
    f := func(xs []int) bool {
        return slices.Equal(reverse(reverse(xs)), xs)
    }
    if err := quick.Check(f, nil); err != nil {
        t.Error(err)
    }
}
```

#### Idempotence

```typescript
fc.assert(
  fc.property(fc.string(), (s) => {
    return normalize(normalize(s)) === normalize(s);
  })
);
```

#### Invariant

```typescript
fc.assert(
  fc.property(fc.array(fc.integer()), (arr) => {
    const sorted = sort(arr);
    return sorted.length === arr.length && isSorted(sorted);
  })
);
```

#### Commutativity

```typescript
fc.assert(
  fc.property(fc.integer(), fc.integer(), (a, b) => {
    return add(a, b) === add(b, a);
  })
);
```

### Tools

| Language | Library |
|----------|---------|
| TypeScript/JavaScript | fast-check |
| Python | hypothesis |
| Go | testing/quick, gopter, rapid |
| Rust | proptest, quickcheck |
| Java/Kotlin | jqwik |

## Fuzzing

### Concept

Generate massive amounts of random or mutation-based inputs to detect crashes, hangs, and memory leaks.

### When to Use

| Situation | Fit |
|-----------|-----|
| Processing external input (files, network) | ✅ Ideal |
| Parsers, deserializers | ✅ Ideal |
| Security boundary code | ✅ Ideal |
| Processing only trusted internal data | ⚠️ Low priority |

### Examples

#### Go (native fuzzing)

```go
func FuzzParseJSON(f *testing.F) {
    // Seed corpus
    f.Add([]byte(`{"key": "value"}`))
    f.Add([]byte(`[]`))
    f.Add([]byte(`null`))

    f.Fuzz(func(t *testing.T, data []byte) {
        var v any
        // Should not panic
        _ = json.Unmarshal(data, &v)
    })
}
```

```bash
go test -fuzz=FuzzParseJSON -fuzztime=30s
```

#### Python (atheris)

```python
import atheris
import sys

def test_one_input(data):
    try:
        parse_config(data)
    except ValueError:
        pass  # Expected
    # Crash/hang = bug found

atheris.Setup(sys.argv, test_one_input)
atheris.Fuzz()
```

#### Rust (cargo-fuzz)

```rust
#![no_main]
use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    if let Ok(s) = std::str::from_utf8(data) {
        let _ = parse_config(s);
    }
});
```

```bash
cargo fuzz run fuzz_parse_config -- -max_total_time=60
```

### Tools

| Language | Tool |
|----------|------|
| Go | go test -fuzz (standard) |
| Rust | cargo-fuzz, afl.rs |
| Python | atheris, python-afl |
| C/C++ | AFL++, libFuzzer |
| General | OSS-Fuzz |

## TDD Integration

### Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   ┌───────┐         ┌───────┐         ┌──────────┐              │
│   │  RED  │────────▶│ GREEN │────────▶│ PROPERTY │─────┐        │
│   └───────┘         └───────┘         └──────────┘     │        │
│       │                                     │          ▼        │
│       │                               ┌──────────┐  ┌──────┐    │
│       │                               │ REFACTOR │◀─│ FUZZ │    │
│       │                               └──────────┘  └──────┘    │
│       │                                     │                   │
│       └─────────────────────────────────────┘                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

RED:      Verify failure with example-based test
GREEN:    Minimal implementation to pass
PROPERTY: Test generalized properties (if applicable)
FUZZ:     Run at security boundaries (if applicable)
REFACTOR: Improve code
```

### Application Order

1. **Always start with example-based tests** - TDD fundamentals
2. **Add Property-Based when properties are clear** - Verify generalization
3. **Add Fuzzing when handling external input** - Verify robustness

### Example: Parser TDD

```typescript
// 1. RED: Example-based test
test('parses simple config', () => {
  expect(parseConfig('key=value')).toEqual({ key: 'value' });
});

// 2. GREEN: Implementation

// 3. PROPERTY: Roundtrip property
fc.assert(
  fc.property(fc.dictionary(fc.string(), fc.string()), (obj) => {
    const serialized = serializeConfig(obj);
    const parsed = parseConfig(serialized);
    return deepEqual(parsed, obj);
  })
);

// 4. FUZZ: Robustness (run in separate file or CI)
```

## Prohibitions

### Property-Based Testing

```text
❌ Never: Skip example tests and only write property tests
❌ Never: Cram overly complex properties into one test
❌ Never: Ignore shrinking on failure
✅ Always: Add failed inputs as example tests
```

### Fuzzing

```text
❌ Never: Run fuzzing in production
❌ Never: Ignore crashes
❌ Never: Start without seed corpus (inefficient)
✅ Always: Add discovered bugs as regression tests
```

## Handling Discovered Bugs

Bugs found via fuzzing or property-based testing **must be added as example-based tests**:

```typescript
// Found via fuzzing: crash on empty string
test('handles empty string without crash', () => {
  expect(() => parseConfig('')).not.toThrow();
});

// Found via property-based: roundtrip fails with special chars
test('roundtrip with special characters', () => {
  const input = { key: 'value\x00with\nnull' };
  const serialized = serializeConfig(input);
  const parsed = parseConfig(serialized);
  expect(parsed).toEqual(input);
});
```

## Quick Reference

| Purpose | Technique | Tools |
|---------|-----------|-------|
| Verify "always holds" properties | Property-Based | fast-check, hypothesis |
| Find crashes/vulnerabilities | Fuzzing | go test -fuzz, cargo-fuzz |
| Auto-discover edge cases | Both | - |
| Simple behavior verification | Example-based | jest, pytest |

## CI Integration

### Property-Based Testing

Include in regular test suite (watch execution time):

```yaml
# GitHub Actions
- run: npm test  # fast-check テストを含む
```

### Fuzzing

Run in dedicated job (with time limit):

```yaml
fuzz:
  runs-on: ubuntu-latest
  steps:
    - run: go test -fuzz=. -fuzztime=5m ./...
```

## Red Flags

- 例示テストなしで Property-based テストだけ書く
- Fuzzing で見つかったクラッシュを再現テストにしない
- 「性質が思いつかない」で諦める（往復・冪等性を検討）
- Seed corpus なしで Fuzzing を始める
- 長時間 Fuzzing を CI で毎回実行（時間制限を設ける）
