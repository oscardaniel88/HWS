import UIKit

let celsius = 40
var farenheit = ((Double(celsius)) * (9/5)) + 32.0
var result = "\(celsius) celsius degrees is equal to \(Float(farenheit)) farenheit degrees"
print (result)

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())
print(cities)

var characters: [Character] = ["C", "a", "f", "é"]
characters.reverse()
print(characters)

var GfgEmpName = ["Sumit", "Poonam", "Punit", "Bittu", "Mohit"]
print("Geeks's employee name before reversing:", GfgEmpName)
GfgEmpName.reverse()
print("Geeks's employee name after reversing: ", GfgEmpName)

var presidents = ["Bush", "Obama", "Trump", "Biden"]
var presidentsReversed = presidents.reversed()
print(Array(presidentsReversed))
