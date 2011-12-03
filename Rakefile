require 'rake'

desc "install the dot files into user's home directory"
task :install do
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
        print "overwrite #{target}? [ynaq] "
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

def replace_file(source, target)
  FileUtils::Verbose.rm_rf source
  link_file source, target
end

def link_file(source, target)
  FileUtils::Verbose.ln_sf source, target
end

desc "Update dotfiles"
task :update => :gitsubmodules

desc "Update git submodules"
task :gitsubmodules do
  sh "git submodule init"
  sh "git submodule update"
  sh "git submodule foreach git pull"
  sh "git submodule summary"
end
