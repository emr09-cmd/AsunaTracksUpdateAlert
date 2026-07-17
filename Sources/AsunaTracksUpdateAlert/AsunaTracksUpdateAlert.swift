// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 15.0, *)
public struct AsunaTracksUpdateAlert: View {

    private let title: String
    private let message: String

    @State private var showAlert = false

    public init(
        title: String = "Hello world",
        message: String = "AsunaTracksUpdateAlert is working!"
    ) {
        self.title = title
        self.message = message
    }

    public var body: some View {
        Color.clear
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showAlert = true
                }
            }
            .alert(title, isPresented: $showAlert) {
                Button("OK") {
                    showAlert = false
                }
            } message: {
                Text(message)
            }
    }
}
