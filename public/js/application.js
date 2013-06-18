$(document).ready(function() {
    resetForm = function(){
      $('form').attr('disabled','');
      $('form')[0].reset();  
    };

  $('form').on('submit', function(e) {
    e.preventDefault();
    $('form').attr('disabled','disabled');
    $('p').text("Processing.......");
    $.ajax({
        type: 'get',
        url: '/tweet',
        data: $(this).serialize()
    }).done(function() {
      $('p').text("Tweeted your post!");
      resetForm();
    }).fail(function() {
      $('p').text("Tweet failed! Server error!");
      resetForm();
    })

  })

});
