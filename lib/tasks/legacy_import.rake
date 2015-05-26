namespace :rubybits do
  desc 'Import legacy level_* directories into the Expressions seed'
  task import_legacy: :environment do
    Dir.glob(Rails.root.join('level_*')).sort.each do |dir|
      level = File.basename(dir).sub('level_', '').to_i
      track = Track.find_or_create_by!(slug: "legacy-level-#{level}") do |t|
        t.name        = "Legacy Level #{level}"
        t.description = "Imported from #{File.basename(dir)}"
        t.position    = 100 + level
      end
      Dir.glob(File.join(dir, '*')).select { |f| File.directory?(f) }.sort.each_with_index do |sub, idx|
        name = File.basename(sub).tr('_', ' ')
        mod  = track.modules.find_or_create_by!(slug: File.basename(sub)) do |m|
          m.name = name.capitalize; m.position = idx
        end
        readme = Dir.glob(File.join(sub, '*.{rb,md,txt}')).sort.first
        next unless readme
        body = File.read(readme)
        mod.lessons.find_or_create_by!(slug: 'overview') do |l|
          l.title = name.capitalize
          l.body  = "```ruby\n#{body}\n```\n"
        end
      end
      puts "  ↳ imported #{File.basename(dir)} into #{track.slug}"
    end
  end
end
