// In-browser Ruby execution via Opal (cdn.opalrb.com).
(function () {
  'use strict';

  function ready(fn) {
    if (document.readyState !== 'loading') return fn();
    document.addEventListener('DOMContentLoaded', fn);
  }

  function waitForOpal(timeoutMs) {
    var deadline = Date.now() + (timeoutMs || 8000);
    return new Promise(function (resolve, reject) {
      (function poll() {
        if (window.Opal && typeof Opal.compile === 'function') return resolve();
        if (Date.now() > deadline) return reject(new Error('Opal failed to load after ' + (timeoutMs / 1000) + 's'));
        setTimeout(poll, 100);
      }());
    });
  }

  function initEditors() {
    if (!window.CodeMirror) return;
    var editors = document.querySelectorAll('textarea.code-editor');
    for (var i = 0; i < editors.length; i++) {
      var ta = editors[i];
      if (ta.dataset.cmInit) continue;
      ta.dataset.cmInit = '1';
      ta.dataset.starter = ta.value;
      ta.cm = CodeMirror.fromTextArea(ta, {
        mode: 'ruby',
        lineNumbers: true,
        theme: 'matrix',
        indentUnit: 2,
        tabSize: 2
      });
    }
  }

  function runCode(form) {
    var ta   = form.querySelector('textarea.code-editor');
    var spec = form.dataset.spec || '';
    var out  = form.querySelector('[data-role=result]');
    var src  = ta.cm ? ta.cm.getValue() : ta.value;

    out.innerHTML = '<span class="muted">» loading opal + compiling…<span class="cursor"></span></span>';
    var t0 = performance.now();

    waitForOpal(8000).then(function () {
      try {
        var userJS = Opal.compile(src, { file: 'submission.rb' });
        var specJS = Opal.compile(spec, { file: 'spec.rb' });
        (new Function('Opal', 'nil', userJS + ';\n' + specJS))(Opal, Opal.nil);
        var ms = Math.round(performance.now() - t0);
        out.innerHTML = '<div class="result-passed"><p>» PASSED <span class="meta">(' + ms + 'ms)</span></p></div>';
      } catch (e) {
        var ms2 = Math.round(performance.now() - t0);
        var msg = (e && e.message) ? e.message : String(e);
        out.innerHTML =
          '<div class="result-failed">' +
          '  <p>» FAILED <span class="meta">(' + ms2 + 'ms)</span></p>' +
          '  <pre class="err">' + escapeHtml(msg) + '</pre>' +
          '  <p class="hint">read the spec and the error — they tell you what to change.</p>' +
          '</div>';
      }
    }).catch(function (err) {
      out.innerHTML = '<div class="result-failed"><p>» OPAL OFFLINE</p><pre class="err">' + escapeHtml(err.message) + '</pre></div>';
    });
  }

  function submitChoice(form) {
    var radios  = form.querySelectorAll('input[type=radio]');
    var picked  = null;
    for (var i = 0; i < radios.length; i++) if (radios[i].checked) picked = radios[i].value;
    var correct = form.dataset.correct;
    var out     = form.querySelector('[data-role=result]');
    if (!picked) {
      out.innerHTML = '<div class="result-failed"><p>pick something first</p></div>';
      return;
    }
    if (picked === correct) {
      out.innerHTML = '<div class="result-passed"><p>» CORRECT</p></div>';
    } else {
      out.innerHTML = '<div class="result-failed"><p>» NOPE — re-read the prompt</p></div>';
    }
  }

  function resetForm(form) {
    var ta = form.querySelector('textarea.code-editor');
    if (!ta) return;
    var starter = ta.dataset.starter || '';
    if (ta.cm) ta.cm.setValue(starter); else ta.value = starter;
  }

  function escapeHtml(s) {
    return String(s).replace(/[&<>"']/g, function (c) {
      return { '&':'&amp;', '<':'&lt;', '>':'&gt;', '"':'&quot;', "'":'&#39;' }[c];
    });
  }

  ready(function () {
    initEditors();
    document.addEventListener('submit', function (e) {
      var form = e.target;
      if (!form.classList || !form.classList.contains('activity-form')) return;
      e.preventDefault();
      if (form.dataset.kind === 'code')   runCode(form);
      if (form.dataset.kind === 'choice') submitChoice(form);
    });
    document.addEventListener('click', function (e) {
      if (e.target.classList && e.target.classList.contains('reset')) {
        e.preventDefault();
        var form = e.target.closest('.activity-form');
        if (form) resetForm(form);
      }
    });
  });
}());
