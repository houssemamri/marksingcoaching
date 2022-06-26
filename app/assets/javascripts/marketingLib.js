$(function () {
  "use strict";
  //===== Sticky Top Navbar
  $(window).on('scroll', function (event) {
    var scroll = $(window).scrollTop();
    if (scroll < 20) {
      $(".navbar-area").removeClass("sticky");
      // $(".navbar .navbar-brand img").attr("src", "assets/images/logo_dark.svg");
    } else {
      $(".navbar-area").addClass("sticky");
      // $(".navbar .navbar-brand img").attr("src", "assets/images/logo-2.png");
    }
  });

  // //===== Section Menu Active
  // var scrollLink = $('.page-scroll');
  // // Active link switching
  // $(window).on('scroll', function () {
  //   var scrollbarLocation = $(this).scrollTop();

  //   scrollLink.each(function () {

  //     var sectionOffset = $(this.hash).offset().top - 73;

  //     if (sectionOffset <= scrollbarLocation) {
  //       $(this).parent().addClass('active');
  //       $(this).parent().siblings().removeClass('active');
  //     }
  //   });
  // });

  //===== close navbar-collapse when a  clicked
  $(".navbar-nav a").on('click', function () {
    $(".navbar-collapse").removeClass("show");
  });

  $(".navbar-toggler").on('click', function () {
    $(this).toggleClass("active");
  });

  $(".navbar-nav a").on('click', function () {
    $(".navbar-toggler").removeClass('active');
  });

  // //====== Magnific Popup
  // $('.video-popup').magnificPopup({
  //   type: 'iframe'
  //   // other options
  // });

  // //===== Magnific Popup
  // $('.image-popup').magnificPopup({
  //   type: 'image',
  //   gallery: {
  //     enabled: true
  //   }
  // });

  // //===== Back to top

  // // Show or hide the sticky footer button
  // $(window).on('scroll', function (event) {
  //   if ($(this).scrollTop() > 600) {
  //     $('.back-to-top').fadeIn(200)
  //   } else {
  //     $('.back-to-top').fadeOut(200)
  //   }
  // });

  // //Animate the scroll to top
  // $('.back-to-top').on('click', function (event) {
  //   event.preventDefault();

  //   $('html, body').animate({
  //     scrollTop: 0,
  //   }, 1500);
  // });
});
