//
//  EditView-ViewModel.swift
//  Project-14-BucketList
//
//  Created by Pawel Baranski on 28/01/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        var location: Location

        @Published var loadingState: LoadingState = .loading
        @Published var pages: [Page] = []

        @Published var name: String
        @Published var description: String

        init(location: Location) {
          name = location.name
          description = location.description
          self.location = location
        }

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }

        struct Result: Codable {
            let query: Query
        }

        struct Query: Codable {
            let pages: [Int: Page]
        }

        struct Page: Codable, Comparable {
            let pageid: Int
            let title: String
            let terms: [String: [String]]?

            var description: String {
                terms?["description"]?.first ?? "No further information"
            }

            static func <(lhs: Page, rhs: Page) -> Bool {
                lhs.title < rhs.title
            }
        }

        enum LoadingState {
            case loading, loaded, failed
        }
    }
}
