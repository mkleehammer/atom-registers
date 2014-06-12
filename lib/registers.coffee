
RegistersSelectView = require './registers-select-view'
RegistersNameView = require './registers-name-view'
entries = require './entries'

module.exports =
  selectView: null
  nameView: null

  activate: (state) ->
    @selectView = new RegistersSelectView()
    @nameView = new RegistersNameView()
    atom.workspaceView.command "registers:copy", => @copy()
    atom.workspaceView.command "registers:paste", => @show('paste')
    atom.workspaceView.command "registers:delete", => @show('delete')
    atom.workspaceView.command "registers:delete-all", => @deleteAll()
    atom.workspaceView.command "registers:paste-quick", => @pasteQuick()
    atom.workspaceView.command "registers:copy-quick", => @copyQuick(false)
    atom.workspaceView.command "registers:cut-quick", => @copyQuick(true)

    if Array.isArray(state.entries) and state.entries.length
      entries.setAll(state.entries)

  deactivate: ->
    @selectView.destroy()

  serialize: ->
    return { entries: entries.getAll() }

  getActiveView: ->
    v = atom.workspaceView.getActiveView()
    e = v?.getEditor()
    if e
      return v
    return null

  show: (action) ->
    v = @getActiveView()
    @selectView.show(action, v) if v

  deleteEntry: (entry) ->
    # The user has chosen an item to delete.
    entries.delete(entry.name)

  pasteEntry: (entry) ->
    # The user has chosen an entry to paste into the document.
    view = @getActiveView()
    if view
      view.getEditor().insertText(entry.value)

  pasteQuick: ->
    entry = entries.get('quick')
    @pasteEntry(entry) if entry

  copyQuick: (cut) ->
    value = @getSelection(cut)
    entries.set('quick', value) if value

  copy: () ->
    value = @getSelection(false)
    console.log('save:', value)
    # x = new RegistersNameView()
    # x.attach()
    @nameView.show(value)

  getSelection: (cut) ->
    # Returns the selected text in the editor or the current line, used
    # for saving to a register.
    view = @getActiveView()
    if not view
      return
    editor = view.getEditor()

    # First grab the selection.
    sel = editor.getSelection()
    value = sel.getText()
    if value
      if cut
        sel.insertText('')
      return value

    # Otherwise grab the line.
    value = editor.getCursor().getCurrentBufferLine()
    if value
      if cut
        sel.deleteLine()
      return value + '\n'

    return null

  deleteAll: ->
    entries.deleteAll()
