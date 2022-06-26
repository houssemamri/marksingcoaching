xml.instruct!
xml.urlset(:xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9',
           'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
           'xsi:schemaLocation' => 'http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd') do
  xml.url do
    xml.loc root_url
    xml.priority 1.0
  end

  @articles.each do |article|
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article.updated_at.to_date.to_s(:db)
      xml.changefreq 'monthly'
      xml.priority 0.9
    end
  end

  @ebooks.each do |ebook|
    xml.url do
      xml.loc "#{ENV['HOST_URL']}marketplace/ebook/#{ebook.slug}"
      xml.lastmod '2020-07-09'
      xml.changefreq 'monthly'
      xml.priority 0.9
    end
  end
end
