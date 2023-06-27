import UIKit

protocol Building {
    var rooms: Int {get}
    var cost: Int {get}
    var agent: String {set get}
    func salesSummary ()
}

extension Building{
    func salesSummary() {
        print("This is a building that has \(rooms) rooms and a price of \(cost). It is currently sold by \(agent)")
    }
}

struct House : Building{
    var rooms: Int
    var cost: Int{
        get{
            return rooms * 30000
        }
    }
    var agent: String
    func salesSummary() {
        print("This is a House that has \(rooms) rooms and a price of \(cost). It is currently sold by \(agent)")
    }
}

struct Office : Building{
    var rooms: Int
    var cost: Int
    var agent: String
    func salesSummary() {
        print("This is an Office that has \(rooms) rooms and a price of \(cost). It is currently sold by \(agent)")
    }
}

extension Office {
    init(rooms: Int, agent: String){
        self.rooms = rooms
        self.cost = rooms * 10_000
        self.agent = agent
    }
}

var house = House(rooms: 4, agent:"Rosy")
var office = Office(rooms: 200, cost: 5_000_000, agent: "Rodmy")
var office2 = Office(rooms: 50, agent: "Peter")

house.salesSummary()
office.salesSummary()
office2.salesSummary()

