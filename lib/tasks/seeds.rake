namespace :rubybits do
  desc 'Reload all seed content from db/seeds/tracks/*.yml'
  task seed: :environment do
    Rake::Task['db:seed'].invoke
    puts "[ok] loaded #{Track.count} tracks / #{LearningModule.count} modules / #{Lesson.count} lessons / #{Activity.count} activities"
  end
end
