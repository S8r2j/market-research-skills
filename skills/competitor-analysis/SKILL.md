---
name: competitor-analysis
description: For a single problem, map every existing competitor/incumbent — what they provide, their pricing, and exhaustively WHAT THEY LACK and WHY people haven't adopted them or churned away — using real public reviews and posts (G2, Trustpilot, Capterra, app stores, Reddit cancellation threads). Use after deep research and before market sizing, whenever the user wants "who are the competitors", "what do existing tools lack", "why do people leave X", "competitor gap analysis", "why hasn't this been solved", or runs the competitor stage of the market pipeline. Every gap and churn reason must trace to a public source URL — no invented weaknesses.
---

# Competitor Analysis

Goal: for ONE problem, produce an evidence-backed competitor map whose centerpiece is an EXHAUSTIVE list of documented gaps and the real reasons people don't adopt or abandon these tools. Output `competitors/<problem_id>.json` + `<problem_id>_Competitors.pdf`.

Read `references/STANDARDS.md` first. Core rule: **a "lacking" claim or churn reason counts ONLY if it traces to a real public review/post with a URL.** No "probably lacks X." If reviews are sparse, say so — never invent weaknesses.

## Inputs
Load `02_research/<problem_id>.json` for incumbents already surfaced. Extend that list; don't restate it.

## Scope rule (exhaustive gaps, focused profiles)
- **Gaps: exhaustive.** Capture every documented gap across ALL competitors found. This list is the gold — make it complete.
- **Profiles: focused.** Deep-profile only the top 3–5 most-cited tools. List the rest lightly (name + one-line + URL).

## Method
1. Identify competitors: from research, plus `web_search` for "<problem> tools/software/apps", "best <category> 2026", "alternatives to <incumbent>".
2. For each deep-profiled competitor, `web_fetch`:
   - **Provides**: features, target user, pricing tiers — each sourced.
   - **Lacks**: gaps users explicitly complain about — quote (<15 words) + URL.
   - **Why not adopted / why left** — three evidenced buckets:
     - *Never-adopted*: too expensive / too complex / poor discovery / wrong fit.
     - *Tried-and-churned*: missing feature / bugs / bad support / price hike.
     - *Switched-away*: what they moved to instead, and why.
   - **Switching friction**: what locks users in vs. makes leaving easy.
3. Mine real review sources: G2, Capterra, Trustpilot, app stores, Reddit "I cancelled / switched from X" threads, HN. 1–2 star reviews are richest.
4. Aggregate ALL gaps across competitors into one deduplicated master gap list with frequency.

## Output schema — `competitors/<problem_id>.json`
```json
{
  "problem_id":"...","title":"...",
  "competitors":[
    {
      "name":"...","url":"...","target_user":"...","depth":"profiled|listed",
      "provides":[{"feature":"...","url":"..."}],
      "pricing":[{"tier":"...","price":"...","url":"..."}],
      "lacks":[{"gap":"...","quote":"<15-word verbatim","url":"...","accessed":"..."}],
      "why_not_adopted":[{"reason":"...","bucket":"never|churned|switched","quote":"...","url":"..."}],
      "switching_friction":{"lock_in":"...","ease_of_leaving":"...","url":"..."}
    }
  ],
  "master_gap_list":[
    {"gap_id":"g01","gap":"...","cited_by":["competitor names"],"frequency":"N sources","urls":["..."]}
  ],
  "unknowns":["competitors with too few reviews to assess"]
}
```
The `master_gap_list` with stable `gap_id`s is the contract: solution-design will map every `gap_id` to a feature or an explicit non-coverage decision.

## PDF — `<problem_id>_Competitors.pdf`
Via the `pdf` skill, charts/tables MANDATORY:
- **Feature × competitor matrix** (✓/✗/partial per feature).
- **Complaint-frequency bar chart** (most-cited gaps across all tools).
- **Pricing comparison table.**
- **Why-people-leave breakdown** (never / churned / switched).
Full Sources appendix with access dates. "Confidence & gaps" lists competitors that couldn't be assessed. Quotes <15 words, one per source.
