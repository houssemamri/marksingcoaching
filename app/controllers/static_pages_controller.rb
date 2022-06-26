class StaticPagesController < ApplicationController
  # layout 'sales_page', only: :sales_page

  def home
    @articles = Article.where(published: true).limit(2)
    render 'static_pages/home/index'
  end

  def claim_discount
    render layout: false
  end

  def sales_page
    @needs_stripe = true
    @hide_navbar = true
    @ebooks = LeadMagnet.pluck(:title)
  end

  def ebooks
    @ebooks = LeadMagnet.all
    @hide_navbar = true
    render 'ebooks/index'
  end

  def terms
    @content = Content.find_by(identifier: 'terms')
  end

  def privacy
    @content = Content.find_by(identifier: 'privacy')
  end

  def content_licensing
    @content = Content.find_by(identifier: 'content_licensing')
  end
end
