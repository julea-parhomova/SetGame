//
//  SetGameApp.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/23/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: ViewModel())
        }
    }
}
