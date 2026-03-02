# Review Process

This file covers the full review cycle: evaluation, line-level fixes, revision, and peer feedback.

---

## Part 1: Evaluation

Evaluate the draft on 5 dimensions. Rate each as:

- **✅ Strong** — No significant issues. Ready as-is or with minor polish
- **⚠️ Needs work** — Has potential but specific areas need improvement before publishing
- **❌ Rethink** — Fundamental issues that require structural changes or major rewriting

### Dimensions

#### 1. Depth of Thought (思考の深さ)

Does the essay explore "why" deeply enough? Are claims defensible?

| Rating | Signal                                                                                  |
|--------|-----------------------------------------------------------------------------------------|
| ✅     | Claims backed by experience or citations. Assumptions stated. Alternatives acknowledged |
| ⚠️     | Some claims surface-level or unsupported. Missing nuance in places                      |
| ❌     | Groundless assertions. No consideration of alternatives. `これが正しい方法だ` tone      |

#### 2. Voice & Authenticity (声と人間らしさ)

Does the essay sound like a real person wrote it — with warmth, personality, and originality?

| Rating | Signal                                                                               |
|--------|--------------------------------------------------------------------------------------|
| ✅     | Author's voice is distinct. Concrete personal episodes. Natural emotional expression |
| ⚠️     | Competent but generic. Examples feel surface-level. Predictable structure            |
| ❌     | Reads like AI output. No personality. Template-like phrasing                         |

**Red flags:** `以下の通りです` overuse, uniform sentence structure, absence of failure stories, unnaturally balanced pros/cons without personal stance

#### 3. Structure & Readability (構成と読みやすさ)

Does the structure help the reader? Does it respect their time?

| Rating | Signal                                                                                 |
|--------|----------------------------------------------------------------------------------------|
| ✅     | Opening signals value. Headings tell the story. Skimmable yet rewarding on close read  |
| ⚠️     | Basic structure exists but long paragraphs, unclear heading hierarchy, or weak opening |
| ❌     | Wall of text. No clear flow. Reader would likely abandon mid-article                   |

**Note:** Conclusion-first works for most essays, but narrative order suits postmortems and thought-process pieces. Judge based on article purpose.

#### 4. Practical Value (実践的価値)

Can the reader take away something actionable — a mental model, framework, or concrete lesson?

| Rating | Signal                                                                                      |
|--------|---------------------------------------------------------------------------------------------|
| ✅     | Reusable insight with context for adaptation. "Why this approach" reasoning is transferable |
| ⚠️     | Useful information but gaps the reader must fill independently                              |
| ❌     | Abstract theory only. No clear takeaways                                                    |

#### 5. Social Sensitivity (社会的配慮)

Could anything cause unintended offense? **Judge by how readers might interpret, not author's intent.**

| Rating | Signal                                                                                   |
|--------|------------------------------------------------------------------------------------------|
| ✅     | Safe even under hostile reading. No expressions that could be misread or clipped for SNS |
| ⚠️     | Some expressions could be problematic in certain contexts. Fixable with targeted edits   |
| ❌     | Likely to draw criticism. **Do not publish externally without major revision**           |

**Quick check (any match → at most ⚠️):**
- Comparing people to animals, objects, or machines?
- Stereotyping any group?
- Would the most critical SNS reader find ammunition?
- Impact on the organization's brand if this goes viral?

**For external blog:** Apply stricter criteria. ❌ on this dimension = block publication.

### Evaluation Output Format

```markdown
# Evaluation

| Dimension               | Rating   | Key Observation |
|-------------------------|----------|-----------------|
| Depth of Thought        | ✅/⚠️/❌ | (one sentence)  |
| Voice & Authenticity    | ✅/⚠️/❌ | (one sentence)  |
| Structure & Readability | ✅/⚠️/❌ | (one sentence)  |
| Practical Value         | ✅/⚠️/❌ | (one sentence)  |
| Social Sensitivity      | ✅/⚠️/❌ | (one sentence)  |

## ⚠️ / ❌ Details
(For each non-✅ item: quote the passage, explain the issue, suggest a direction)

## Strengths
(2–3 specific things the draft does well, with quoted examples)

## Priority Fixes
(Ranked list of concrete improvements. Most impactful first.)
```

When asked to evaluate only ("評価して"), output this report and stop. Do NOT auto-fix.

---

## Part 2: Line-Level Review

Identify specific issues at the sentence level. Check against `rules.md` constraints.

### Output Format

Only output issues found. Do NOT output "no issues" lines.

```
**L{line_number}** - {category}：{summary}
```diff
- {original text}
+ {corrected text}
```
```

### Categories

| Category    | What to check                                                        |
|-------------|----------------------------------------------------------------------|
| `冗長表現`  | Wordy expressions per `rules.md` table                               |
| `文法`      | Subject-predicate mismatch, particle errors, modifier placement      |
| `文体`      | Unintentional である/ですます mixing, AI-sounding phrases            |
| `漢字/かな` | Kanji that should be hiragana per `rules.md` table                   |
| `語順`      | Modifier far from modified word, unnatural word order                |
| `表現`      | Condescending phrases, unsupported assertions, repeated conjunctions |
| `構成`      | Heading is a label not a claim, section covers multiple arguments    |

### Example Output

```
**L12** - 冗長表現：`〜することができる` → `〜できる`
```diff
- この仕組みを活用することができます。
+ この仕組みを活用できます。
```

**L45** - 文体：AI-sounding closing phrase
```diff
- いかがでしたでしょうか？
+ （削除、または具体的な問いかけに置き換え）
```

**L78** - 構成：Heading is a label, not a claim
```diff
- ## 技術選定について
+ ## なぜライブラリAではなくBを選んだのか
```
```

---

## Part 3: Revision (improving your own draft)

When asked to revise ("推敲して"), run the full cycle below.

### Step 1: Evaluate
Run Part 1. Identify ❌ items (priority) and ⚠️ items (secondary).

### Step 2: Line-level fixes
Run Part 2. Apply all fixes from `rules.md`.

### Step 3: Restructure
- Is the argument order natural? Would reordering improve clarity?
- Are there unnecessary sections? Conversely, are any arguments missing?
- Are headings assertions? Rewrite any label-style headings
- Are the opening and closing consistent with each other?

### Step 4: Polish
- Read the full text for rhythm and flow
- Ensure strong claims use short, punchy sentences
- Ensure transitions between sections are smooth
- Verify the first 3 sentences make the reader want to continue

### Step 5: Re-evaluate
Run Part 1 again. Output before/after comparison:

```markdown
## Before → After

| Dimension               | Before | After |
|-------------------------|--------|-------|
| Depth of Thought        | ⚠️     | ✅    |
| Voice & Authenticity    | ✅     | ✅    |
| Structure & Readability | ❌     | ⚠️    |
| Practical Value         | ⚠️     | ✅    |
| Social Sensitivity      | ✅     | ✅    |
```

---

## Part 4: Peer Feedback (reviewing someone else's draft)

When asked to review ("レビューして"), use the following structure.

### Step 1: Quick evaluation
Run Part 1 to establish baseline.

### Step 2: Line-level issues
Run Part 2 for mechanical fixes.

### Step 3: Higher-level feedback

Use **Good → Question → Suggestion** format:

**Good** — Lead with strengths. Quote specific passages.
```
> 「エンジニアリングの本質は、制約の中でどのような意思決定を下したかという
>  ストーリーの中にこそ宿ります」
This single sentence captures the article's core thesis. Placing it early is highly effective.
```

**Question** — Raise points of curiosity as questions, not directives.
```
Would adding one more concrete example of "team assumptions" help readers
map this to their own teams?
```

**Suggestion** — Provide a rewrite example with rationale.
```
Current:  「この柔軟性は一見利点のように見えますが、〜大きくずれる原因にもなっています」
Proposed: 「この柔軟性こそが、計画を裏切る最大の要因でもあります」
Reason:   Condensing the contrast into one sentence strengthens the impact.
```

### Feedback Tone
- Ask "why did you choose this expression?" rather than dictating
- Offer alternatives, not rejections
- Respect the author's individuality — do not normalize toward a generic voice
- Frame as "this could be even stronger" rather than "this is wrong"
