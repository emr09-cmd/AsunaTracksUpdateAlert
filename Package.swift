// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "AsunaTracksUpdateAlert",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AsunaTracksUpdateAlert",
            targets: ["AsunaTracksUpdateAlert"]
        )
    ],
    targets: [
        .target(
            name: "AsunaTracksUpdateAlert"
        )
    ]
)
