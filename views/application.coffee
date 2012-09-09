$ ->
  ($ '#header').hide().fadeIn()
  ($ '#content').hide().fadeIn()
  box = ($ '#search_box')
  box.keyup ->
    ($ '#result_box').load '/match/' + escape box.val() if box.val().length > 0
