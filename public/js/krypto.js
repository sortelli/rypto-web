$(document).ready(function() {
  $('.krypto-card').each(function() {
    var card  = $(this);
    var value = parseInt(card.text(), 10);
    var color = 'black';

    if (value >= 18) {
      var color = 'red';
    }
    else if (value >= 11) {
      var color = 'blue';
    }

    card.addClass('krypto-' + color);
  });
});
