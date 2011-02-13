Autotest.add_hook(:initialize) do |at|
  at.add_exception(%r{vendor/cache})

  at.add_mapping(%r%^vendor/engines/proposals/spec/(models|controllers|routing|views|helpers|mailers|requests|lib)/.*rb$%) { |filename, _|
    filename
  }
  at.add_mapping(%r%^vendor/engines/proposals/app/models/(.*)\.rb$%) { |_, m|
    ["vendor/engines/proposals/spec/models/#{m[1]}_spec.rb"]
  }
  at.add_mapping(%r%^vendor/engines/proposals/app/views/(.*)$%) { |_, m|
    at.files_matching %r%^vendor/engines/proposals/spec/views/#{m[1]}_spec.rb$%
  }
  at.add_mapping(%r%^vendor/engines/proposals/app/controllers/(.*)\.rb$%) { |_, m|
    if m[1] == "application"
      at.files_matching %r%^vendor/engines/proposals/spec/controllers/.*_spec\.rb$%
    else
      ["vendor/engines/proposals/spec/controllers/#{m[1]}_spec.rb"]
    end
  }
  at.add_mapping(%r%^vendor/engines/proposals/app/helpers/(.*)_helper\.rb$%) { |_, m|
    if m[1] == "application" then
      at.files_matching(%r%^vendor/engines/proposals/spec/(views|helpers)/.*_spec\.rb$%)
    else
      ["vendor/engines/proposals/spec/helpers/#{m[1]}_helper_spec.rb"] + at.files_matching(%r%^spec\/views\/#{m[1]}/.*_spec\.rb$%)
    end
  }
  at.add_mapping(%r%^vendor/engines/proposals/config/routes\.rb$%) {
    at.files_matching %r%^vendor/engines/proposals/spec/(controllers|routing|views|helpers)/.*_spec\.rb$%
  }
  at.add_mapping(%r%^vendor/engines/proposals/(spec/(spec_helper|support/.*)|config/(boot|environment(s/test)?))\.rb$%) {
    at.files_matching %r%^vendor/engines/proposals/spec/(models|controllers|routing|views|helpers)/.*_spec\.rb$%
  }
  at.add_mapping(%r%^vendor/engines/proposals/lib/(.*)\.rb$%) { |_, m|
    ["vendor/engines/proposals/spec/lib/#{m[1]}_spec.rb"]
  }
end


