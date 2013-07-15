window.Expensieve =
  people: {}
  debts: []

  addPerson: (name) ->
    @people[name] = new Expensieve.Person(name)

  addPayment: (payer, owers, amount) ->
    numSplits = owers.length + 1
    splitAmount = amount/numSplits
    for ower in owers
      debt = new Expensieve.Debt(@people[payer], @people[ower], splitAmount)
      @debts.push(debt)
      ower.add_owes_for(debt)
    payer.add_payed_for(debt)

  resolvePayments: ->
    # modified Kruskal?
    #   create a forest F (a set of trees), where each vertex in the graph is a separate tree
    #   create a set S containing all the edges in the graph
    #   while S is nonempty and F is not yet spanning
    #   remove an edge with maximum weight from S
    #   if that edge connects two different trees, then add it to the forest, combining two trees into a single tree
    #   otherwise discard that edge.
    sorted_debts = sort_debts(@debts)
    while sorted_debts.length > 0
      curr = sorted_debts.pop()



  ##### helper methods #####

  sortDebts: (debts) ->
    # quicksort
    # Pick an element, called a pivot, from the list.
    # Reorder the list so that all elements with values less than the pivot come before the pivot, while all elements with values greater than the pivot come after it (equal values can go either way). After this partitioning, the pivot is in its final position. This is called the partition operation.
    # Recursively apply the above steps to the sub-list of elements with smaller values and separately the sub-list of elements with greater values.

    pivots = [debts[0]]
    pivot_amt = pivots[0].getAmount()
    lesses = []
    greaters = []
    for debt in debts
      if debt.getAmount() < pivot_amt
        lesses.push(debt)
      else if debt.getAmount() > pivot_amt
        greaters.push(debt)
      else
        pivots.push(debt)
    sortDebts(lesses).concat(pivots, sortDebts(greaters))

  settleParallels: (debts) ->
    # cycle through edges and compare them to remaining ones in collection
    # if two are parallel, collapse them, and remove the "other" one from further comparison
    debts_copy = _.clone(debts)
    settled = []
    while debts_copy.length > 0
      curr = debts_copy.pop()
      curr_payer = curr.payer
      curr_ower = curr.ower
      # if there's one in the same direction combine them
      # else if there's one in the opposite direction, settle it
      for (var i = 0; i < debts_copy.length; i++)
        other = debts_copy[i]
        other_payer = other.payer
        other_ower = other.ower
        # if two parallel debts in same direction (additive)
        if (curr_payer is other_payer) and (curr_ower is other_ower)
          #subsume other into curr
          curr.amount = curr.amount + other.amount
          debts_copy.splice(i, 1)
        #two parallel debts in opposite directions (cancel out)
        else if (curr_payer is other_ower) and (curr_ower is other_payer)
          if curr.amount > other.amount
            curr.amount = curr.amount - other.amount
          else
            curr.amount = curr.amount - other.amount
            curr.payer = other.player
            curr.ower = other.ower
          debts_copy.splice(i, 1)
      settled.push(curr)



