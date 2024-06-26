# rridefraser

This a two-page flutter application that implements a user authentication flow using the BLOC state management. On successful login, the user is taken to a products page where all the product endpoint is consumed and displayed.

Packages Used
- http (https://pub.dev/packages/http): This package handles the network requests to login and request products
- shared_preferences (https://pub.dev/packages/shared_preferences): On successful login, the access token is stored on the device
- bloc (https://pub.dev/packages/flutter_bloc): This package handled all the states in the application. From loading to error handling, it updates the UI of the right states to display
- shimmer (https://pub.dev/packages/shimmer): This package is used to create a loading effect when requesting the products' list

Architecture
I used a clean separation of concerns architecture: data, domain, and UI packages. The data contains the NetworkHelper class to make requests and a NetworkReposirory which handles the network call together with its response states The domain contains code accessed by both data and UI layers. In the domain layer is the Product model class used to deserialize the JSON response for the product list. The UI layer contains the bloc class and ui element which responds according to the network call states accordingly.
<img width="291" alt="Screenshot 2024-06-26 at 01 05 31" src="https://github.com/Odunaike/rridefraser/assets/97701782/4ffaa596-ae01-486d-a04f-51fcd862685e">
<img width="291" alt="Screenshot 2024-06-26 at 01 04 12" src="https://github.com/Odunaike/rridefraser/assets/97701782/941d6198-5fad-4659-b973-ff3fc3b55776">


https://github.com/Odunaike/rridefraser/assets/97701782/90d48839-c35e-40e3-8dc2-71ab6d027430

