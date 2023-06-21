import UIKit

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

//luckyNumbers.filter({!$0.isMultiple(of: 2)}).sorted(by:{$0 < $1}).map({print("\($0) is a lucky number")})

let solve = { (numbers:[Int]) in
    numbers.filter({!$0.isMultiple(of: 2)}).sorted(by:{$0 < $1}).map({print("\($0) is a lucky number")})
}

solve(luckyNumbers)
