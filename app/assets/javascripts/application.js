//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.raty.min
//= require_tree .

$(function(){
  setupRaty();
});

function setupRaty(){
  $('#score').raty({
    number: 10,
    path: '../assets/raty',
    scoreName: 'subscription[score]',
    width: 280,
    click: function(score, evt){
      $('#subscription_form').submit();
    },
    score: function(){
      return $(this).attr('data-score');
    }
  });

  $('.score_read_only').raty({
    number: 10,
    path: '../assets/raty',
    width: 280,
    readOnly: true,
    score: function(){
      return $(this).attr('data-score');
    }
  });
}
