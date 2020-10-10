// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "AlertController",
    products: [
        .library(name: "AlertController", targets: ["AlertController"]),
    ],
    targets: [
        .target(name: "AlertController", path: "AlertController")
    ]
)
