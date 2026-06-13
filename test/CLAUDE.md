# test/

## Automated coverage

| Test file | What it covers |
|---|---|
| `test/models/workbook_session_test.rb` | `WorkbookSession` validations — requires `current_step` and `situation_description` |
| `test/models/thinking_trap_evaluation_test.rb` | `ThinkingTrapEvaluation` validations — requires `outcome`; accepts `submitted_traps` JSON array |
| `test/models/biased_thought_test.rb` | Placeholder — no assertions yet |
| `test/controllers/workbook_sessions_controller_test.rb` | Full request cycle: `GET /` returns intro page; `POST` creates session and redirects to `edit`; `PATCH` advances steps via Turbo Stream; low SUDS (<= 2) skips TIPP and jumps to `dear_give`; thinking trap submission enqueues `ThinkingTrapEvaluationJob` |
| `test/jobs/thinking_trap_evaluation_job_test.rb` | `ThinkingTrapEvaluationJob` outcome logic: Catastrophizing alone → `challenge`; Personalizing (alone or mixed) → `affirm` |
| `test/system/workbook_wizard_test.rb` | Intro page renders with "Get Started" button; clicking it advances to the SUDS/awareness step |
| `test/configuration/evaluation_configuration_test.rb` | LLM eval pipeline via `ruby_llm-evals`: `ExecuteSampleJob` creates a `PromptExecution`, stores result fields, and copies sample configuration |
| `test/evals/workbook_thinking_trap_eval_test.rb` | End-to-end eval of the thinking trap evaluation prompt against real LLM output |
| `test/evals/seed_round_trip_test.rb` | Eval fixture seed/load round-trip integrity |

## What needs manual confirmation

- **Turbo Stream broadcast timing**: The 1-second delay before `ThinkingTrapEvaluationJob` broadcasts is not exercised in tests.
- **WebSocket error paths**: No test covers Turbo Stream connectivity failures or reconnection.
- **Multi-worktree isolation**: That separate worktrees do not share ports, storage, or PIDs is not covered by automated tests.

## Test setup

- **System tests**: Falcon web server via Rackup, Capybara + headless Chrome (1400×1400), queue adapter switched to `:async_job` per test.
- **Unit / controller tests**: Standard Rails test queue (`:test` adapter, synchronous).
- **Eval tests**: Use VCR cassettes for HTTP interactions with the LLM API.

Run all tests with `bin/rails test`.
