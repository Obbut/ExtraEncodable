// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "ExtraEncodable",
    products: [
        .library(
            name: "ExtraEncodable",
            targets: ["ExtraEncodable"]),
    ],
    targets: [
        .target(
            name: "ExtraEncodable",
            dependencies: []),
        .testTarget(
            name: "ExtraEncodableTests",
            dependencies: ["ExtraEncodable"]),
    ]
)
