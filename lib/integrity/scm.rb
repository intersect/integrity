module Integrity
  module SCM
    class SCMUnknownError < StandardError; end
    class << self
      def new(uri, *args)
        scm_class_for(uri).new(uri, *args)
      end
      
    private
      
      def scm_class_for(string)
        UrlParser.parse(string)
      end
    end
    
    class UrlParser
      def self.parse(an_object)
        new(an_object).parse
      end
      
      def initialize(an_object)
        @string = an_object.to_s
      end
      
      def parse
        if @string =~ /git/i
          Integrity::SCM::Git
        else
          raise SCMUnknownError, "could not find any SCM based on string '#{@string}'"
        end
      end
    end
  end
end
