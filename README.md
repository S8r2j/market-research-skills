# market-research-skills

A suite of seven composable **Claude Skills** that run a disciplined, evidence-first market-analysis pipeline for a technical founder — from discovering real problems people complain about online, through competitor gap analysis and market sizing, to a researched solution design. Every stage produces its own PDF report, and every factual claim must carry a source URL.

> Built for [Claude Skills](https://support.claude.com/en/articles/12512180-use-skills-in-claude) (Claude.ai, Claude Cowork, and Claude Code). Requires the **Code execution & file creation** capability enabled.

---

## What makes this different

- **No-hypothesis rule.** Every claim needs a source URL. Numbers are tagged `[VERIFIED]`, `[INFERRED]` (with the math shown), or `[UNKNOWN]`. Unsourced numbers are deleted, not guessed.
- **Adversarial honesty.** Market sizing must include a dedicated *"evidence against the opportunity"* section. No cherry-picking.
- **Gap-closing solutions.** Competitor analysis builds an exhaustive gap list; solution design must map every single gap to a feature that closes it — or record an explicit reason it doesn't.
- **Privacy-respecting.** The "find real people" stage captures only public profiles + verbatim quotes. No private emails, no scraping.
- **One PDF per stage, per problem.** With charts, tables, and a sources appendix.

---

## The pipeline

```
problem-discovery
      │  01_problems.json + Discovery_Report.pdf   (PAUSE for user triage)
      ▼
problem-deep-research        02_research/<id>.json + <id>_Research.pdf
      ▼
problem-evidence-people      03_people/<id>.json   + <id>_People.pdf
      ▼
competitor-analysis          competitors/<id>.json + <id>_Competitors.pdf
      ▼
market-sizing                04_market/<id>.json   + <id>_Market.pdf
      ▼
solution-design              05_solutions/<id>.json + <id>_Solution.pdf
      ▼
Master_Index.pdf
```

`market-research-orchestrator` drives all six specialist skills in order, passing each stage's output file to the next.

| Skill | Job |
|---|---|
| **market-research-orchestrator** | Sequences the whole pipeline; enforces standards; builds the master index. |
| **problem-discovery** | Sweeps Reddit, X, LinkedIn, Threads, forums, reviews, blogs for real complaints; categorizes them. |
| **problem-deep-research** | One problem at a time: root causes, incumbents, cost, regulation, trends — all sourced. |
| **problem-evidence-people** | Finds ≥5 distinct real people who publicly stated the problem (public profile + quote only). |
| **competitor-analysis** | Maps competitors, exhaustive gap list, and *why people don't adopt / churn*. |
| **market-sizing** | TAM/SAM/SOM with shown math, bottom-up cross-check, and mandatory evidence-against. |
| **solution-design** | Founder-buildable solution that closes every documented competitor gap. |

---

## Repository layout

```
skills/
  market-research-orchestrator/
    SKILL.md
    references/STANDARDS.md
  problem-discovery/
    SKILL.md
    references/STANDARDS.md
  ... (one folder per skill)
```

Each skill folder is self-contained: its `SKILL.md` plus a copy of the shared `STANDARDS.md` it depends on.

---

## Installation

### Claude.ai or Claude Cowork (web/desktop)

Skills are uploaded as a `.zip` of a single skill folder (the zip must contain a `SKILL.md` at its root).

1. Enable **Customize → Skills** (and **Code execution & file creation** under Settings → Capabilities).
2. For each skill folder, zip it and upload:
   ```bash
   cd skills
   for d in */; do (cd "$d" && zip -qr "../${d%/}.zip" .); done
   ```
   Upload each `.zip` via **Customize → Skills → Add**.
3. Re-uploading a skill with the same name **updates** it; a new name **adds** it.

> Note: Claude.ai/Cowork skills and Claude Code skills are separate — installing in one does not install in the other.

### Claude Code

Copy each skill folder into your skills directory:

```bash
cp -r skills/* ~/.claude/skills/
```

Then invoke with `/` followed by the skill name in a session.

---

## How to run

### Full pipeline (recommended entry point)

Paste into Claude (fill the two bracketed slots):

```
Use the market-research-orchestrator skill to run a complete end-to-end market analysis.

Domain: [YOUR DOMAIN — e.g. "AI workflow automation for skilled trades (plumbers, electricians)"]
Scope: [global / Nepal / global with Nepal beachhead]
Problems to pursue: 5

Run all stages in order: discovery → deep-research → people-evidence → competitor-analysis
→ market-sizing → solution-design. Pause after discovery and show me the problem list with
how well-sourced each one is, so I can keep or drop problems before the deep work.

Enforce standards strictly: every claim needs a source URL; tag numbers [VERIFIED],
[INFERRED] (show the math), or [UNKNOWN] — never guess. Market sizing must include an
"evidence against" section. Competitor analysis must produce an exhaustive gap list, and
solution-design must map every gap_id to a feature or an explicit reason it's skipped.
People-evidence is public-profiles-and-quotes only.

Produce a separate PDF per problem at every stage, with charts/tables, plus a Master_Index.pdf.
Present the master index first, then per-problem reports. Proceed without asking for
confirmation on file writes. If a problem's evidence is too thin, kill it and record why.
```

The orchestrator pauses once after discovery. Reply e.g. `keep p01, p03, p04, drop the rest, continue`.

### Run a single stage

```
Run problem-discovery on the "remote team onboarding" space — find what people publicly complain about.
```
```
Use competitor-analysis for "AI invoice-chasing for freelancers" — exhaustive gap list, top 5 deep-profiled.
```
```
Use market-sizing for "[problem]" — include the case against it, with charts.
```

### De-risked first run

```
Use the market-research-orchestrator skill but run discovery only for now. Domain: [X]. Scope: [Y].
Stop after discovery and show me the problem list with sourcing quality.
```

---

## Tips

- **Narrow domains win.** "Freelance video editors" beats "freelancers" — sharper complaints, cleaner market size.
- **Long runs.** Five stages × five problems is heavy. You can split: stop after `competitor-analysis`, then resume with `continue with market-sizing and solution-design`.
- **Thin results are a feature.** The skills refuse to fabricate. A killed problem with documented reasons is a valid outcome.
- **Local markets (e.g. Nepal):** web search surfaces less local-language content, so sourcing may be thinner — that reflects search coverage, not absence of opportunity.

---

## Output

All artifacts land in a run folder: `market-run-<YYYYMMDD-HHMM>/`, containing the per-stage JSON files, per-problem PDFs, and `Master_Index.pdf`.

---

## License

MIT — see [LICENSE](LICENSE).

## Disclaimer

These skills automate research using web search; outputs are only as current and accurate as the sources found. Always verify load-bearing figures against primary sources before making decisions. Not financial, legal, or investment advice.
