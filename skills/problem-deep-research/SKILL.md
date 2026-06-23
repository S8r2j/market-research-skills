---
name: problem-deep-research
description: Take a single confirmed problem and research it exhaustively across as many online sources as possible — building a deep, fully-sourced dossier on root causes, who is affected, current workarounds, existing solutions and why they fall short, regulations, costs, and trends. Use after problems are discovered, whenever the user wants to "dig deep into this problem", "research X in detail", "build a dossier on this pain point", or runs the deep-research stage of the market pipeline. Operates on ONE problem at a time to stay precise; every assertion carries a source URL and is tagged VERIFIED, INFERRED, or UNKNOWN.
---

# Problem Deep Research

Goal: for ONE problem, produce an exhaustive, brutally-sourced dossier. Output `02_research/<problem_id>.json` + `<problem_id>_Research.pdf`.

Read `references/STANDARDS.md` first. Work on a single `problem_id` per run — focus prevents drift and hallucination.

## Inputs
Load the problem object from `01_problems.json`. Inherit its evidence; do not re-discover, extend.

## Research dimensions (chase each to a primary source)
1. **Root causes** — why does this problem exist? Mechanism, not symptom.
2. **Who is affected & how badly** — segments, with quantified scope where sourceable.
3. **Current workarounds** — what people do today (from forums/posts), with URLs.
4. **Existing solutions / incumbents** — list each, its pricing, and *with evidence* why users still complain.
5. **Cost of the problem** — time/money lost, sourced. Tag `[INFERRED]` if you compute it; show the math.
6. **Regulation / standards / constraints** — anything that shapes solutions.
7. **Trends** — is this growing or shrinking? Sourced datapoints with dates.

## Process
- Run 8–20 searches; `web_fetch` full pages for anything quantitative or load-bearing — snippets are insufficient.
- Prefer primary data (gov, filings, papers) for numbers; community for lived experience.
- When sources conflict, record both with URLs and dates. Never average silently.
- Anything you cannot source = `[UNKNOWN]`, listed explicitly. Do not fill gaps.

## Output schema — `02_research/<problem_id>.json`
```json
{
  "problem_id":"...","title":"...",
  "root_causes":[{"claim":"...","tag":"VERIFIED|INFERRED|UNKNOWN","url":"...","accessed":"..."}],
  "affected_segments":[{"segment":"...","scope":"...","tag":"...","url":"..."}],
  "workarounds":[{"desc":"...","url":"..."}],
  "incumbents":[{"name":"...","pricing":"...","url":"...","why_users_still_hurt":"...","evidence_url":"..."}],
  "cost_of_problem":[{"metric":"...","value":"...","tag":"...","math":"...","url":"..."}],
  "regulation":[{"item":"...","url":"..."}],
  "trends":[{"point":"...","direction":"up|down|flat","date":"...","url":"..."}],
  "conflicts":[{"topic":"...","source_a":"...","source_b":"..."}],
  "unknowns":["..."]
}
```

## PDF — `<problem_id>_Research.pdf`
Via the `pdf` skill. Include: an incumbent-comparison table (name × price × key gap), a trend chart if time-series data exists, a cost-of-problem callout, and the full Sources appendix with access dates. A prominent "Confidence & gaps" section lists every `[UNKNOWN]`. Quotes <15 words, one per source.
