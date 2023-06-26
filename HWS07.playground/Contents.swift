import UIKit

class Animal {
    var legs:Int
    init(legs:Int){
        self.legs = legs
    }
}

class Dog : Animal{
    init(){
        super.init(legs: 4)
    }
    
    func speak(){
        print("Roaf")
    }
}

class Cat : Animal {
    var isTame:Bool
    init(isTame:Bool){
        self.isTame = isTame
        super.init(legs: 4)
    }
    func speak(){
        print("Miau")
    }
}

class Corgi : Dog{
    override func speak(){
        print("Corgi bark")
    }
}

class Poddle : Dog {
    override func speak(){
        print("Poodle bark")
    }
}

class Persian : Cat {
    init(){
        super.init(isTame: false)
    }
    override func speak(){
        print("Miauuuuu!")
    }
}

class Lion : Cat {
    init(){
        super.init(isTame: true)
    }
    override func speak(){
        print("Roaaaar")
    }
}


var corgi = Corgi()
var poddle = Poddle()
var persian = Persian()
var lion = Lion()

corgi.speak()
poddle.speak()
persian.speak()
lion.speak()
