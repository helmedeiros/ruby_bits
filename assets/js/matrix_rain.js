(function () {
  var canvas = document.getElementById('rain');
  if (!canvas) return;
  var ctx = canvas.getContext('2d');
  function resize() { canvas.width = window.innerWidth; canvas.height = window.innerHeight; }
  resize();
  window.addEventListener('resize', resize);

  var glyphs = 'ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉ0123456789def class module end if'.split('');
  var cols = Math.floor(canvas.width / 14);
  var drops = [];
  for (var i = 0; i < cols; i++) drops[i] = 1;

  function draw() {
    ctx.fillStyle = 'rgba(0,0,0,0.06)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = '#00ff41';
    ctx.font = '14px Courier New';
    for (var x = 0; x < drops.length; x++) {
      var ch = glyphs[Math.floor(Math.random() * glyphs.length)];
      ctx.fillText(ch, x * 14, drops[x] * 14);
      if (drops[x] * 14 > canvas.height && Math.random() > 0.975) drops[x] = 0;
      drops[x]++;
    }
  }
  setInterval(draw, 60);
}());
