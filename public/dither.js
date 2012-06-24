Dither = {
  _initialized: false,


  init: function() {
    if (this._initialized) {
      // We'd previously been initialized.
      return false;
    }

    twttr.anywhere(function (T) {
      T("#tbox").tweetBox({
        height: 100,
        width: 400,
        defaultContent: "<YOUR DEFAULT TWEETBOX CONTENT HERE>"
      });
    });

    // We're now initialized.
    return this._initialized = true;
  },

  _username: function() {
    var username = $("[name='username']").val();
    $.getJSON('/magic', {username: username}, function(data) {
      console.log(data);
    });
    return false;
  }
};


$(function() {
  Dither.init();
});
