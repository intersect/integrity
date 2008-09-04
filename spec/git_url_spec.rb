require File.dirname(__FILE__) + "/spec_helper"

module Integrity
  describe GitUri do
    def to_git_uri(string)
      GitUri.new(string)
    end
    
    uris = [
      "rsync://host.xz/path/to/repo.git/",
      "rsync://host.xz/path/to/repo.git",
      "rsync://host.xz/path/to/repo.gi",
      "http://host.xz/path/to/repo.git/",
      "https://host.xz/path/to/repo.git/",
      "git://host.xz/path/to/repo.git/",
      "git://host.xz/~user/path/to/repo.git/",
      "ssh://[user@]host.xz[:port]/path/to/repo.git/",
      "ssh://[user@]host.xz/path/to/repo.git/",
      "ssh://[user@]host.xz/~user/path/to/repo.git/",
      "ssh://[user@]host.xz/~/path/to/repo.git",
      "host.xz:/path/to/repo.git/",
      "host.xz:~user/path/to/repo.git/",
      "host.xz:path/to/repo.git",
      "user@host.xz:/path/to/repo.git/",
      "user@host.xz:~user/path/to/repo.git/",
      "user@host.xz:path/to/repo.git",
      "user@host.xz:path/to/repo",
      "user@host.xz:path/to/repo.a_git"            
    ]
    
    uris.each do |uri|
      it "should parse the uri" do
        git_url = to_git_uri(uri)
        git_url.local_pathname.should == "path-to-repo"
      end
    end
  end
end
