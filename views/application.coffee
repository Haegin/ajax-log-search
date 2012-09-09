$ ->
  ($ '#header').hide().fadeIn()
  ($ '#content').hide().fadeIn()
  search_box = ($ '#search_box')
  result = ($ '#result_box')
  result.load '/match/' + escape '.*'
  search_box.keyup ->
    result.load '/match/' + escape search_box.val()
