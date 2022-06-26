$(document).on('DOMContentLoaded', function () {
  var $copyContainers = $('.copyable-content-container');
  $copyContainers.each(function () {
    $(this).find('.copy-link').on('click', function (event) {
      $(event.target).text(function () { return "Copied!" })

      var toBeCopied = $(this).find('.copyable-content').text()

      var $temp = $("<input>");
      $("body").append($temp);
      $temp.val(toBeCopied).select();
      document.execCommand("copy");
      $temp.remove();
    }.bind(this))
  })
})
