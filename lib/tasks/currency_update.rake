namespace :currency do
  desc "Update currency task"

  task :update_rates do
    Currency.update_rates!
  end
end
