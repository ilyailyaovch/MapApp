import Foundation
import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {

    /// Full  list of locations from DataService
    @Published var locations: [Location]

    /// Current location on the map
    @Published var mapLocation: Location {
        didSet { updateMapRegion(location: mapLocation) }
    }

    /// Current region on the map
    @Published var mapRegion: MKCoordinateRegion

    /// Show list of locations
    @Published var showLocationsList = false

    /// Show LocationDetailsSheet
    @Published var sheetLocation: Location? = nil

    let standartSpan = MKCoordinateSpan(
        latitudeDelta: 0.1,
        longitudeDelta: 0.1)
    let zoomedSpan = MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01)

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.mapRegion = MKCoordinateRegion()
        self.updateMapRegion(location: mapLocation)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: standartSpan)
        }
    }

    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            self.showLocationsList.toggle()
        }
    }

    func changeLocation(_ location: Location) {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            self.showLocationsList = false
        }
    }

    func nextButtonPressed() {
        guard let current = locations.firstIndex(where: {
            $0 == mapLocation
        })
        else { return }
        let next = current + 1
        guard locations.indices.contains(next)
        else {
            let zeroIndexLocation = locations.first!
            changeLocation(zeroIndexLocation)
            return
        }
        let nextIndexLocation = locations[next]
        changeLocation(nextIndexLocation)
    }
}
