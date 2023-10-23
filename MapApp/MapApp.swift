//
//  MapApp.swift
//  MapApp
//
//  Created by Ilya Ovchinnikov on 22.10.2023.
//

import SwiftUI

@main
struct MapAppApp: App {

    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView().environmentObject(vm)
        }
    }
}
