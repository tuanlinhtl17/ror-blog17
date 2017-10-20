$(document).ready(function(){
  $("#new_comment").submit(function(event){
    event.preventDefault();

    var action = $(this).attr('action');
    var method = $(this).attr('method');

    var content = $('textarea').val();
    var post_id = $('#comment_post_id').val();

    // $.ajax({
    //   method: method,
    //   action: action,
    //   data: { content: content },
    //   dataType: 'script',
    //   success: function(response){
    //     console.log(response);
    //     // var html = '<div class="media mb-4"><img class="d-flex mr-3 rounded-circle" src='
    //     // html += `${response.avatar} alt="" style="height: 50px; width: 50px"> <div class="media-body">`;
    //     // html += '<h5 class="mt-0">' + response.user_name + '</h5>';
    //     // html += response.content;
    //     // html += '</div>' + '</div>';
    //     // $("#comments").append(html);
    //   }
    // });
    let data = { comment: { content: content, post_id: post_id } };

    $.post(action + '.json', data, function(response){
      //console.log(response);
      var html = '<div class="media mb-4"><img class="d-flex mr-3 rounded-circle" src='
      html += response.avatar + ' alt="" style="height: 50px; width: 50px"> <div class="media-body">';
      html += '<h5 class="mt-0">' + response.user_name + '</h5>';
      html += response.content;
      html += '</div>' + '</div>';
      $('#comments').append(html);
      $("textarea").val('');
      $('input[type="submit"]').prop('disabled', false);
      $('html, body').animate({ scrollTop: $(document).height()}, 'slow');
    });
  });
});
