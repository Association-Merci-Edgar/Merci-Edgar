json.reportings do
  json.id @reporting.id
  json.created_at @reporting.created_at
  json.project @reporting.project_id
  json.asset_id @reporting.asset_id
  json.asset_type @reporting.asset_type
  json.note_report_content @reporting.report.content
  json.user @reporting.user.id
end