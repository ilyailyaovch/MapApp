import SwiftUI

struct LocationPreviewView: View {

    @EnvironmentObject
    var vm: LocationsViewModel
    let location: Location

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            VStack(spacing: 8) {
                buttonLearnMore
                buttonNext
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        ).cornerRadius(10)
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let img = location.imageNames.first {
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.callout)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var buttonLearnMore: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Learn more")
                .font(.headline)
                .frame(width: 124, height: 30)
        }.buttonStyle(.borderedProminent)
    }
    private var buttonNext: some View {
        Button(action: { vm.nextButtonPressed() }) {
            Text("Next")
                .font(.headline)
                .frame(width: 124, height: 30)
        }.buttonStyle(.bordered)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        LocationPreviewView(location:LocationsDataService.locations.first!)
    }.environmentObject(LocationsViewModel())
}
