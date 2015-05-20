require File.expand_path('../seeds/loader', __FILE__)
Seeds::Loader.new(Rails.root.join('db', 'seeds')).call

# Badge catalogue
require "yaml"
file = Rails.root.join("db/seeds/badges.yml")
if file.exist?
  YAML.load_file(file).each do |row|
    Badge.find_or_create_by!(slug: row["slug"]) do |b|
      b.name = row["name"]; b.description = row["description"]; b.icon_glyph = row["icon_glyph"]
    end
  end
end
