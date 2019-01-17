#we will keep before/after methods
Before do |scenario|
  scenario_location_file_name = scenario.location.file.split('/').last.gsub('.feature', '')
  # $intake_request_file_name = ("#{scenario_location_file_name.humanize} #{$test_run_id}")
end