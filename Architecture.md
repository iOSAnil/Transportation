## Table of Contents

- [Design Pattern](#designPattern)
- [XCUnitTestCases](#UnitTestCases)
- [XCUITestCases](#UITestCases)

  
# Design Pattern
MVVM + Coordinator + ViewStates

- Model: Response decodable model objects
- View(or ViewController): ViewController embedded with a view, handling UI events received from UI elements and dispatch the events to ViewModel. ViewController registered the viewModel publishers and render the UI with the latest ViewState.
- ViewModel: Handling the triggered events from viewController. Call APIContext (injected from coordinator), received response, convert to ViewStates and publish with the help of publisher. 

Best practices:

- Network Manager is created which will be helpful at any point if the project needs to change the third party library from Alamofire to anything else.
- App is free from leaks and tested with leaks and allocation tool. 
- Protocol interfacing for most of the layer to help in the test cases and reusability prescpective.
- ViewController only reacting to ViewStates. (No hardcoding of showing/Removing loaders)
- Since Apple is moving towards SwiftUI (declarative code for UI creation) This project is being created without using any XIB or Storyboards.
- Warning is created to showcase that demokey is used for the project.

# XCUnitTestCases

- URLProtocol is used to intercept the network layer response.
- ViewModel is being tested with MockAPIContext.

# XCUITestCases

Page Object Model: Design pattern used for organising and maintaining the UI elements of a mobile application in a structured manner. 

- Pages Responsibility: To create the XCUIElements and methods provoking operation on them.
- TestCase Responsibility: To call the screen  the XCUIElements and methods provoking operation on them.
- BaseClassForTestCases: Helper method with Asserts.

Best practices Used:

- BaseClassForTestCases has all the Assert’s which help to have clear code on the test cases and pages classes.


# App ScreenShots

Train list screen
![Simulator Screen Shot - iPhone 14 Pro - 2023-09-12 at 08 49 23](https://github.com/iOSAnil/Transportation/assets/144589414/6430671f-e142-4f40-adca-e4c455aa7e8d)

Station list screen
![Simulator Screen Shot - iPhone 14 Pro - 2023-09-12 at 08 49 38](https://github.com/iOSAnil/Transportation/assets/144589414/e0fa308f-33bd-4fc2-b45d-bce44411eb70)

App video
https://github.com/iOSAnil/Transportation/assets/144589414/009b3da3-cfba-4219-98b0-26a61121c3e6

TestCases snapshot
<img width="1510" alt="Screenshot 2023-09-12 at 9 24 28 AM" src="https://github.com/iOSAnil/Transportation/assets/144589414/810e65d8-ec67-4c6e-ab1a-a5d1726f7eb4">

Leaks and allocation snapshot (Movement from Train list to station list screen and then coming back to station list screen)
<img width="1503" alt="Screenshot 2023-09-12 at 11 40 44 PM" src="https://github.com/iOSAnil/Transportation/assets/144589414/360ca1dc-3c5e-4a3f-82f8-c0d3fcfd1f00">

