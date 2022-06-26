function toggleFavorite(e) {
  e.preventDefault()
  var contractId = e.target.parentElement.dataset.ebookId
  var favoriteEndpoint = '/lead_magnets/' + contractId + '/favorite'
  $('#favorite-ebook-' + contractId).load(
    favoriteEndpoint, function (e) {
    }
  );
}
