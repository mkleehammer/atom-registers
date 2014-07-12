
{View, EditorView, $, Point} = require 'atom'

entries = require('./entries')

module.exports =
class RegistersNameView extends View

  @content: ->
    @div class: "overlay from-bottom mini panel", =>
      @div class: "panel-heading", 'Save to Register:'
      @div class: 'block', =>
        @div class: 'editor-container', =>
          @subview 'miniEditor', new EditorView(mini: true)

  initialize: ->
    @on 'core:confirm', => @confirm()
    @on 'core:cancel', => @detach()
    @callback = null

  show: (callback) ->
    @callback = callback
    if not @hasParent()
      @attach()

  confirm: ->
    name = @miniEditor.getText()
    if name
      @callback(name)
      @callback = null
      @detach()

  cancel: ->
    @callback = null
    super()

  destroy: ->
    @detach()
    super()

  attach: ->
    if editor = atom.workspace.getActiveEditor()
      atom.workspaceView.append(this)
      @miniEditor.focus()
      @miniEditor.setText('')

  detach: =>
    return unless @hasParent()
    atom.workspaceView.focus()
    super()
