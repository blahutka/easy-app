$(document).ajaxSuccess(function () {

});

$(document).ajaxSend(function () {

});

$(document).ready(function () {
// SAVE AJAX URL HISTORY
    //  if (history && history.pushState()) {
//        $('a[data-remote="true"]').live('click', function () {
//            history.pushState(null, '', this.href)
//        })
//
//        $(window).bind("popstate", function () {
//           // $.getScript(location.href);
//        });
    // }
    $('a.go-back[data-remote="true"]').live('click', function () {
        history.pushState(null, '', this.href) ;
    })
})