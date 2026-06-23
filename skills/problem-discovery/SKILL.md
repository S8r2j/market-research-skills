---
name: problem-discovery
description: Discover and categorize REAL problems that people are publicly complaining about across social and web platforms — Reddit, X/Twitter, LinkedIn, Threads, Facebook groups, forums, newsletters, blogs, communities, app-store reviews, and Q&A sites — for a founder hunting validated pain points. Use whenever the user wants to "find problems people are facing", "discover pain points", "what are people complaining about in X", "find startup ideas grounded in real complaints", or kicks off the market-research pipeline. Always favor verbatim public complaints with source URLs over speculation; this skill is the evidence-gathering front door, not idea brainstorming.
---

# Problem Discovery

Goal: produce a categorized list of REAL, publicly-stated problems, each backed by multiple verbatim complaints with URLs. Output `01_problems.json` + `Discovery_Report.pdf`.

Read `references/STANDARDS.md` first. No problem enters the list without at least 3 independent public sources stating it.

## Method
1. **Define the hunting ground.** From the user's domain (or open), list 8–15 search angles and platforms to sweep.
2. **Sweep broadly with web_search**, platform by platform. Useful query shapes:
   - `site:reddit.com <domain> "i hate" OR "frustrated" OR "wish there was"`
   - `site:reddit.com/r/<subreddit> rant OR struggling`
   - `<domain> "biggest problem" OR "pain point" 2025..2026`
   - app store / G2 / Trustpilot 1–2 star reviews for incumbent tools
   - `site:news.ycombinator.com <domain> "the problem with"`
   - newsletter/blog round-ups of complaints; LinkedIn & X via web_search of public posts
3. **web_fetch the strongest hits** to capture the actual verbatim complaint, author handle if public, date, and URL. Snippets alone are not enough.
4. **Cluster into categories.** Group raw complaints into distinct problem statements. Merge duplicates; split conflated ones.
5. **Score each problem** on: frequency (independent mentions), intensity (language severity), recency, and whether incumbents already solve it well.
6. **Discard** anything with fewer than 3 independent sources or that is purely one person's gripe — record discards with reason.

## Output schema — `01_problems.json`
```json
{
  "run_meta": {"domain": "...", "geography": "...", "generated": "ISO8601"},
  "problems": [
    {
      "problem_id": "p01-short-slug",
      "title": "One-sentence problem statement",
      "category": "e.g. Workflow / Cost / Trust / Access",
      "who_is_affected": "the population, in their own framing",
      "evidence": [
        {"platform":"reddit","url":"...","handle":"u/...","quote":"<15-word verbatim","date":"...","accessed":"..."}
      ],
      "frequency_signal": "N independent sources across M platforms",
      "intensity": "low|medium|high + why",
      "incumbent_gap": "what existing tools miss, with URL",
      "confidence": "high|medium|low"
    }
  ],
  "discarded": [{"title":"...","reason":"<3 sources / single gripe / unverifiable"}]
}
```

## PDF — `Discovery_Report.pdf`
Build via the `pdf` skill. Include: a category-breakdown bar chart (problems per category), a frequency table (problem × source count × platforms), and per-problem evidence cards with clickable URLs. Copyright: quotes <15 words, one per source. End with Sources appendix + discards list.

Then hand `01_problems.json` to the orchestrator and STOP for user triage before deep research.
