//
//  ContentView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    let locationFetcher = LocationFetcher()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.photoItems.sorted()){
                    item in
                    NavigationLink {
                        PhotoItemMapView(photoItem: item)
                    } label: {
                        HStack{
                            Image(uiImage:item.uiImage)
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                                .padding(.trailing)
                            Text(item.name)
                                .font(.headline)
                        }
                    }
                }.onDelete(perform:viewModel.deleteImage)
            }
            .onAppear(perform: locationFetcher.start)
            .sheet(isPresented: $viewModel.showImagePicker){
                ImagePicker(image: $viewModel.uiImage, didSelectImage: $viewModel.didSelectImage)
            }
            .sheet(isPresented: $viewModel.didSelectImage){
                EditPhotoItemView(uiImage: viewModel.uiImage, locationFetcher: locationFetcher){
                    viewModel.addImage(photoItem: $0)
                }
            }
            .padding()
            .navigationBarTitle("Photo Namer", displayMode: .inline)
            .navigationBarItems(trailing: Button("Add"){
                viewModel.showImagePicker = true
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
