# Liftoff 🚀

### An iOS app that displays SpaceX's Launches and Rockets

## Architecture

MVVM-C was my choice for architecture. Model-View-ViewModel is a simple yet flexible way of establishing data binding whilst keeping the UI and business logic separate. MVVM alone, however, doesn't give us a clean way to manage routing. The coordinators introduced helps us maintain separation of concerns and ensures the controller focuses on managing the views UI output and input only, navigation and ViewModel creation are handled by the coordinator.

## Design Patterns

With the help of RxSwift and friends, I was able to implement this project reactively. Inherently from the observer design pattern, Rx utilizes asynchronous streams as inputs and outputs. Rx binds UI to data streams so that it can update seamlessly when new information arrives, which in this case will be from our SpaceX network calls.

The Delegation Pattern is being used for navigation, combined with coordinators this provides a clean solution for handling navigation logic elsewhere from the controller itself.

## Assumptions

The API call to `https://api.spacexdata.com/v3/launches/{flightNumber}` returned almost the same results as what was available in launches. However, as the requirements specified a further API call I did so assuming this endpoint may have updated data.

A cell view model could have been added to further abstract the launch model from the UI but the majority of properties from the LaunchModel already needed to be displayed in the cell or to passed through to fetch the detail.

The delegation pattern used in the coordinators for navigation required a stronger retain cycle, hence a local variable is being set where the coordinators are being created, otherwise the delegate = nil in the places where it's trying to be used

I've gone with the assumption that the user would like to see the initial list displaying all launches and ordered by latest.

### Further Work

A way to reload the launches could be added. A table view pull to refresh or a button somewhere that calls the retrieveLaunches() function.

Error handling for failed API calls. An alert could be shown to the user describing what went wrong in a meaningful way.
