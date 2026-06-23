---
name: market-sizing
description: Size the market for a single problem with rigorous, fully-sourced TAM/SAM/SOM, population estimates of how many people share the problem, growth rates, willingness-to-pay, and a MANDATORY balanced view presenting evidence both for and against the opportunity. Use after deep research, whenever the user wants "how big is this market", "market size", "TAM SAM SOM", "how many people have this problem", "is this worth building", or runs the sizing stage. Every figure is sourced and tagged; the report must include charts/tables and a dedicated 'evidence against' section — no cherry-picking.
---

# Market Sizing

Goal: for ONE problem, quantify the market honestly — including data that argues AGAINST the opportunity. Output `04_market/<problem_id>.json` + `<problem_id>_Market.pdf`.

Read `references/STANDARDS.md` first. Section 2 (adversarial completeness) is mandatory: the report fails review if it lacks an "Evidence against" section.

## Inputs
Load `02_research/<problem_id>.json` for affected segments, incumbents, trends, and `competitors/<problem_id>.json` for pricing benchmarks. Build sizing on top — don't restate, quantify.

## Sizing method (show every step)
1. **Affected population** — how many share this/similar problems in-category. Source the base population, then the % afflicted. Tag the multiplication `[INFERRED]` and show the math.
2. **TAM / SAM / SOM**
   - TAM = total spend or addressable population × price proxy (sourced).
   - SAM = realistically reachable segment — justify the filter with a source.
   - SOM = obtainable share in 1–3 yrs — justify with comparable-company benchmarks (sourced), not optimism.
3. **Growth rate** — CAGR with source and date; flag if vendor-reported.
4. **Willingness to pay** — sourced from incumbent pricing, surveys, or stated WTP.
5. **Bottom-up cross-check** — rebuild the number a second way (e.g. # users × ARPU) and reconcile against top-down. Report the gap.

## MANDATORY adversarial section
Actively search for reasons this market is bad: shrinking demand, low WTP, entrenched free alternatives, regulatory headwinds, high CAC, commoditization, past startup failures. Each with a URL. If you found little, say what you searched.

## Output schema — `04_market/<problem_id>.json`
```json
{
  "problem_id":"...","title":"...",
  "affected_population":{"base":"...","base_url":"...","pct_afflicted":"...","pct_url":"...","estimate":"...","tag":"INFERRED","math":"..."},
  "tam":{"value":"...","method":"...","tag":"...","sources":["..."]},
  "sam":{"value":"...","filter":"...","sources":["..."]},
  "som":{"value":"...","basis":"comparable X (url)","sources":["..."]},
  "cagr":{"value":"...","date":"...","source":"...","bias_flag":"vendor?"},
  "wtp":{"value":"...","source":"..."},
  "bottom_up_check":{"value":"...","reconciliation":"gap vs top-down + why"},
  "evidence_for":[{"point":"...","url":"..."}],
  "evidence_against":[{"point":"...","url":"..."}],
  "unknowns":["..."]
}
```

## PDF — `<problem_id>_Market.pdf`
Via the `pdf` skill, charts MANDATORY:
- A TAM/SAM/SOM nested funnel or concentric chart.
- A growth-trend line chart (CAGR projection) with sourced data points marked.
- A two-column "For vs Against" table.
- A top-down vs bottom-up reconciliation bar.
Include full Sources appendix (flag vendor-biased ones), and "Confidence & gaps" listing `[UNKNOWN]`s. Numbers without a source URL must not appear.
