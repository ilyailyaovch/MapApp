import SwiftUI

struct LocationsListView: View {

    @EnvironmentObject var vm: LocationsViewModel

    var body: some View {
        List {
            ForEach(vm.locations) { loc in
                Button(action: { vm.changeLocation(loc) }) {
                    listRowView(loc)
                }
                .padding(.vertical, 4)
                .background(.clear)
            }
        }.listStyle(.plain)
    }
}

extension LocationsListView {
    private func listRowView(_ loc: Location) -> some View {
        HStack {
            // MARK: Img
            if let imgName = loc.imageNames.first {
                Image(imgName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            // MARK: Name
            VStack(alignment: .leading) {
                Text(loc.name)
                    .font(.headline)
                Text(loc.cityName)
                    .font(.subheadline)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        LocationsListView().environmentObject(LocationsViewModel())
    }

}
