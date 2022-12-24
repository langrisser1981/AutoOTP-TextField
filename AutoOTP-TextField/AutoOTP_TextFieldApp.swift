//
//  AutoOTP_TextFieldApp.swift
//  AutoOTP-TextField
//
//  Created by 程信傑 on 2022/12/24.
//

import SwiftUI

@main
struct AutoOTP_TextFieldApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15, *) {
                NavigationView {
                    ContentView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                }
            } else {
                NavigationStack {
                    ContentView()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar(.hidden, for: .navigationBar)
                }
            }
        }
    }
}
