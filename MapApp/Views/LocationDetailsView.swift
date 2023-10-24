import SwiftUI
import MapKit

struct LocationDetailsView: View {

    @EnvironmentObject var vm: LocationsViewModel
    let location: Location

    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(radius: 20)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSecton
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

extension LocationDetailsView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    private var descriptionSecton: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wiki", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: vm.zoomedSpan)),
            annotationItems: [location]) { loc in
            MapAnnotation(coordinate: loc.coordinates) {
                LocationMapPinView()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 6)
                .padding()
        }
    }
}

#Preview {
    LocationDetailsView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}
