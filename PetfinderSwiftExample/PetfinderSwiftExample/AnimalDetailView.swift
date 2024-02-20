//
//  AnimalDetailView.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/19/24.
//

import SwiftUI

struct AnimalDetailView: View {
    private var animal: Animal
    public init(animal: Animal){
        self.animal = animal
    }
    var body: some View {
        Form {
            Section (header: Text("\(animal.id)")){
                HStack{
                    Spacer()
                    AsyncImage(url: URL(string: animal.photos?.first?.full ?? "")){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 340, maxHeight: 340)
                            
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 340, height: 340)
                    Spacer()
                }
                Text("Name: " + animal.name)
                Text("Age: " + animal.age)
                Text("Type: " + animal.type)
                Text("Status: " + animal.status)
                
            }
        }
    }
}

#Preview {
    let photo = Photo(small:  "https://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=300", 
                      medium:  "https://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=300",
                      large: "https://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=300",
                      full: "https://photos.petfinder.com/photos/pets/124/1/?bust=1546042081&width=300")
    let animal = Animal(id: 0,
                        name: "test",
                        url: "test",
                        photos: [photo],
                        type: "Cat", 
                        age: "Young",
                        gender: "Male",
                        size: "Big",
                        status: "Adoptable")
    return AnimalDetailView(animal: animal)
}
