
{$$, SelectListView} = require 'atom'
entries = require './entries'

module.exports =
class RegistersSelectView extends SelectListView
  initialize: ->
    super
    @addClass('registers-select-view overlay from-top')
    @callback = null

  getFilterKey: -> 'name'

  @cancel: ->
    @callback = null
    super

  destroy: ->
    @cancel()
    @detach()

  confirmed: (entry) ->
    @callback(entry)
    @cancel()

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.appendToTop(this)
    @focusFilterEditor()

  show: (callback) ->
    @callback = callback
    items = entries.getAll()
    @setItems(items)
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
