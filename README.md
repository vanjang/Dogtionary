# Dogtionary

Looking at doggy photos is always a happy thing, and you can do exactly that with Dogtionary! Thanks to a stunning [Dog API(https://dog.ceo/dog-api/)], this app provides a list of dog breeds along with their random photos in the form of a simple but user-friendly interface.

**How to install**

- To run the project, just clone the [repository](https://github.com/vanjang/Dogtionary.git) and run, then you are good to go.


**Key Features**

- This app consists of Breed list page and Breed detail page.
- The breed list page lists breeds all the way down. The breed detail page displays up to 10 random photos of the selected breed.
- You can see the detailed photo by clicking on the photo of the detail page.
- You can search breeds as you type.

**Note**
- The photos of some breed has less than 10 photos as the server database provides.
- The photos ofPagination is not applied as the given response is very small.
- Pagination is not applied as the given response is very small.


**Tech Stack**

- Swift
- UIKit
- Combine
- MVVM-C
- Unit Testing
- UI Testing
- Kingfisher library is imported for displaying remote images


**Project Structure**

Basically the project is organised by features(or scenes) as I think it is more scalable structuring.
- Common: Files such as shared models, extensions, utils, App delegate files that are used across the project.
- Service: Service classes such as Network layer.
- UseCases: Defines the core usages for the features. For this small, the app this only has BreedUseCase.
- FlowCoordinators: Contains coordinators.
- Features: Contains feature folders. Each feature folder has views, view controllers, and view models.
