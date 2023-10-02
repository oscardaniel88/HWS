//
//  EditPhotoItemView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 9/30/23.
//

import SwiftUI

struct EditPhotoItemView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (PhotoItem) -> Void
    @StateObject var viewModel: ViewModel
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Type a name", text: $viewModel.photoName)
                }
                Section{
                    viewModel.image?
                    .resizable()
                    .scaledToFit()
                }
            }
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                dismiss()
                onSave(viewModel.updatePhotoItem())
            }
                .disabled(viewModel.photoName.isEmpty)
            )
        }
    }
    
    init(uiImage: UIImage?, locationFetcher: LocationFetcher, onSave: @escaping(PhotoItem) -> Void){
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(uiImage: uiImage, locationFetcher: locationFetcher))
    }
}

struct EditPhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoItemView(uiImage: nil, locationFetcher: LocationFetcher()){ photoItem in }
    }
}
