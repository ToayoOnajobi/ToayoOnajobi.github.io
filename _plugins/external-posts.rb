require 'feedjira'
require 'httparty'
require 'jekyll'
require 'nokogiri'
require 'time'

module ExternalPosts
  class ExternalPostsGenerator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      return unless site.config['external_sources']

      site.config['external_sources'].each do |src|
        puts "Fetching external posts from #{src['name']}:"
        if src['rss_url']
          safe_fetch_from_rss(site, src)
        elsif src['posts']
          safe_fetch_from_urls(site, src)
        end
      end
    end

    private

    # Safe RSS fetch: skips feed if it fails
    def safe_fetch_from_rss(site, src)
      begin
        xml = HTTParty.get(src['rss_url']).body
        return unless xml
        feed = Feedjira.parse(xml)
        process_entries(site, src, feed.entries) if feed && feed.entries
      rescue StandardError => e
        Jekyll.logger.warn "ExternalPosts:", "Skipping #{src['rss_url']} due to error: #{e.message}"
      end
    end

    def process_entries(site, src, entries)
      entries.each do |e|
        puts "...fetching #{e.url}"
        create_document(site, src['name'], e.url, {
          title: e.title.to_s,
          content: e.content.to_s,
          summary: e.summary.to_s,
          published: e.published
        })
      end
    end

    def create_document(site, source_name, url, content)
      slug = content[:title].to_s.gsub(/[^\w]/, '').strip
      if slug.empty?
        slug = "#{source_name.downcase.strip.gsub(' ', '-')}-#{url.split('/').last}"
      end

      path = site.in_source_dir("_posts/#{slug}.md")
      doc = Jekyll::Document.new(
        path, { site: site, collection: site.collections['posts'] }
      )

      doc.data['external_source'] = source_name
      doc.data['title'] = content[:title]
      doc.data['feed_content'] = content[:content]
      doc.data['description'] = content[:summary]
      doc.data['date'] = content[:published]
      doc.data['redirect'] = url
      doc.content = content[:content]

      site.collections['posts'].docs << doc
    end

    # Safe manual URL fetch: skips post if it fails
    def safe_fetch_from_urls(site, src)
      src['posts'].each do |post|
        begin
          puts "...fetching #{post['url']}"
          content = fetch_content_from_url(post['url'])
          content[:published] = parse_published_date(post['published_date'])
          create_document(site, src['name'], post['url'], content)
        rescue StandardError => e
          Jekyll.logger.warn "ExternalPosts:", "Skipping #{post['url']} due to error: #{e.message}"
        end
      end
    end

    def parse_published_date(published_date)
      case published_date
      when String
        Time.parse(published_date).utc
      when Date
        published_date.to_time.utc
      else
        nil
      end
    end

    def fetch_content_from_url(url)
      html = HTTParty.get(url).body
      parsed_html = Nokogiri::HTML(html)

      title = parsed_html.at('head title')&.text.to_s.strip
      description = parsed_html.at('head meta[name="description"]')&.attr('content') ||
                    parsed_html.at('head meta[name="og:description"]')&.attr('content') ||
                    parsed_html.at('head meta[property="og:description"]')&.attr('content') ||
                    ''
      body_content = parsed_html.search('p').map(&:text).join()

      {
        title: title,
        content: body_content,
        summary: description
      }
    end
  end
end
