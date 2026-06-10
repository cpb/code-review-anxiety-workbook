# app/

## Routes

| Method | Path | Controller#action | UI surface |
|---|---|---|---|
| `GET` | `/` | `WorkbookSessionsController#new` | Intro page with "Get Started" button |
| `POST` | `/workbook_sessions` | `WorkbookSessionsController#create` | Creates session, redirects to edit |
| `GET` | `/workbook_sessions/:id/edit` | `WorkbookSessionsController#edit` | Step wizard — renders current step partial |
| `PATCH` | `/workbook_sessions/:id` | `WorkbookSessionsController#update` | Processes step data, advances or goes back |
| `POST` | `/workbook_sessions/:workbook_session_id/thinking_traps` | `ThinkingTrapsController#create` | Enqueues evaluation job, responds with Turbo Stream |
| `GET` | `/up` | `Rails::HealthController#show` | Health check |

## Key behaviour

`WorkbookSessionsController` manages a multi-step CBT wizard. Steps are defined in `WorkbookSession::STEPS`. The `update` action processes step-specific params, determines the next step (conditionally skipping TIPP if SUDS < 7), and responds with a Turbo Stream replacement.

`ThinkingTrapsController#create` enqueues `ThinkingTrapEvaluationJob` with a 1-second delay. The job evaluates the submitted traps, creates a `ThinkingTrapEvaluation` record, and broadcasts a Turbo Stream to the session channel.

## Key UI elements

- **Intro page**: `workbook_sessions/new.html.erb` — "Get Started" button, animated bullet list
- **Step wizard**: `workbook_sessions/edit.html.erb` — renders `workbook_sessions/steps/_<step>.html.erb`
- **Step drawer**: `workbook_sessions/_step_drawer.html.erb` — navigation buttons (back/next/finish)
- **Thinking traps evaluation**: async — result appears via Turbo Stream in `#evaluation-result`
