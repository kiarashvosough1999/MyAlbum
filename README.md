# MyAlbum

This project is a small photo album application which fetch Albums and Photos from API Below:

1. [Album](https://jsonplaceholder.typicode.com/albums)
2. [Photos](https://jsonplaceholder.typicode.com/photos)

# Approach

1. Chose `SwiftUI` To develop the UI faster.
2. Chose `TCA(Composable-Architecture)`, to get the most out of SwiftUI state-managment and not struggle with handling different states with properties of an ObservableObject.
3. Used `Dependencies` to handle dependency managment as it has great adaptibility with TCA and great tools for testing.
4. Followed TDD to write several Unit Tests for Reducer and UseCases, and UITest.
5. Used clean architecture to keep layer seperated and follow **seperation of concerns**.

# UI Senarios

## Album List
User can:

1. See a list of Albums with the first photo of that album's image as a thumbnail.
2. Filter Albums By userId from context menu on top-navigation-bar and clicking on UserIDs sub menu.
3. Change the list style to sectioned byUserIds.
4. Tap on each Album to be navigated to Photos of that album.

## Photos List

User can:

1. See a list of Photos(thumbnail) With its titles.
2. Tap on each row to see the high quality image instead, and tap again to hide.
3. Navigate back to album list.

# Architecture & Tools

- [x] Deployment target: iOS 16.4
- [x] Devices: iPhone, iPad, macOS(Designed for iPad)
- [x] Redux(Presentation) + Clean
- [x] Language: Swift 5
- [x] SwiftUI
- [x] Composable-Architecture
- [x] Github-Action

## Features and Bonuses

- [x] Build and Test with Github Action.
- [x] Ability to filter Albums by userId.
- [x] An album has a random cover image from the photos within it.
- [x] When browsing an album and clicking on an image thumbnail (photos.thumbnailUrl), the user can view the larger version of the image (photos.url).
- [x] Design System(reusable compnnents and Modifiers to reduce code duplications).
- [x] **Unit and UI `Tests`**.
- [x] Dependency Managment.
- [x] Self Implemented Network Layer.
- [x] Fancy Animations and Transitions.
- [x] Used `DTO` and DTO Mapping.
- [x] Layers Depend on Abstraction/Interfaces(**Scalability, Testability**).

## Demonstrated Values

- [x] Prevent rerendering Views if not changed.
- [x] Cache Random image which was loaded, in order not to loadi it again for each album.
- [x] Used `Lazy` List to render views only when visible.
- [x] Image `Caching`(with memory and disk threshold).
- [x] Avoided Complexity(**Simplicity, Maintainability**).
- [x] Readable Clean code(**Maintainability**).

# Building At Scale

1. Better Dependency Management tools or solution to handle modular architecture.
2. Improve DesignSystem and UX.
3. Integrate a Repository Layer to cache image indenpendently from Network Layer.
4. Use Feature Module.
5. Use Project Generator(Tuist) to avoid complex conflict(xproj) and handle extensions and static configuration more conveniently.
6. Use Dynamic Page Routing.

# Todo

- [] Write more UITests.

# Diagram

![](./resources/diagram.png)
