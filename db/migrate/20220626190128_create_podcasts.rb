class CreatePodcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :podcasts, id: :uuid do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.datetime :published_on
      t.string :libsyn_id
      t.text :content

      t.timestamps
    end
  end
end
