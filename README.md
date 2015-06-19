# RubyBits

> a terminal where you learn ruby by typing it

[![Build Status](https://travis-ci.org/helmedeiros/ruby_bits.svg?branch=master)](https://travis-ci.org/helmedeiros/ruby_bits)
[![Code Climate](https://codeclimate.com/github/helmedeiros/ruby_bits/badges/gpa.svg)](https://codeclimate.com/github/helmedeiros/ruby_bits)
[![Coverage Status](https://coveralls.io/repos/helmedeiros/ruby_bits/badge.svg?branch=master)](https://coveralls.io/r/helmedeiros/ruby_bits)
[![Pages](https://img.shields.io/badge/github-pages-00ff41.svg)](https://helmedeiros.github.io/ruby_bits/)

**RubyBits** is a small Rails 4.2 platform that teaches Ruby through
short, runnable lessons. Each lesson explains one idea and ends with
**activities** — code or multiple-choice — that execute the learner's
code in a sandboxed subprocess and report pass / fail.

A static showcase of the same content runs on GitHub Pages: <https://helmedeiros.github.io/ruby_bits/>.

## curriculum

The platform ships with two macro-tracks that learners walk in order:

1. **Ruby Basics** — values, collections, control flow, methods.
2. **OO Design** — the design principles from Sandi Metz's *Practical
   Object-Oriented Design in Ruby* (POODR): single responsibility,
   managing dependencies, interfaces, duck typing, inheritance, and
   composition. Lessons use original examples that illustrate each
   principle without reproducing material from the book.

Adding more tracks is a matter of dropping a YAML file under
`db/seeds/tracks/`; see [contributing](#contributing).

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

Every dependency above shipped before mid-2015.

## domain model

- `Track` → `LearningModule` → `Lesson` → `Activity` (`code` or
  `choice`), each ordered by `position` and routed by `slug`.
- A `Submission` records each attempt by a `User`; a `Completion`
  marks a lesson done when every activity in it has a passing
  submission.
- A discussion thread (`Comment`) hangs off each lesson.
- `StreakUpdater` and `BadgeGrantor` react to passing submissions to
  maintain user streaks and award badges.

Source: `db/seeds/tracks/*.yml`, loaded by `Seeds::Loader` via `rake
rubybits:seed`. Code activities run inside `Sandbox::RubyRunner`,
a 5-second `Open3`/`Timeout` subprocess.

## boot

```sh
bundle install
rake db:setup
rake rubybits:seed           # YAML tracks under db/seeds/tracks/
foreman start                # web (puma) + worker (sidekiq)
```

Open <http://localhost:3000>.

## quality gates

The local quality gate is a single rake task:

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

A reduced version of the gate also runs on Travis CI (see
`.travis.yml`). Code Climate + Coveralls configs are in
`.codeclimate.yml` and `spec/spec_helper.rb`.

## github pages

The `gh-pages` branch holds a Jekyll 2.x site (no markdown files —
all pages are `.html` with front-matter, content driven by
`_data/tracks.yml`). It is served at
<https://helmedeiros.github.io/ruby_bits/> and runs every activity
**in the browser** via Opal (the Ruby-to-JS compiler), so learners
can practise without a backend.

Local preview:

```sh
git worktree add ../ruby_bits-pages gh-pages
cd ../ruby_bits-pages
bundle install
bundle exec jekyll serve --baseurl /ruby_bits
```

Smoke + content tests for the live site:

```sh
ruby _test/smoke_test.rb                                  # against the live URL
BASE=http://localhost:4000/ruby_bits ruby _test/smoke_test.rb   # local
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
