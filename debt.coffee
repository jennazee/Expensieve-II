#edge
class Expensieve.Debt
  constructor: (@payer, @ower, @amount) ->

  setAmount: (newAmt)->
    @amount = newAmt
