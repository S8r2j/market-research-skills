---
name: market-research-orchestrator
description: Run a full, end-to-end global market analysis for a technical founder — discover real problems people face online, deep-research each, find public proof of who's affected, map competitors and their gaps, size the market with for-and-against data, and design founder-buildable solutions, producing a separate researched PDF report per problem at every stage. Use this whenever the user wants to "analyze the market", "find problems to build a startup around", "find pain points and market size", "validate a business idea with real data", or asks to run the full problem→research→people→competitors→market→solution pipeline. Trigger this even when the user only describes the goal loosely (e.g. "find me problems worth solving and size them"); this skill sequences the six specialist skills and enforces evidence rules across all of them.
---

# Market Research Orchestrator

You coordinate six specialist skills into one disciplined pipeline. You do NOT do their work inline — you set up the run, then invoke each step skill in order, making each step read the previous step's output file.

## First: read the shared standards
Read `references/STANDARDS.md`. Every rule there is binding. The headline rule: **every claim needs a source URL; numbers without traceable origin are deleted, not guessed.**

## Setup
1. Confirm scope with the user in ONE short round: market/domain (or "open — you find them"), geography (default global), number of problems to pursue (default 5), and whether to run all stages or stop after a chosen stage.
2. Create the run folder: `/mnt/user-data/outputs/market-run-<YYYYMMDD-HHMM>/`.
3. Read `/mnt/skills/public/pdf/SKILL.md` once — all stages emit PDFs through it.

## Pipeline (run in order; each stage gates the next)
For each stage, load the corresponding step skill's SKILL.md and follow it. Do not proceed to a stage until the prior stage's JSON + PDF exist.

1. **problem-discovery** → writes `01_problems.json` + `Discovery_Report.pdf`. Pause; show the user the problem list and let them drop/keep before deep work.
2. **problem-deep-research** → for each kept problem writes `02_research/<id>.json` + `<id>_Research.pdf`.
3. **problem-evidence-people** → for each problem writes `03_people/<id>.json` + `<id>_People.pdf` (public handles/profiles + quotes only).
4. **competitor-analysis** → for each problem writes `competitors/<id>.json` + `<id>_Competitors.pdf` (every documented gap + why people don't adopt/churn; top 3–5 deep-profiled). Produces the `master_gap_list` with stable `gap_id`s.
5. **market-sizing** → for each problem writes `04_market/<id>.json` + `<id>_Market.pdf` (TAM/SAM/SOM with for-AND-against evidence, charts mandatory).
6. **solution-design** → for each problem writes `05_solutions/<id>.json` + `<id>_Solution.pdf`. MUST consume the competitor `master_gap_list` and include a gap-coverage matrix: every `gap_id` maps to a feature that closes it OR an explicit non-coverage decision. No gap silently dropped.

## Finalization
- Build one `Master_Index.pdf` linking every per-problem report with a one-line confidence rating each.
- `present_files` the master index first, then the per-problem PDFs grouped by problem.

## Discipline reminders
- One problem can be killed at any stage if evidence is too thin — record WHY in that problem's folder. A killed problem with documented reasons is a success, not a failure.
- Never let a later stage invent data a former stage didn't find. If `02_research` says `[UNKNOWN]`, downstream stages inherit that gap, they don't paper over it.
- Keep each stage's context focused on ONE problem at a time to avoid cross-contamination/drift.
