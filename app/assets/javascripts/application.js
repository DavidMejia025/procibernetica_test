// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require bootstrap-sprockets

//= require_tree .
$(document).ready(function() {
  $( '.add_new_category' ).on( 'click', function() {
    $(".create_new_category_block").css('display', 'inline-block');
  });

  $( '.category_submit' ).on( 'click', function() {
    $(".create_new_category_block").css('display', 'none');
  });

  $( '.form-check-input' ).on( 'click', function() {
    check_box_id = $( '.form-check-input' ).attr('id')
    check_box    = $('#' + check_box_id)

    if (!check_box.is(":checked")){
        $.ajax({
      		url: "/tasks/" + check_box_id,
      		type: "PATCH",
          data: {'task': {'status':'done'}},
      	})
      	.done(function(data){
      		console.log('DONE')
      	})
      }
  });
})
