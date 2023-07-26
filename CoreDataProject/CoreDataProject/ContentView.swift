//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Daniel Camarena on 7/25/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    var body: some View {
        VStack {
            List {
                ForEach(countries, id:\.self) {
                    country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id:\.self) {
                            candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "UK"
                candy4.origin?.fullName = "United Kingdom"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Mazapan"
                candy5.origin = Country(context: moc)
                candy5.origin?.shortName = "MX"
                candy5.origin?.fullName = "Mexico"
                
                let candy6 = Candy(context: moc)
                candy6.name = "Pulparindo"
                candy6.origin = Country(context: moc)
                candy6.origin?.shortName = "MX"
                candy6.origin?.fullName = "Mexico"
                
                let candy7 = Candy(context: moc)
                candy7.name = "Bubulubu"
                candy7.origin = Country(context: moc)
                candy7.origin?.shortName = "MX"
                candy7.origin?.fullName = "Mexico"
                
                let candy8 = Candy(context: moc)
                candy8.name = "Carlos V"
                candy8.origin = Country(context: moc)
                candy8.origin?.shortName = "MX"
                candy8.origin?.fullName = "Mexico"
                
                try? moc.save()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
