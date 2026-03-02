# Writing Rules

## Prohibited Expressions

### AI-sounding phrases
Do NOT use generic AI-generated expressions:
- ❌ `〜についてご紹介します！`
- ❌ `いかがでしたでしょうか？`
- ❌ `さあ、始めましょう！`
- ❌ `〜について深掘りしていきます`
- ❌ `以下の通りです`

### Condescending expressions
- ❌ `当然ですが`, `言うまでもなく`, `ご存知の通り`

### Unsupported claims
- Do NOT make claims without evidence. Every assertion must be backed by personal experience or a citation

### Formatting
- Do NOT compose an article entirely from bullet lists. Maintain the flow of prose
- Limit exclamation marks (！) to 1–2 per entire article at most

## Style & Grammar

### Sentence length
- Target: ≤60 characters per sentence
- If longer, split into two sentences

### Sentence endings
- Do NOT repeat the same ending pattern 3+ times in a row
- Do NOT repeat the same conjunction 3+ times in sequence (especially `また`, `しかし`)

### である / ですます mixing
- Use `である` for: around citations, strong assertions, definitional statements at section openings
- Otherwise stick to `ですます`
- Never mix unintentionally

### Wordy expressions — trim when possible

| Wordy                | Concise             |
|----------------------|---------------------|
| `〜することができる` | `〜できる`          |
| `〜という点において` | `〜では`            |
| `〜であるということ` | `〜であること`      |
| `〜について`         | `〜を`              |
| `〜に対して`         | `〜に`              |
| `〜に関して`         | `〜の` / `〜を`     |
| `〜というのは`       | `〜のは`            |
| `〜ということで`     | `〜ため` / `〜ので` |

### Kanji / Hiragana usage
Use hiragana for functional words that don't carry substantial meaning:

| Kanji    | Hiragana   | Notes              |
|----------|------------|--------------------|
| `事`     | `こと`     | `〜すること`       |
| `為`     | `ため`     | `〜のため`         |
| `所`     | `ところ`   | `改善したいところ` |
| `出来る` | `できる`   |                    |
| `下さい` | `ください` |                    |
| `頂く`   | `いただく` |                    |
| `無い`   | `ない`     | auxiliary          |
| `有る`   | `ある`     | auxiliary          |
| `更に`   | `さらに`   |                    |
| `様々`   | `さまざま` |                    |
| `是非`   | `ぜひ`     |                    |

### Subject-predicate alignment
- Do not omit the subject when ambiguity would result
- Ensure subject and predicate match grammatically

```
❌ 特に気になった変更点は、新しいログ出力機能が追加されました。
✅ 特に気になった変更点は、新しいログ出力機能が追加されたことです。
```

### Modifier placement
- Place modifiers close to what they modify

```
❌ 細かいアーキテクチャの説明は省略します
✅ アーキテクチャの細かい説明は省略します
```

### Non-adversative が
- Do not use `〜が` as a mere connector when there is no contrast
- Split into separate sentences instead

```
❌ 本機能は外部APIを利用してデータを取得しますが、取得したデータはDBへ保存されます。
✅ 本機能は外部APIを利用してデータを取得します。取得したデータはDBへ保存されます。
```

## Decision Criteria

| When in doubt about... | Rule                                                                    |
|------------------------|-------------------------------------------------------------------------|
| Using jargon           | Replace with plain language. If unavoidable, add contextual explanation |
| Using a metaphor       | Use it — but always address its limitations                             |
| Article length         | ~300–500 chars per section. ~2000–4000 chars total                      |
| Heading wording        | Ask: "Does this heading itself make a claim?"                           |
| Including a citation   | Include if it strengthens the argument. Avoid decorative quotes         |

## Publication-Specific Rules

### Internal Note (Intranet/Internal Wiki)
- Casual tone: `〜してみた`, `〜だと思う` are acceptable
- No self-introduction needed
- May assume some internal context as shared knowledge
- Insert book/blog citations freely

### External Engineering Blog
- More polished tone. Include self-introduction (affiliation, role, name, SNS handle)
- Provide thicker context for external readers
- Explain organization-specific terms on first mention
- Link to related past blog posts where appropriate
- Apply stricter social sensitivity checks (see `review.md` evaluation criteria)
