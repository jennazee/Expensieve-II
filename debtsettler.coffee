class DebtSettler
  ###
  Pretty much a complicated Kruskal's algorithm machine
  ###
  constructor: (debts, people) ->

  settleDebts: (debts) ->
    ###
    modified minimum spanning tree in which the value of a cycle-making edge is used to augment those that would be in the cycle
    ###

    #collections of nodes
    @clouds = []
    @clouds.push(people[person]) for person in people

    # edges in max -> min order to make max spanning tree
    edges = sortDebts(debts)
    #edges in the max spanning tree
    @forest = {}
    curr = edges.pop()
    # payer = sink, ower = source
    payerRoot = @find(curr.payer)
    owerRoot = @find(curr.ower)
    if payerRoot is not owerRoot
      #new connection! merge the clouds
      newRoot = @union(payerRoot, owerRoot)
      if @forest[newRoot.name]
        @forest[newRoot.name].push(curr)
      else
        @forest[newRoot.name] = []
        @forest[newRoot.name].push(curr)
    else
      ## find the cycle via dijkstra and then augment
      # get all the edges in the cloud
      subforest = @forest[payerRoot.name]




  #find the root of a node, with path compression
  find: (x) ->
    if x is not x.parent
      x.cloudParent = @find(x.cloudParent)
      x.cloudParent

  #join two clouds
  union: (root1, root2) ->
    newRoot
    root1forest = @forest[root1.name] or []
    root2forest = @forest[root2.name] or []
    if root1.cloudRank > root2.cloudRank
      root2.cloudParent = root1
      root1forest.push.apply(root1forest, root2forest)
      newRoot = root1
    else if root1.cloudRank < root2.cloudRank
      root1.cloudParent = root2
      root2forest.push.apply(root2forest, root1forest)
      newRoot = root2
    else
      root2.cloudParent = root1
      root1.cloudRank++
      root1forest.push.apply(root1forest, root2forest)
      newRoot = root1
    newRoot

  dijkstra: (people, subforest, start, end) ->
    for person in people
      person.dist = Infinity
      person.prev = null
    start.dist = 0

    pq = new PriorityQueue(edges.length, 'dist')
    while pq.size() != 0
      curr = pq.removeMin()
      if end and curr = end
        break
      connections = getConnections(subforest, curr)
      for connection in connections
        #find the one that is not curr
        other
        if connection.payer.name is curr.name
          other = connection.ower
        else
          other = connection.payer
        if other.dist > curr.dist + connection.amount
          other.dist = curr.dist + connection.amount
          other.prev = curr
          pq.replaceKey(other, other.dist)
    if end
      path = []
      curr = end
      while curr.prev is defined
        path.push(getLinkingEdge(subforest, curr, curr.prev))
        curr = curr.prev


  getConnections: (subforest, source) ->
    connections = []
    for edge in subforest
      if edge.payer = source or edge.ower = source
        connections.push(edge)
    connections

  getLinkingEdge: (subforest, v1, v2) ->
    for edge in subforest
      if edge.payer is v1.name or edge.ower is v1.name
        if edge.payer is v2.name or edge.ower is v2.name
          return edge


