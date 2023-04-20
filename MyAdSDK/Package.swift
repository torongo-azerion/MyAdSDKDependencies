// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyAdSDK",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyAdSDK",
            targets: ["MyAdSDKWrapper"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", .upToNextMajor(from: "10.0.2")),
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "MyAdSDKWrapper",
                dependencies: [
                    .target(name: "MyAdSDK", condition: .when(platforms: [.iOS])),
                    .target(name: "MyDFPAdapterWrapper", condition: .when(platforms: [.iOS])),
                ],
                path: "MyAdSDKWrapper"
               ),
        .target(name: "MyDFPAdapterWrapper",
                dependencies: [
                    .target(name: "MyDFPAdapter", condition: .when(platforms: [.iOS])),
                    .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
                ],
                path: "MyDFPAdapterWrapper"
               ),
        //core
        .binaryTarget(name: "MyAdSDK", url: "https://github.com/torongo-azerion/MyAdSDKDependencies/raw/main/MyAdSDK.zip", checksum: "9ba5f39ac5b3fe962bb187335fe98276c1bfb006c874a9b6cf49707e8788c1fc"),
        //dfp
        .binaryTarget(name: "MyDFPAdapter", url: "https://github.com/torongo-azerion/MyAdSDKDependencies/raw/main/MyDFPAdapter.zip", checksum: "2fda37d956185e63429330bc7769b0b892216fc527ed11ed5807e6d6356c1587"),
    ]
)
