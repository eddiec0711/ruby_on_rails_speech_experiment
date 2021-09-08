class PagesController < ApplicationController

  skip_authorization_check

  def home
    @current_nav_identifier = 'home'
  end
  
  def contact_us
    @current_nav_identifier = 'contact_us'
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)

    file = File.open("public/CONTACT_US.md")
    @content = markdown.render(file.read)
  end

  def documentation
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)

    file = File.open("public/USER_DOCUMENTATION.md")
    @content = markdown.render(file.read)
  end

end
