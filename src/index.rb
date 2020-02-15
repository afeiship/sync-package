#!/usr/bin/env ruby

require "fileutils"
require "thor"

class SyncPackage < Thor
  desc "sync DIR", "Sync for DIR"

  def sync(dir)
    FileUtils.cd(dir, :verbose => true) do
      system "ncu -u"
      system "npm version patch --no-git-tag-version --force"
      system "git add --all"
      system "git commit -m 'feat: update all packages to latest'"
      system "git push"
    end
  end
end

SyncPackage.start(ARGV)

# ruby index.rb sync /Users/feizheng/github/next-absolute-package
# thor install index.rb
# thor sync_package:sync /Users/feizheng/github/next-absolute-package