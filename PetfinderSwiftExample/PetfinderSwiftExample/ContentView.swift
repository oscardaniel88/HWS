//
//  ContentView.swift
//  PetfinderSwiftExample
//
//  Created by Daniel Camarena on 2/18/24.
//

import SwiftUI

struct ContentView: View {
    @State var response = [Animal]()
    @State var loading = true
    @State var endOfPageIdx = 0
    @State var currentPage = 1
    var body: some View {
            ScrollView {
            LazyVStack {
                ForEach(Array(response.enumerated()), id: \.element) {index, response in
                    VStack{
                        HStack{
                            AsyncImage(url: URL(string: response.photos?.first?.small ?? "")){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            /*@START_MENU_TOKEN@*/Text(response.name)/*@END_MENU_TOKEN@*/
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        Divider()
                            .padding(.horizontal, 16)
                        if(index == endOfPageIdx - 1 && loading){
                            ProgressView()
                        }
                        
                    }
                    .task {
                        if(index == endOfPageIdx - 1){
                            do{
                                currentPage = currentPage + 1
                                loading = true
                                try await loadData()
                            }catch {}
                        }
                    }
                }
            }
        }
        .task {
            do{
                loading = true
                try await loadData()
            }catch {}
        }
    }
    
    func loadData() async throws -> () {
        do{
            let token =  try await APIService.shared.getAccessToken()
            let response = try await APIService.shared.search(token: token.accessToken, pageNumber: currentPage)
            self.endOfPageIdx = self.endOfPageIdx +  response.count
            self.response.append(contentsOf: response)
            loading = false
        } catch {
            loading = false
            print("Exception \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
