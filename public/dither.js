Dither = {
  _initialized: false,


  init: function() {
    if (this._initialized) {
      // We'd previously been initialized.
      return false;
    }

    // We're now initialized.
    return this._initialized = true;
  }
};


$(function() {
  Dither.init();
});

