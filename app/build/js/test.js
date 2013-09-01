(function() {
  (function($) {
    return $.fn.highlight = function() {
      $(this).css({
        color: "red",
        background: "yellow"
      });
      return $(this).fadeIn();
    };
  })(jQuery);

}).call(this);
