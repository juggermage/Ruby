require_relative "block3"

test_dir = File.join(__dir__, "..", "lab2_test")

update_last_run_v1(File.join(test_dir, "config.yml"))
rename_with_date_v1(test_dir)