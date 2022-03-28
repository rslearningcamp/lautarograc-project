task :code_analysis do
  sh 'bundle exec brakeman . -z -q'
  sh 'bundle exec rubocop'
  sh 'bundle exec reek app config lib'
  sh 'bundle exec rails_best_practices .'
end
