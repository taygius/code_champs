_ = require '../underscore'

exports.fn = (L,n,listRight,m,listLeft) -> 
    deque = {}

    toDeq = (list, isRight) ->
        for birdPosition in list
            birdId = _i
            deque[birdPosition] = [birdId, isRight]

    toDeq(listRight, true)
    toDeq(listLeft, false)

    result = {'left' : {}, 'right' : {}}
    currentMinute = 0
    ifReturnAll = false
    ifSkipNext = false
    leftRes = 0
    rigthRes = 0

    while true
        positions = []
        _.each deque, (ins, birdPosition) ->
            positions.push(birdPosition)

        for birdPosition in positions
            if ifReturnAll == true
                _.each deque, (isn, pos) -> deque[pos][1] = !deque[pos][1]
            ifReturnAll = false

            if ifSkipNext == true
                ifSkipNext = false
                continue

            if deque[birdPosition][1] == true #if right
                if birdPosition >= L #last position
                    result['right'][rigthRes++] = currentMinute
                    delete deque[birdPosition]
                    ifReturnAll = true
                else if deque[birdPosition- -1]? #has in right
                    deque[birdPosition][1] = !deque[birdPosition][1] # return both
                    deque[birdPosition- -1][1] = !deque[birdPosition- -1][1]
                    ifSkipNext = true
                else
                    deque[birdPosition - -1] = [deque[birdPosition][0], deque[birdPosition][1]]
                    delete deque[birdPosition]

            else if deque[birdPosition][1] == false #if left
                if birdPosition <= 0 #first
                    result['left'][leftRes++] = currentMinute
                    delete deque[birdPosition]
                    ifReturnAll = true
                else if deque[birdPosition-1]? #has in left
                    deque[birdPosition][1] = !deque[birdPosition][1] # return both
                    deque[birdPosition-1][1] = !deque[birdPosition-1][1]
                    ifSkipNext = true
                else
                    deque[birdPosition-1] = [deque[birdPosition][0], deque[birdPosition][1]]
                    delete deque[birdPosition]

        console.log currentMinute
        console.log deque
        currentMinute++

        break if !_.size deque
    result

console.log(exports.fn 10, 2, [8,9], 3, [2, 5, 7])