//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.raty.min
//= require_tree .

$(function(){
  setupRaty();
});

function setupRaty(){
  $('#star').raty({
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
}
