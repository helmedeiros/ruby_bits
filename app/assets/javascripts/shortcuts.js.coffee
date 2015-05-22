# 'g t' → tracks, 'g d' → dashboard, '/' → search, 'r' → run focused activity.
$ ->
  buffer = ''
  reset  = -> setTimeout (-> buffer = ''), 700

  goto = (path) -> Turbolinks.visit path
  $(document).on 'keydown', (e) ->
    return if $(e.target).is('input, textarea, [contenteditable]')
    key = e.key
    if key == '/'
      e.preventDefault()
      goto('/search')
      return
    if key == 'r'
      $('.activity-form:visible').first().submit()
      return
    if key == 'g'
      buffer = 'g'
      reset()
      return
    if buffer == 'g'
      switch key
        when 't' then goto('/tracks')
        when 'd' then goto('/dashboard')
        when 'l' then goto('/leaderboard')
      buffer = ''
