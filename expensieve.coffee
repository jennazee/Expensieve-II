window.Expensieve =
  people: {}
  debts: []

  addPerson: (name) ->
    @people[name] = new Expensieve.Person(name)

  addPayment: (payer, owers, amount) ->
    numSplits = owers.length + 1
    splitAmount = amount/numSplits
    for ower in owers
      @debts.push(new Expensieve.Debt(@people[payer], @people[ower], splitAmount))

  resolvePayments: ->






