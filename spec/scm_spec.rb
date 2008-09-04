require File.dirname(__FILE__) + '/spec_helper'

module Integrity
  describe SCM do
    describe 'when loading an SCM adapter' do
      before(:each) do
        @uri = Addressable::URI.parse('git://github.com/foca/integrity.git')
      end

      it 'should instantiate the adapter with the given options' do
        build = mock('build model')
        Integrity::SCM::Git.should_receive(:new).with(@uri, 'master', build)
        Integrity::SCM.new(@uri, 'master', build)
      end

      it "should raise an error if the handler can't be found" do
        lambda do
          Integrity::SCM.new("foo/bar")
        end.should raise_error(SCM::SCMUnknownError, "could not find any SCM based on string 'foo/bar'")
      end
    end
    
    describe SCM::UrlParser do
      before :each do
        @parser = SCM::UrlParser
      end
      
      it "should return Integrity::SCM::Git if the url contains git" do
        @parser.parse("git://fo/bar").should == Integrity::SCM::Git
      end
      
      it "should return Integrity::SCM::Git if the url contains 'GIT'" do
        @parser.parse("GIT://fo/bar").should == Integrity::SCM::Git
      end
      
      it "should raise an SCMUnknownError if the url doesn't contain git" do
        lambda { 
          @parser.parse("foo")
        }.should raise_error(SCM::SCMUnknownError)
      end
    end
  end
end
