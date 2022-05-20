// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavouritesFlowLayoutFeature",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FavouritesFlowLayoutFeature",
            targets: ["FavouritesFlowLayoutFeature"]),
    ],
    dependencies: [
        .package(path: "../Utilities"),
        .package(path: "../WeatherDetailFeature")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FavouritesFlowLayoutFeature",
            dependencies: ["Utilities", "WeatherDetailFeature"]),
        .testTarget(
            name: "FavouritesFlowLayoutFeatureTests",
            dependencies: ["FavouritesFlowLayoutFeature"]),
    ]
)
