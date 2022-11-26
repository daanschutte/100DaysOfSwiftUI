//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Daan Schutte on 26/11/2022.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    enum FilteredListPredicates: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS"
        case endsWith = "ENDSWITH"
        case like = "LIKE"
        case matches = "MATCHES"
    }
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(predicate: FilteredListPredicates, filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue)
        )
        
        self.content = content
    }
}
