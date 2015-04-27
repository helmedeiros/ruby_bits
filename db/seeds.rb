require File.expand_path('../seeds/loader', __FILE__)
Seeds::Loader.new(Rails.root.join('db', 'seeds')).call
