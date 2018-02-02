task :deploy do
	sh "bundler install --path vendor/bundle"
	#sh "bower install"
	Rake::Task["migrations"].execute
end

task :migrations do
	sh "bundler exec sequel -m migrations/  sqlite://data/auth.db"
end

task :run do
	sh "bundler exec rackup -o 0.0.0.0 -p 2323"
end
