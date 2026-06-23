# Shared Standards (read by every market-research skill)

These rules are NON-NEGOTIABLE and apply to all seven skills in this suite.

## 1. Evidence rule — "Brutally right, no hypothesis"
- **Every factual claim MUST carry a source URL.** No URL = the claim is deleted, not softened.
- Distinguish three tiers explicitly in output:
  - `[VERIFIED]` — stated directly in a retrieved source, quoted/paraphrased with URL.
  - `[INFERRED]` — a calculation or synthesis you performed FROM verified inputs. Show the inputs and the math.
  - `[UNKNOWN]` — could not be sourced. Say so. Never fill the gap with a guess.
- A number with no traceable origin is a hallucination. Kill it.
- If sources conflict, report BOTH with their URLs and dates. Do not average silently.
- Always record the access date for every source.

## 2. Adversarial completeness (market sizing especially)
- Report data FOR the thesis and AGAINST it with equal weight. Disconfirming evidence is mandatory, not optional.
- A section titled "Evidence against this opportunity" must appear in every market-sizing and solution report. If you found none, state that you searched and found none, and list what you searched.

## 3. Privacy boundary (people-evidence skill)
- Only capture information the person published publicly themselves: public post URL, public handle/profile link, and a short verbatim quote of the problem they stated.
- NEVER harvest, guess, or construct private emails, phone numbers, or home info.
- If a public profile lists a business contact the person posted for outreach (e.g. "DM me" / a public work email in a bio), it may be recorded with its source URL. Otherwise leave contact as "public profile only".

## 4. Source quality ranking (prefer top, distrust bottom)
1. Primary data: gov stats, regulatory filings, company reports, peer-reviewed papers, census.
2. Reputable industry reports & established news.
3. Vendor/analyst reports (note the commercial bias).
4. Community signal: Reddit, X, LinkedIn, forums, Facebook/Threads groups — strong for *problem discovery*, weak for *quantification*. Use community for "what hurts", use primary data for "how big".
- Treat SEO'd "market size" blog posts as leads to chase to the primary source, never as the source itself.

## 5. Output: every step produces a PDF
- Each skill builds a PDF report into the run folder using the `pdf` public skill (read `/mnt/skills/public/pdf/SKILL.md` first).
- Charts/tables/graphs are REQUIRED wherever data is quantitative. Use matplotlib for charts, render tables natively. No wall-of-text where a table or chart fits.
- Each PDF must contain a "Sources" appendix listing every URL with access date, and a "Confidence & gaps" section listing every `[UNKNOWN]`.

## 6. Run folder & handoff contract
- All skills operate inside one run folder: `/mnt/user-data/outputs/market-run-<YYYYMMDD-HHMM>/`.
- Each skill READS the prior skill's JSON output and WRITES its own. Never re-invent upstream data — load it.
- Canonical files:
  - `01_problems.json` (discovery)
  - `02_research/<problem_id>.json` (deep research, one per problem)
  - `03_people/<problem_id>.json` (evidence people)
  - `competitors/<problem_id>.json` (competitor analysis)
  - `04_market/<problem_id>.json` (sizing)
  - `05_solutions/<problem_id>.json` (solutions)
- `problem_id` is a stable slug, e.g. `p01-freelancer-invoice-chasing`.
