import UIKit

struct Car{
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear = 0
    
    init(model: String, numberOfSeats: Int){
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func changeGear(newGear: Int){
        if(newGear < 10 && newGear > 0 && abs(self.currentGear - newGear) == 1){
            self.currentGear = newGear
        }else{
            print("Unable to set gear!!")
        }
    }
}

var chevy = Car(model: "Chevy", numberOfSeats: 5)
chevy.changeGear(newGear: 1)
print("New gear is set to \(chevy.currentGear)")
