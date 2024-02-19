//
//  ContentView.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var response = [Animal]()
    @State var petTypes = [petType]()
    @State private var selectedType = petType(name: "Dog", _links: Links(breeds: Href(href: "/v2/types/dog/breeds")) )
    @State var loading = true
    @State var endOfPageIdx = 0
    @State var currentPage = 1
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Picker("Strength", selection: $selectedType) {
                        ForEach(petTypes, id: \.self) { petType in
                            Text(petType.name).tag(petType)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedType) {
                        Task {
                            resetState()
                            await loadData()
                        }
                    }
                    Spacer()
                }
                if(response.count == 0 && loading) {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(Array(response.enumerated()), id: \.element) {index, response in
                                VStack{
                                    AnimalListCellView(photos: response.photos, name: response.name)
                                    Divider()
                                        .padding(.horizontal, 16)
                                    if(index == endOfPageIdx - 1 && loading){
                                        ProgressView()
                                    }
                                    
                                }
                                .task {
                                    if(index == endOfPageIdx - 1){
                                        currentPage = currentPage + 1
                                        loading = true
                                        await loadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .task {
                await loadData()
                await loadPetTypes()
            }.navigationTitle("Pet finder 🐶")
                .font(.headline)
        }
    }
    
    func resetState() -> () {
        self.response = [Animal]()
        loading = true
        endOfPageIdx = 0
        currentPage = 1
    }
    
    func loadData() async  -> () {
        do{
            let token =  try await APIService.shared.getAccessToken()
            let response = try await APIService.shared.search(tokenType: token.tokenType, token: token.accessToken, type: self.selectedType, pageNumber: currentPage)
            self.endOfPageIdx = self.endOfPageIdx +  response.count
            self.response.append(contentsOf: response)
            loading = false
        } catch {
            loading = false
            print("Exception \(error.localizedDescription)")
        }
    }
    
    func loadPetTypes() async -> (){
        do {
            let token = try await APIService.shared.getAccessToken()
            let petTypeResponse = try await APIService.shared.getTypes(tokenType: token.tokenType, token: token.accessToken)
            self.petTypes = petTypeResponse
        } catch {
            print("Exception \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
