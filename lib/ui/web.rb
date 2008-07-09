set :root,   Integrity.root / "lib/ui/web"
set :public, Integrity.root / "lib/ui/web/public"
set :views,  Integrity.root / "lib/ui/web/views"

get "/" do
  @projects = []
  show :home, :title => "projects"
end

get "/new" do
  show :new, :title => ["projects", "new project"]
end

get "/integrity.css" do
  header "Content-Type" => "text/css; charset=utf-8"
  sass :integrity
end

helpers do
  def show(view, options={})
    @title = breadcrumbs(*options[:title])
    $stdout.puts @title.inspect
    haml view
  end
  
  def pages
    @pages ||= [["projects", "/"], ["new project", "/new"]]
  end
  
  def breadcrumbs(*crumbs)
    crumbs[0..-2].map do |crumb|
      page_data = pages.detect {|c| c.first == crumb }
      %Q(<a href="#{page_data.last}">#{page_data.first}</a>)
    end + [crumbs.last]
  end
end
