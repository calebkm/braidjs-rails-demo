# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.statebus_ready or= []
window.statebus_ready.push ->
  bus('/accounts').to_fetch = (key, old, t) ->
    console.log "Called :to_fetch with #{key}"

    $.ajax
      method: 'GET'
      dataType: 'JSON'
      headers: {Accept: 'application/json'}
      url: '/accounts' # hardcoding
    .done (results) ->
      # ERROR HANDLING?
      obj = {key: key, results: results}
      t.return(obj)

  bus('/accounts/*').to_fetch = (key, old, t) ->
    console.log "Called :to_fetch with #{key}"

    $.ajax
      method: 'GET'
      dataType: 'JSON'
      headers: {Accept: 'application/json'}
      url: key
    .done (results) ->
      # ERROR HANDLING?
      obj = {key: key, results: results}
      t.return(obj)

  bus('/accounts').to_save = (obj) ->
    console.log "Called :to_save on #{obj.key}"

    $.ajax
      method: 'POST'
      dataType: 'JSON'
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': $("meta[name='csrf-token']").attr('content')
      }
      url: '/accounts' # hardcoding
      data: {account: obj} # remove 'account' hardcoding?
    .done (results) ->
      # ERROR HANDLING?
      results['key'] = obj.key
      bus.dirty(obj.key)
      # What are we returning here?

  bus('/accounts/*').to_delete = (key) ->
    console.log "Called :to_delete on #{key}"

    # Still a WIP :-)

    # $.ajax
    #   method: 'DELETE'
    #   dataType: 'JSON'
    #   headers: {
    #     Accept: 'application/json',
    #     'X-CSRF-Token': $("meta[name='csrf-token']").attr('content')
    #   }
    #   url: key
    # .done (results) ->
    #   # ERROR HANDLING?
    #   results['key'] = obj.key
    #   bus.dirty(obj.key)
    #   # What are we returning here?

    