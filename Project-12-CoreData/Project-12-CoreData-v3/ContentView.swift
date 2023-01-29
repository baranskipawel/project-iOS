//
//  ContentView.swift
//  Project-12-CoreData-v3
//
//  Created by Pawel Baranski on 24/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries : FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? moc.save()
            }
        }
    }
}

//@Environment(\.managedObjectContext) var moc
//@State private var lastNameFilter = "A"
//
//var body: some View {
//    VStack {
//        FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//        }
//
//
//        Button("Add Examples") {
//            let taylor = Singer(context: moc)
//            taylor.firstName = "Taylor"
//            taylor.lastName = "Swift"
//
//            let ed = Singer(context: moc)
//            ed.firstName = "Ed"
//            ed.lastName = "Sheeran"
//
//            let adele = Singer(context: moc)
//            adele.firstName = "Adele"
//            adele.lastName = "Adkins"
//
//            try? moc.save()
//        }
//
//        Button("Show A") {
//            lastNameFilter = "A"
//        }
//
//        Button("Show S") {
//            lastNameFilter = "S"
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
