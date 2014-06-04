
{$$, SelectListView} = require 'atom'
entries = require './entries'

module.exports =
class RegistersSelectView extends SelectListView
  initialize: ->
    super
    @addClass('registers-select-view overlay from-top')

  serialize: ->

  getFilterKey: -> 'name'

  @cancel: ->
    super
    @action = null
    @targetView = null

  destroy: ->
    @cancel()
    @detach()

  confirmed: (entry) ->
    @cancel()

    if @action is 'delete'
      entries.delete(entry.name)
    else if @action is 'insert'
      @targetView.getEditor().insertText(entry.value)

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.appendToTop(this)
    @focusFilterEditor()

  show: (action, view) ->
    @action = action # 'insert' or 'delete'
    @targetView = view # used with insert; null for delete
    @setItems(entries.getAll())
    @attach()

  viewForItem: (entry) ->
    $$ ->
      @li class: 'two-lines', =>
        @div entry.name, class: 'primary-line'
        @div entry.value, class: 'secondary-line'

  getEmptyMessage: (itemCount) ->
    if itemCount is 0
      'No registers'
    else
      super
