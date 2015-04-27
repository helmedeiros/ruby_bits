module Seeds
  # Reads every YAML file under db/seeds/tracks/*.yml and upserts
  # tracks → modules → lessons → activities.
  class Loader
    def initialize(root)
      @root = Pathname(root)
    end

    def call
      Dir[@root.join('tracks', '*.yml')].sort.each { |path| import(YAML.load_file(path)) }
    end

    private

    def import(data)
      track = Track.find_or_initialize_by(slug: data.fetch('slug'))
      track.assign_attributes(name: data['name'], description: data['description'], position: data['position'].to_i)
      track.save!

      (data['modules'] || []).each_with_index { |m, i| import_module(track, m, i) }
    end

    def import_module(track, data, idx)
      mod = track.modules.find_or_initialize_by(slug: data.fetch('slug'))
      mod.assign_attributes(name: data['name'], overview: data['overview'], position: data['position'] || idx)
      mod.save!

      (data['lessons'] || []).each_with_index { |l, i| import_lesson(mod, l, i) }
    end

    def import_lesson(mod, data, idx)
      lesson = mod.lessons.find_or_initialize_by(slug: data.fetch('slug'))
      lesson.assign_attributes(title: data['title'], body: data['body'], position: data['position'] || idx)
      lesson.save!

      (data['activities'] || []).each_with_index { |a, i| import_activity(lesson, a, i) }
    end

    def import_activity(lesson, data, idx)
      activity = lesson.activities.find_or_initialize_by(title: data.fetch('title'))
      activity.assign_attributes(
        kind: data['kind'] || 'code',
        prompt: data['prompt'],
        starter_code: data['starter_code'],
        solution: data['solution'],
        spec_code: data['spec_code'],
        choices: data['choices'],
        correct_choice: data['correct_choice'],
        position: data['position'] || idx
      )
      activity.save!
    end
  end
end
