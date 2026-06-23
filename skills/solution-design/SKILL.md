---
name: solution-design
description: For a single researched, market-sized problem, design a concrete solution a technical founder could build — grounded in the dossier and competitor gaps, with sourced evidence on approach, differentiation, tech feasibility, build effort, business model, risks, and a validation plan. Use after market sizing, whenever the user wants "what should I build", "suggest a solution", "how would I solve this as a technical founder", "product/MVP idea backed by research", or runs the final pipeline stage. Solutions must trace to verified gaps and real comparables, not invented features, and must close every documented competitor gap or explicitly record why not.
---

# Solution Design

Goal: for ONE problem, propose a researched, founder-buildable solution that directly attacks the verified competitor gaps. Output `05_solutions/<problem_id>.json` + `<problem_id>_Solution.pdf`.

Read `references/STANDARDS.md` first. Every design choice must trace to a source: a verified user complaint, an incumbent gap, or a real comparable. Features justified only by "would be nice" are flagged as assumptions to validate, not stated as fact.

## Inputs (load all four)
- `02_research/<problem_id>.json` — root causes, incumbent gaps, workarounds.
- `competitors/<problem_id>.json` — the `master_gap_list` with stable `gap_id`s. This is the spec your solution must answer.
- `03_people/<problem_id>.json` — who to validate with.
- `04_market/<problem_id>.json` — size, WTP, evidence-against.

## Design dimensions
1. **Core solution** — what it does, mapped feature-by-feature to a specific verified pain (cite the pain's source).
2. **Differentiation & gap coverage** — go through the competitor `master_gap_list` and address EVERY `gap_id`. Each maps to either a feature that closes it (cite the gap's source) or an explicit, recorded decision NOT to address it (with reason). No gap silently dropped.
3. **Technical feasibility** — stack, key components, hard parts. For "is this buildable / does this exist" claims, web_search current tools/APIs/models and cite them.
4. **Build effort** — rough MVP scope and what a solo/small team can ship; tag estimates `[INFERRED]`.
5. **Business model** — pricing anchored to sourced WTP and incumbent pricing.
6. **Go-to-market** — first channel, seeded by where affected people actually gather (from people/discovery data).
7. **Risks & why-it-might-fail** — pull directly from the market report's "evidence against". Ignoring the against-case fails review.
8. **Validation plan** — cheapest experiments to falsify the riskiest assumption; suggest reaching the public people from stage 3 (respecting privacy rules).

## Output schema — `05_solutions/<problem_id>.json`
```json
{
  "problem_id":"...","title":"...",
  "solution_summary":"...",
  "features":[{"feature":"...","solves":"verified pain ...","pain_url":"..."}],
  "differentiation":[{"vs_incumbent":"...","edge":"...","gap_url":"..."}],
  "gap_coverage":[{"gap_id":"g01","gap":"...","coverage":"closed|partial|not_addressed","feature":"...","reason_if_not":"...","source_url":"..."}],
  "tech":{"stack":"...","hard_parts":"...","feasibility_sources":["..."]},
  "mvp_scope":{"build":"...","effort":"...","tag":"INFERRED"},
  "business_model":{"pricing":"...","anchored_to":"wtp/incumbent url"},
  "gtm":{"first_channel":"...","why":"affected people gather here (url)"},
  "risks":[{"risk":"...","from_market_against":"url"}],
  "validation_plan":[{"experiment":"...","falsifies":"assumption ...","cost":"..."}],
  "assumptions_to_validate":["features not yet backed by evidence"]
}
```

## PDF — `<problem_id>_Solution.pdf`
Via the `pdf` skill. Include: a **gap-coverage matrix** (every competitor `gap_id` × coverage status × the feature that closes it or the reason skipped) as the centerpiece, a feature→pain mapping table, a competitive-positioning 2x2 chart, a pricing-vs-incumbents bar chart, and a risk register table linked to the market against-case. Clearly separate `[VERIFIED]` foundations from `assumptions to validate`. The report fails review if any `gap_id` is missing from the matrix. Sources appendix at the end.
