$(window).scroll(function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
       $.ajax({
              url: '/load_more',
              data: {
                  id: $('.postline').attr('last'),
                  type: $('.postline').attr('controller'),
                  entity: $('.postline').attr('id')
              },
              dataType: 'script'
            });
   }
});
