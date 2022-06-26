class Podcast < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content

  acts_as_taggable

  def embed_code
    "<iframe title=\"Libsyn Player\" style=\"border: none\" src=\"//html5-player.libsyn.com/embed/episode/id/#{libsyn_id}/height/90/theme/custom/thumbnail/no/direction/forward/render-playlist/no/custom-color/000000/\" height=\"90\" width=\"100%\" scrolling=\"no\"  allowfullscreen webkitallowfullscreen mozallowfullscreen oallowfullscreen msallowfullscreen></iframe>"
  end
end
