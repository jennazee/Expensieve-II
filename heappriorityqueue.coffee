#MINIMUM PQ
class PriorityQueue
  constructor: (@size, @key) ->
    @storage = new Array(@size + 1)
    @insertionPt = 1

  size: ->
    @insertionPt - 1

  insert: (item) ->
    @storage[@insertionPt] = item
    @upheap(@insertionPt)
    @insertionPt++

  upheap: (currIndex) ->
    while currIndex > 1 and @storage[currIndex][@key] < @storage[@getParentIndex(currIndex)][@key]
      child = @storage[currIndex]
      parent = @storage[@getParentIndex(currIndex)]
      @storage[@getParentIndex(currIndex)] = child
      @storage[currIndex] = parent
      currIndex = @getParentIndex(currIndex)

  removeMin: ->
    min = @storage[1]
    @storage[1] = @storage[--@insertionPt]
    @storage[@insertionPt] = undefined
    @downheap(1)
    min

  downheap: (currIndex) ->
    while @storage[@getLeftChildIndex(currIndex)]
      smallerChildIndex = @getSmallerChildIndex(currIndex)
      curr = @storage[currIndex]
      smallerChild = @storage[smallerChildIndex]
      if curr.amount > smallerChild.amount
        @storage[smallerChildIndex] = curr
        @storage[currIndex] = smallerChild
        currIndex = smallerChildIndex
      else
        break

  replaceKey: (element, newKey) ->
    index = @storage.indexOf(element)
    element[@key] = newKey
    console.log element
    if (@storage[@getLeftChildIndex(index)] and newKey > @storage[@getLeftChildIndex(index)][@key]) or (@storage[@getRightChildIndex(index)] and newKey > @storage[@getRightChildIndex(index)][@key])
      @downheap(index)
    else if newKey < @storage[@getParentIndex(index)][@key]
      @upheap(index)

  #helper methods
  getLeftChildIndex: (index) ->
    2 * index

  getRightChildIndex: (index) ->
    2 * index + 1

  getSmallerChildIndex: (parentIndex) ->
    leftAmt = @storage[@getLeftChildIndex(parentIndex)][@key]
    rightAmt = @storage[@getRightChildIndex(parentIndex)][@key] if @storage[@getRightChildIndex(parentIndex)]
    if rightAmt is undefined
      @getLeftChildIndex(parentIndex)
    else
      if leftAmt < rightAmt
        @getLeftChildIndex(parentIndex)
      else
        @getRightChildIndex(parentIndex)

  getParentIndex: (index) ->
    Math.floor(index/2)


pq = new PriorityQueue(8, 'amount')
pq.insert({amount: 10})
pq.insert({amount: 6})
pq.insert({amount: 12})
pq.insert({amount: 89})
pq.insert({amount: 1})
pq.insert({amount: 18})
pq.insert({amount: 34})
console.log pq.storage
pq.replaceKey(pq.storage[2], 76)
console.log pq.storage
pq.replaceKey(pq.storage[5], 7)
console.log pq.storage

console.log pq.removeMin()
console.log pq.storage
console.log pq.removeMin()
console.log pq.storage
console.log pq.removeMin()
console.log pq.storage
console.log pq.removeMin()
console.log pq.storage
console.log pq.removeMin()
console.log pq.storage
console.log pq.removeMin()
console.log pq.storage

