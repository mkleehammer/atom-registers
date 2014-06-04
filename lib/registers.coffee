
RegistersSelectView = require './registers-select-view'
RegistersNameView = require './registers-name-view'
entries = require './entries'

module.exports =
  selectView: null
  nameView: null

  activate: (state) ->
    @selectView = new RegistersSelectView()
    @nameView = new RegistersNameView()
    atom.workspaceView.command "registers:insert", => @show('insert')
    atom.workspaceView.command "registers:delete", => @show('delete')
    atom.workspaceView.command "registers:save", => @save()
    atom.workspaceView.command "registers:insert-quick", => @insertQuick()
    atom.workspaceView.command "registers:copy-to-quick", => @copyToQuick(false)
    atom.workspaceView.command "registers:cut-to-quick", => @copyToQuick(true)
    # if state.entries
    #     entries.set(entries)

  # xyzzy

  deactivate: ->
    @selectView.destroy()

  serialize: ->
    # entries: entries.get()

  getActiveView: ->
    v = atom.workspaceView.getActiveView()
    e = v?.getEditor()
    if e
      return v
    return null

  show: (action) ->
    v = @getActiveView()
    @selectView.show(action, v) if v

  insertQuick: ->
    entry = entries.get('quick')
    view = @getActiveView()
    if entry and view
      view.getEditor().insertText(entry.value)

  copyToQuick: (cut) ->
    value = @getSelection(cut)
    if value
      entries.set('quick', value)

  save: () ->
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
