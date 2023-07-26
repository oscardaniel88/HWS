//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Daniel Camarena on 7/25/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self){
            singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filter: String, @ViewBuilder content: @escaping(T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filter))
        self.content = content
    }
}
