require 'rake'

desc "Install the dot files into user's home directory"
task :install do
  def replace_file(source, target)
    FileUtils::Verbose.rm_rf target
    link_file source, target
  end

  def link_file(source, target)
    FileUtils::Verbose.ln_sf source, target
  end

  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE].include? file
    source = File.expand_path file
    target = File.join(ENV['HOME'], ".#{file}")
    
    if File.exist?(target)
      if File.identical? source, target
        puts "identical #{target}"
      elsif replace_all
        replace_file(source, target)
      else
        system "diff", "-u", target, source
        print "overwrite #{target}? [ynadq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(source, target)
        when 'y'
          replace_file(source, target)
        when 'q'
          exit
        else
          puts "skipping #{target}"
        end
      end
    else
      link_file(source, target)
    end
  end
end

task :default => :update

desc "Update dotfiles"
task :update => [:"git:pull", :"submodules:update"]

desc "Push code"
task :push => :"git:push"

namespace :git do
  task :pull do
    sh "git fetch --all"
    sh "git pull"
  end

  task :push do
    sh "git push origin master"
    sh "git push zilium master"
  end
end

namespace :submodules do
  desc "Update git submodules"
  task :update do
    sh "git submodule init"
    sh "git submodule update --recursive"
    sh "git submodule summary"
  end

  desc "Add a submodule using URL."
  task :add do
    url = ENV['URL'] or abort "No URL given"
    path = File.basename(url).gsub ".git", ""
    sh "git submodule add #{url} vim/bundle/#{path}"
  end
end
