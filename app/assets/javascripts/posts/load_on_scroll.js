$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      $('.loader').show();
       $.ajax({
              url: '/load_more',
              data: {
                  id: $('.postline').attr('last')
              },
              dataType: 'script'
            });
   }
});
