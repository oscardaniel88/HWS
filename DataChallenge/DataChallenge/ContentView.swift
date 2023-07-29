//
//  ContentView.swift
//  DataChallenge
//
//  Created by Daniel Camarena on 7/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    var body: some View {
        List(users) { user in
            HStack{
                LazyVStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                }
                HStack{
                    Text("\(user.friends.count)")
                    Image(systemName: "person.fill")
                    
                }
                
            }
            
        }
        .task{
            await loadData()
        }
    }
    
    func loadData() async {
        if(users.isEmpty) {
            print("fetching data")
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
            else {
                print("Invalid url")
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {data, response, error in
                guard let userData = data else {
                    print("No data in response \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                let userDecoder = JSONDecoder()
                userDecoder.dateDecodingStrategy = .iso8601
                do {
                    users = try userDecoder.decode([User].self, from: userData)
                    return
                } catch {
                    print("Decoding failed: \(error)")
                }
                print("Fetched failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
