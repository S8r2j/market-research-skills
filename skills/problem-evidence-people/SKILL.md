---
name: problem-evidence-people
description: For a single problem, find at least 5 real people who publicly stated they face it, capturing only their public handle/profile link and a short verbatim quote as proof — strictly privacy-respecting outreach leads, no private emails or scraped contact data. Use after deep research, whenever the user wants "find people who have this problem", "who is complaining about this", "proof that real people face this", "people I could interview or reach out to", or runs the people-evidence stage. This skill records public evidence of affected individuals for founder validation/outreach, never compiles private personal data.
---

# Problem Evidence People

Goal: for ONE problem, surface **at least 5 real, distinct people** who publicly described facing it, with proof. Output `03_people/<problem_id>.json` + `<problem_id>_People.pdf`.

Read `references/STANDARDS.md` first — section 3 (privacy boundary) governs this entire skill.

## Hard privacy rules
- Capture ONLY what the person published themselves: public post URL, public handle / profile link, short verbatim quote (<15 words), platform, date.
- Contact field = the public profile link, OR a contact the person *explicitly published for outreach* WITH its source URL. Otherwise contact = `"public profile only"`.
- NEVER guess, construct, or scrape private emails, phone numbers, or addresses. A fabricated contact is a critical failure.
- 5 distinct individuals — not 5 posts from one person. Verify distinctness via handle/profile.

## Method
- Pull the problem's evidence from `01_problems.json` and `02_research` to seed handles already found.
- `web_search` for more public first-person statements across Reddit, X, public LinkedIn posts, Threads, forums, app-store reviews, Q&A sites.
- Favor query shapes like: `site:reddit.com <problem phrase> "i" "my"` to find first-person accounts.
- `web_fetch` each to confirm the person is genuinely describing THIS problem and to capture the verbatim line + public profile URL.
- Note for each: match strength, and whether they appear open to contact.

## Output schema — `03_people/<problem_id>.json`
```json
{
  "problem_id":"...","title":"...",
  "people":[
    {
      "ref":"person-1",
      "platform":"reddit|x|linkedin|threads|forum|appstore",
      "public_handle":"u/... or @... or display name",
      "profile_url":"...",
      "quote":"<15-word verbatim of their problem",
      "post_url":"...","date":"...","accessed":"...",
      "match_strength":"exact|strong|adjacent",
      "contact":"public profile only | <published-outreach-contact + source url>",
      "openness_signal":"e.g. 'asked for recommendations' (url) | none"
    }
  ],
  "note":"contacts are public-only per privacy policy"
}
```

## PDF — `<problem_id>_People.pdf`
Via the `pdf` skill. A clean table: person × platform × handle (linked) × quote × match strength × contact. Add a small platform-distribution chart. Footer states the privacy policy applied. Quotes <15 words each.

If fewer than 5 genuine matches exist, report exactly how many were found and what was searched — do NOT pad with weak or invented entries.
