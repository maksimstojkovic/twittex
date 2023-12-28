namespace :db do
  task mock: :environment do
    if Rails.env.development? then
      load Rails.root / 'db' / 'seeds' / 'mock.rb'
    end
  end
end