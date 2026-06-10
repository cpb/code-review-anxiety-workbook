ActiveRecord::FixtureSet.create_fixtures(
  Rails.root.join("evals"),
  %w[
    workbook/prompts workbook/samples workbook/runs workbook/executions
  ]
)
