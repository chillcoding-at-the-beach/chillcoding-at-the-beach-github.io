module Jekyll
  module RymaiBlogPost
    RYMAI_BLOG_ROOT = 'https://www.rymai.me'.freeze

    def originally_posted_on_rymai_blog(input)
      %(<em>This post was originally posted at <a href="#{original_post_url(input)}">#{original_post_url(input)}</a>.</em>)
    end

    private

    def original_post_url(current_path)
      "#{RYMAI_BLOG_ROOT}#{current_path.sub(%r{\A/blog}, '')}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::RymaiBlogPost)
