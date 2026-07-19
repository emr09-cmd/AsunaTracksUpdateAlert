// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 15.0, *)
public struct AsunaTracksUpdateAlert: View {

    // MARK: - Config

    /// Bump this with every release you tag on GitHub.
    private let currentVersion: String
    private let versionCheckURL: URL
    private let releasesURL: URL

    // MARK: - State

    @State private var showAlert = false
    @State private var remoteVersion: String?

    public init(
        currentVersion: String = "v0.7-alpha",
        versionCheckURL: URL = URL(string: "https://raw.githubusercontent.com/emr09-cmd/AsunaTracksAppDetect/refs/heads/main/LatestVersion.AsunaTracks-emr09")!,
        releasesURL: URL = URL(string: "https://github.com/emr09-cmd/AsunaTracks/releases")!
    ) {
        self.currentVersion = currentVersion
        self.versionCheckURL = versionCheckURL
        self.releasesURL = releasesURL
    }

    public var body: some View {
        Color.clear
            .onAppear {
                Task { await checkForUpdate() }
            }
            .alert("Update available", isPresented: $showAlert) {
                Button("Update") {
                    UIApplication.shared.open(releasesURL, options: [:], completionHandler: nil)
                }
                Button("Not Now", role: .cancel) {
                    showAlert = false
                }
            } message: {
                Text("A new version of AsunaTracks is available\(remoteVersion.map { " (\($0))" } ?? ""). Update now to get the latest features and fixes.")
            }
    }

    // MARK: - Networking

    private func checkForUpdate() async {
        do {
            let (data, response) = try await URLSession.shared.data(from: versionCheckURL)
            guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                return
            }
            guard let raw = String(data: data, encoding: .utf8) else { return }

            let latest = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !latest.isEmpty else { return }

            await MainActor.run {
                remoteVersion = latest
                if latest != currentVersion {
                    showAlert = true
                }
            }
        } catch {
            // Silently ignore network/parsing errors — no alert shown if we can't verify.
            print("AsunaTracksUpdateAlert: version check failed — \(error.localizedDescription)")
        }
    }
}
