rs = require '../first'

exports.firstService =
    checkOne: (test) ->
        va = rs.fn 5, 1, [5], 1, [4]

        test.equal va[0][0], 0
        test.equal va[1][0], 1

        test.done()
