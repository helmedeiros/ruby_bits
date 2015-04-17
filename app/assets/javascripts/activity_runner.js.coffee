# Wires textareas → CodeMirror, posts on submit, renders the JSON result.
$ ->
  $('.code-editor').each ->
    ta = this
    return if ta.dataset.cmInit
    ta.dataset.cmInit = '1'
    window.CodeMirror.fromTextArea ta,
      mode: 'ruby'
      lineNumbers: true
      theme: 'matrix'

  $('.activity-form').on 'submit', (e) ->
    e.preventDefault()
    form = $(this)
    out  = form.find('[data-role=result]')
    out.html '<span class="muted">» running…<span class="cursor"></span></span>'
    $.ajax
      url: form.attr('action')
      type: 'POST'
      data: form.serialize()
      dataType: 'json'
      success: (data) ->
        klass = "result-#{data.status}"
        html  = "<div class='#{klass}'>"
        html += "  <p>» #{data.status.toUpperCase()} <span class='meta'>(#{data.runtime_ms || 0}ms)</span></p>"
        html += "  <pre>#{data.stdout}</pre>" if data.stdout
        html += "  <pre class='err'>#{data.stderr}</pre>" if data.stderr
        html += "  <p class='hint'>hint: #{data.hint}</p>" if data.hint
        html += "</div>"
        out.html html
      error: -> out.html "<span class='err'>request failed</span>"

  $('.activity-form .reset').on 'click', ->
    starter = $(this).data('starter')
    ta = $(this).closest('form').find('.code-editor')[0]
    ta.value = starter if ta
