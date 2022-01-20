# frozen_string_literal: true

require_relative "lib/image_downloader/version"

Gem::Specification.new do |spec|
  spec.name = "image_downloader"
  spec.version = ImageDownloader::VERSION
  spec.authors = ["Eduard Horiach"]
  spec.email = ["eduard.horiach@gmail.com"]

  spec.summary = "Library for image downloading"
  spec.description = "Library for image downloading"
  spec.homepage = "https://github.com/edlvj/image_downloader"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/edlvj/image_downloader"
  spec.metadata["changelog_uri"] = "https://github.com/edlvj/image_downloader/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dry-monads", "~> 1.4.0"
  spec.add_dependency "dry-configurable"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
