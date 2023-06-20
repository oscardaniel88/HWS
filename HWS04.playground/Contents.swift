import UIKit

enum errorException: Error{
    case outOfBoundsError
    case noRootError
}

func squareRoot(number:Int) throws ->Int{
    if number < 0{
        throw errorException.outOfBoundsError
    }
    for i in 1...100{
        if(i*i == number){
            return i
        }
    }
    throw errorException.noRootError
}

    for i in 1...100000 {
        do{
        let resp = try squareRoot(number: i)
        print("square root of \(i) is \(resp)")
    }
        catch{
            //print("An error ocurred, no square root found")
        }
}

