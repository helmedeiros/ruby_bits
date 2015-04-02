# Falling-glyphs canvas effect. Pure 2D canvas, no WebGL — works in 2015 browsers.
$ ->
  canvas = document.getElementById('rain')
  return unless canvas
  ctx = canvas.getContext('2d')
  resize = ->
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  resize()
  $(window).on 'resize', resize

  glyphs = 'ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉ0123456789def class module end if'.split('')
  cols   = Math.floor(canvas.width / 14)
  drops  = (1 for c in [0...cols])

  draw = ->
    ctx.fillStyle = 'rgba(0,0,0,0.06)'
    ctx.fillRect 0, 0, canvas.width, canvas.height
    ctx.fillStyle = '#00ff41'
    ctx.font = '14px Courier New'
    for x in [0...drops.length]
      ch = glyphs[Math.floor(Math.random() * glyphs.length)]
      ctx.fillText ch, x * 14, drops[x] * 14
      drops[x] = 0 if drops[x] * 14 > canvas.height and Math.random() > 0.975
      drops[x]++
    return
  setInterval draw, 60
