task :deploy do
	sh "bundler install --path vendor/bundle"
	#sh "bower install"
	Rake::Task["migrations"].execute
end

task :migrations do
    sh "bundler exec sequel -m migrations/  sqlite://data/lilbloggy.db"
end

task :run do
	sh "bundler exec rackup -o 0.0.0.0 -p 2323"
end

task :new_vue do
	args = get_input
	name = args[0]
	path = "vue/#{name}.vue"
	new_component = File.read(".lilbloggy/new.vue")
	nc = new_component.split("{{NEW}}")
	output = "#{nc.first}#{name}#{nc.last}"
	File.write(path, output) 
	puts "created #{path}"
end

private

def get_input
    args = ARGV
    args.drop(1).each do |arg|
        task arg.to_sym do ; end
    end  
end