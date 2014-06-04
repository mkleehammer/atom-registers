
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

  show: (value) ->
    @value = value
    if not @hasParent()
      @attach()

  confirm: ->
    name = @miniEditor.getText()
    if name
      entries.set(name, @value)
      @detach()

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
