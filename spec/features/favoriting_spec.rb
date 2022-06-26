# scenario 'does not show non-favorited ebooks' do
#   expect(page).to have_content 'You have not favorited any Lead Magnets yet.'
# end

# scenario 'shows favorite ebooks', :js do
#   favorited_ebook = create :lead_magnet
#   Favorite.create(
#     user_id: user.id,
#     favoritable_id: favorited_ebook.id,
#     favoritable_type: 'LeadMagnet'
#   )

#   visit dashboard_path
#   find('#favorites-list tr a', text: favorited_ebook.title, wait: 10)
#   expect(page).to have_content favorited_ebook.title
# end
