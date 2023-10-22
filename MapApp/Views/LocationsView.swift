import SwiftUI

struct LocationsView: View {

    @EnvironmentObject var vm: LocationsViewModel

    var body: some View {
        List {
            ForEach(vm.locations) { loc in
                Text(loc.name)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
