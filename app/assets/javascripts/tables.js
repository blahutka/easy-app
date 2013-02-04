$(document).ready(function () {
    var attache_hover = function () {
        console.log('clisk');
        $('table tr').hover(function () {
            $('.txt', $(this)).hide();
            $('a.hide', $(this)).show();
        }, function () {
            $('a.hide', $(this)).hide();
            $('.txt', $(this)).show();
        })
    }
    attache_hover();
    $(document).on("hover", "table", function(){
        $('table tr').hover(function () {
                  $('.txt', $(this)).hide();
                  $('a.hide', $(this)).show();
              }, function () {
                  $('a.hide', $(this)).hide();
                  $('.txt', $(this)).show();
              })
    } );
})