# Dogtionary

Looking at doggy photos is always a happy thing, and you can do exactly that with Dogtionary! Thanks to a stunning [Dog API](https://dog.ceo/dog-api/), this app provides a list of dog breeds along with their random photos in the form of a simple but user-friendly interface.

**How to install**

- To run the project, simply clone the [repository](https://github.com/vanjang/Dogtionary.git) and run, then you are good to go.


**Key Features**

- This app consists of a Breed list page and a Breed detail page.
- The breed list page lists breeds alphabetically. The breed detail page displays up to 10 random photos of the selected breed.
- You can see the detailed photos by clicking on the photo on the detail page.
- You can search breeds as you type.


**Note**

- Some breeds may have less than 10 photos available in the server database.
- Pagination is not applied as the provided response is very small.


**Tech Stack**

- Swift
- UIKit
- Combine
- MVVM-C
- Unit Testing
- UI Testing


**Libraries in use**

- Kingfisher library is imported for displaying remote images.


**Project Structure**

The project is organized primarily by features (or scenes) for scalability.

- Common: Files such as shared models, extensions, utils, App delegate files that are used across the project.
- Service: Service classes such as Network layer.
- UseCases: Defines the core usages for the features. For this small app, this only has BreedUseCase.
- FlowCoordinators: Contains coordinators.
- Features: Contains feature folders. Each feature folder has views, view controllers, and view models.


**Brief System Design**

The project strives to modularise components for scalability and maintainability. Protocols are actively used for testability. Below is how the project is designed:

<img width="862" alt="Screenshot 2024-02-11 at 23 07 21" src="https://github.com/vanjang/Dogtionary/assets/54963905/d9b90e9d-2ad8-49ff-be8d-8666b8d39689">

