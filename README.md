# Code Review Anxiety Workbook

A CBT (Cognitive Behavioral Therapy) wizard that helps software engineers work through anxiety around code review.

## What it does

Walk through a guided workbook that helps you:
- Identify and rate distress around a specific code review situation
- Recognize cognitive distortions (thinking traps) present in your thoughts
- Reframe those thoughts using CBT techniques

Visit `/` after starting the server to begin a workbook session.

## Prerequisites

- Ruby (see `.ruby-version`)
- [Bundler](https://bundler.io/)

## Setup

```sh
bin/setup
```

## Running the app

```sh
bin/dev          # starts the dev server
bin/rails test   # runs the test suite
```

## Deployment

Deployed via [Kamal](https://kamal-deploy.org/) to `code-review-anxiety-workbook.cpb.ca`.

```sh
bin/kamal deploy
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the development workflow, worktree setup, and slash commands used to work on this project.
