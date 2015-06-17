```
   ______        __         ___  _ __
  / __  /__ __  / /_  __ __/ _ )(_) /____
 / /_/ // // / / __ \/ // / _  / / __(_-<
/_,___/ \_, / /_/_/\_\\_, /____/_/\__/___/
       /___/         /___/
```

> a terminal where you learn ruby by typing it

[![Build Status](https://travis-ci.org/helmedeiros/ruby_bits.svg?branch=master)](https://travis-ci.org/helmedeiros/ruby_bits)
[![Code Climate](https://codeclimate.com/github/helmedeiros/ruby_bits/badges/gpa.svg)](https://codeclimate.com/github/helmedeiros/ruby_bits)
[![Coverage Status](https://coveralls.io/repos/helmedeiros/ruby_bits/badge.svg?branch=master)](https://coveralls.io/r/helmedeiros/ruby_bits)
[![Pages](https://img.shields.io/badge/github-pages-00ff41.svg)](https://helmedeiros.github.io/ruby_bits/)

**RubyBits** is a small Rails 4.2 platform that teaches ruby through
short, runnable lessons. Each module steps you through one idiom —
inline `if`, `||=`, `attr_*`, blocks, `Enumerable`, `Concern`, and so
on — and ends with **activities** that execute your code in a sandboxed
subprocess and report pass / fail.

A static showcase of the same content runs on GitHub Pages: <https://helmedeiros.github.io/ruby_bits/>.

## stack

| layer        | choice                                  |
|--------------|------------------------------------------|
| ruby         | 2.2.1                                    |
| framework    | Rails 4.2.1                              |
| storage      | PostgreSQL + Redis (Sidekiq jobs)        |
| views        | ERB + Sass + CoffeeScript + jQuery       |
| editor       | CodeMirror 5 (matrix theme)              |
| markdown     | Redcarpet 3 + Rouge highlighter          |
| auth / authz | Devise 3.5 + Pundit 1.0                  |
| pagination   | Kaminari 0.16                            |
| testing      | RSpec 3.2 + Capybara + FactoryGirl       |
| static site  | Jekyll 2.x (gh-pages branch)             |

Period-faithful: every dependency above shipped before mid-2015 and
the design uses only CSS3 effects (`@keyframes`, `transition`,
`box-shadow`, flexbox) and a tiny `canvas` 2D draw — no CSS Grid,
no custom properties, no Web Components.

## structure

```
Track ─┬─ LearningModule ─┬─ Lesson ─┬─ Activity (code | choice)
       │                  │          │
       │                  │          └─ Submission per user (graded)
       │                  └─ Comment thread
       └─ Position-ordered, slug-routed
```

- Content lives in `db/seeds/tracks/*.yml` and is loaded by
  `Seeds::Loader` (`rake rubybits:seed`).
- `code` activities ship `starter_code`, `solution`, and `spec_code`
  (which `raise`s when the user's code is wrong). They run inside
  `Sandbox::RubyRunner` — a 5-second `Open3`/`Timeout` subprocess.
- `choice` activities ship a YAML map of `choices` plus a
  `correct_choice` key.
- Progress is tracked per user via `Completion`, with `StreakUpdater`
  and `BadgeGrantor` reacting to each passing submission.

## boot

```sh
bundle install
rake db:setup
rake rubybits:seed           # YAML tracks under db/seeds/tracks/
rake rubybits:import_legacy  # absorb the original level_* dirs
foreman start                # web (puma) + worker (sidekiq)
```

Open <http://localhost:3000>.

## quality gates

The 2015-faithful local gate is a single rake task:

```sh
bundle exec rake ci          # syntax + yaml + rubocop + rspec
```

Each sub-task is independently runnable and tolerant of revisions
where a tool is not yet present:

| task               | what it does                                   |
|--------------------|------------------------------------------------|
| `rake ci:syntax`   | `ruby -c` every tracked `.rb`                  |
| `rake ci:yaml`     | `YAML.load_file` every tracked `.yml`          |
| `rake ci:rubocop`  | `bundle exec rubocop` if `.rubocop.yml` exists |
| `rake ci:rspec`    | `bundle exec rspec`  if `spec/` is wired       |

A reduced version of the gate also runs on Travis CI
(see `.travis.yml`). Code Climate + Coveralls configs are in
`.codeclimate.yml` and `spec/spec_helper.rb`.

## design

Black background, neon green text, CRT scanline + flicker, terminal
frame with a faux `xterm` title bar, blinking cursor.

```
+--------------------------------------------------+
| RubyBits — /usr/local/bin/irb                    |
+--------------------------------------------------+
| RubyBits     [tracks] [leaderboard] [~/alice]    |
| ------------------------------------------------ |
| » cd expressions && ls                           |
|                                                  |
| ├─ [01] Inline if                                |
| ├─ [02] unless — the negated if                  |
| └─ [03] Conditional assignment                   |
|                                                  |
| _                                                |
+--------------------------------------------------+
```

## github pages

The `gh-pages` branch holds a Jekyll 2.x site (no markdown files —
all pages are `.html` with front-matter, content driven by
`_data/tracks.yml`). It is served at
<https://helmedeiros.github.io/ruby_bits/>.

To preview locally:

```sh
git worktree add ../ruby_bits-pages gh-pages
cd ../ruby_bits-pages
bundle install
bundle exec jekyll serve --baseurl /ruby_bits
```

## contributing

Add a new track by dropping a YAML file under `db/seeds/tracks/`:

```yaml
slug: my-track
name: My Track
description: One-line summary.
position: 9
modules:
  - slug: my-module
    name: My Module
    overview: |
      One paragraph rendered above the lesson list.
    lessons:
      - slug: my-lesson
        title: My Lesson
        body: |
          ## My Lesson
          Markdown body. Fenced ruby blocks get Rouge highlight.
        activities:
          - title: do the thing
            kind: code           # or 'choice'
            difficulty: 2
            prompt: |
              What the learner reads above the editor.
            starter_code: |
              def thing
              end
            solution: |
              def thing
                :ok
              end
            spec_code: |
              raise 'nope' unless thing == :ok
            hints:
              - first, look at the return value
              - the spec checks for the symbol :ok
```

Activity invariants:

- `spec_code` **must** `raise` on failure; finishing without raising
  counts as success.
- Stdlib only — the sandbox subprocess runs `ruby --disable=gems`.
- Keep runtime under the 5-second sandbox cap.

Then:

```sh
rake rubybits:seed
rake ci
```

## license

MIT — see `LICENSE`.
