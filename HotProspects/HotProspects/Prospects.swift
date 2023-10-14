//
//  Prospects.swift
//  HotProspects
//
//  Created by Daniel Camarena on 10/7/23.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    // Challenge 3
    var date = Date()
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    init() {
        
        people = []
        //Challenge 2
        /*
        if let data = UserDefaults.standard.data(forKey: saveKey) {
         */
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data){
                people = decoded
                return
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            //UserDefaults.standard.set(encoded, forKey: saveKey)
            saveFile(data: encoded)
        }
    }
    
    func add (_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect){
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    // Challenge 2
    private func saveFile(data: Data) {
        let url = getDocumentDirectory().appendingPathComponent(saveKey)
        
        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch let error {
            print ("Could not write to file \(error.localizedDescription)")
        }
    }
    
    // Challenge 2
    private func loadFile() -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(saveKey)
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
    }
    
    // Challenge 2
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
