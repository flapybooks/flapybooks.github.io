require 'webrick'

desc "Launch preview environment"
task :preview do
  system 'bundle exec middleman'
end

desc 'Preview the build'
task :peek do
  root = File.expand_path './build'
  server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
  trap 'INT' do server.shutdown end
  server.start
end

desc 'Deploy to GitHub Pages'
task :deploy do
  puts 'Push to `master`'
  system "git push origin master"
  puts
  puts 'Push to `gh-pages`'
  system 'NO_CONTRACTS=true bundle exec middleman build'
  puts
  cd 'build' do
    system "git add -A"
    system "git commit -m 'Deploy at #{Time.now.utc}'"
    puts
    system 'git push origin gh-pages'
  end
end

desc 'Alias to :deploy'
task :d => :deploy
task :push => :deploy

desc 'Alias to :preview'
task :s => :preview

desc 'Alias to :preview'
task :server => :preview

desc 'Alias to :preview'
task :default => :preview
