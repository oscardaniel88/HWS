//
//  PhotoItemMapView.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import SwiftUI
import MapKit

struct PhotoItemMapView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Map(coordinateRegion:$viewModel.mapRegion, annotationItems: [viewModel.photoItem]){
            photoItem in
            MapAnnotation(coordinate: photoItem.coordinate){
                    VStack{
                        Image(uiImage: photoItem.uiImage)
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                            .onTapGesture {
                                viewModel.showingDetailView = true
                            }
                        
                        Text(photoItem.name)
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .fixedSize()
                    }
                }
        }.sheet(isPresented: $viewModel.showingDetailView){
            PhotoItemDetailView(photoItem: viewModel.photoItem)
        }
    }
    
    init(photoItem: PhotoItem){
        let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: photoItem.latitude, longitude: photoItem.longitude), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        _viewModel = StateObject(wrappedValue:ViewModel(photoItem: photoItem, mapRegion: mapRegion))
    }
}

struct PhotoItemMapView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemMapView(photoItem: PhotoItem(id: UUID(), uiImage: UIImage(), name: "TEST", latitude: 37.0, longitude: -122.0))
    }
}
