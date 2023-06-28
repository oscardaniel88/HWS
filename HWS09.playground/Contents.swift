import UIKit

func getRandomElementOrRandomNumber(from array:[Int]?) -> Int{
    return array?.randomElement() ?? Int.random(in: 1...100)
}

var array: [Int]? = nil
//array = [90,7,0,3,4,5,8,899]
print(getRandomElementOrRandomNumber(from:array))
