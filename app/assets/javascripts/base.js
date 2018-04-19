$(document).ready(function() {
  $('#notice').show().delay(4000).fadeOut(1500);
  $('#message').show().delay(4000).fadeOut(1500);
  $('#warning').show().delay(4000).fadeOut(1500);
  
  $("ul#topnav li").hover(hoverOver, hoverOut);
});

//On Hover Over
function hoverOver(){
  $(this).find(".sub").show(); //Find sub and fade it in
}
//On Hover Out
function hoverOut(){
  $(this).find(".sub").hide();
}

// This jQuery plugin will allow us to capture ctrl+S or command+S type keyboard shortcuts
$.ctrl = function(key, callback, args) {
    $(document).keydown(function(e) {
        if(!args) args=[]; // IE barks when args is null
        if(e.keyCode == key.charCodeAt(0) && (e.ctrlKey || e.metaKey)) {
            callback.apply(this, args);
            e.preventDefault();
            return false;
        }
    });
};


// Bootstrap ----------------------------------------------

// setup the tooltips
// $("[data-toggle='tooltip']").tooltip();
