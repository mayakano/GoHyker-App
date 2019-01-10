// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require activestorage
//= require turbolinks
//= require_tree .
//= require semantic-ui
//= require jquery



// $(document).on('turbolinks:load', function() {
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
// })

$('.close').click(function() {
  $('.message').css({
      'display': 'none',
  });
}); 


  $( document ).ready(function() {
      console.log( "ready!" );
      $("#search-form").submit(function(event){
          event.preventDefault();


          let params = {
            search_term: $('#search_term').val(),
            location: $('#location').val(),
            date: $('#date').val()
          }

          console.log(params);
          let url = "/search.json?" + $.param(params)
          fetch(url)
            .then(function(response) {
              return response.json();
            })
            .then(function(myJson) {
              for(var i = 0; i < myJson.length; i++) {
                var obj = myJson[i];
                console.log(obj.id);

                var html = '<div class="card" style="width: 18rem;">\
                  <img class="card-img-top" src=  alt="Card image cap">\
                  <div class="card-body">\
                    <h5 class="card-title">'+obj["name"]["text"]+'</h5>\
                    <p class="card-text">'+obj["description"]["text"]+'</p>\
                    <a href="#" class="btn btn-primary"></a>\
                  </div>\
                </div>'

              $(".containingEvents").append(html)
              }
            });


        });
  });

  

console.log(document.getElementsByClassName("form-group"));

//   $button = $('forms_buttons-action')
// $.rails.enableElement($button)
// $button.removeAttr('disabled')

$('body').delegate('.c-faq', 'click', function(){
  $('.c-faq').removeClass('c-faq--active');
  $(this).addClass('c-faq--active');
});

