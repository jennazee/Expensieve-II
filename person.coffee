#node
class Expensieve.Person
  constructor: (@name, @payed_for, @owes_for) ->
    @cloudParent = this
    @cloudRank = 0

  get_payed_for: ->
    @payed_for

  get_owes_for: ->
    @owes_for

  add_to_payed_for: (debt) ->
    @payed_for.push(debt)

  add_to_owes_for: (debt) ->
    @owes_for.push(debt)

