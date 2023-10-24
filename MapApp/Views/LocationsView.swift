import SwiftUI
import MapKit

struct LocationsView: View {

    @EnvironmentObject var vm: LocationsViewModel

    var body: some View {
        ZStack {
            mapLayer
            VStack {
                header
                Spacer()
                footer
            }
        }.sheet(item: $vm.sheetLocation) { loc in
            LocationDetailsView(location: loc)
        }
    }
}

extension LocationsView {
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { loc in
            MapAnnotation(coordinate: loc.coordinates) {
                LocationMapPinView()
                    .scaleEffect(vm.mapLocation == loc ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture { vm.changeLocation(loc) }
            }
        })
        .ignoresSafeArea()
        .onTapGesture {}
        .onLongPressGesture(perform: {})
    }
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:
                                vm.showLocationsList ? 180 : 0))
                    }
            }
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, y: 15)
        .padding()
    }
    private var footer: some View {
        ZStack {
            ForEach(vm.locations) { loc in
                if vm.mapLocation == loc {
                    LocationPreviewView(location: loc)
                        .padding()
                        .shadow(radius: 16)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
                        )
                }
            }
        }
    }
}

#Preview {
    LocationsView().environmentObject(LocationsViewModel())
}
