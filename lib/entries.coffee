
entries = []

module.exports =
  setAll: (e) ->
    entries = e

  getAll: ->
    entries

  deleteAll: ->
    entries = []

  get: (name) ->
    for entry in entries
      return entry if entry.name is name

  set: (name, value) ->
    for entry in entries
      if entry.name is name
        entry.value = value
        return
    entries.push({ name: name, value: value })

  delete: (name) ->
    entries = entries.filter (e) -> e.name isnt name
