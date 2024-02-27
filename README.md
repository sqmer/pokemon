# Pokemon
Pokemon Listing and Details Application

## About
A small application such as this can be done using almost any architecture (MVC, MVVM, VIPER...).  Since this was a excercise to showcase my knowledge I decided to go with the Clean Architecture 

This architecture Decouple the Domain from the Data and Presentation modules, this gives us the flexibility to change any of the latter two without affecing the main business of the application. In other words the data can instead of an API Endpoint call can become a database or JSON file and both the Domain and Presentation are unaffected, same applues for Presentation.

Also makes sure the dependency is from the Domain to the Presentation.

Due to the above reasons this architecture is maintainable and scalable.

Besides from that the Infrastructure folder are Business Agnostic which means they can be reused in any other applicaion, even better would be converting them to a library.

I only included Unit Test for one class and some mocks as an example. Ideally all classes should have Unit Tests covering 100% of the functionality. 

UITests are not included yet and some parts still have TODO comments explain why they are not done due to time constraint.

Third Party frameworks whether from Swift Package Manager or Cocoapods have either a wrapper (e.g. KingFisherImageViewExtension) or dependecny inversion (e.g. MobileVLCKitAudioPlayer). 

## References

1. This project uses the APIs from https://pokeapi.co/
2. This project uses the following webhook which will expire 04-March-2024:
https://webhook.site/#!/view/b099222f-9c03-428c-b5cc-dfa1fadab974/6832a7e9-c1ea-4956-91a3-10703f325d05/1

## Room for Improvements
- Complete UnitTests
- Add UITests
- Finish TODOs
- Create Router Class for navigation
- Create DI and Flow class for AppDelegate start
- Caching
- Move Favorites from UserDefaults to another storage
- ViewbyCode (optional)

## Setup
1. Clone project:<br>
`git clone git@github.com:sqmer/pokemon.git`
2. Pod Install inside project:<br>
```
cd pokemon
pod install
```
3. Open workspace <br>
`open Pokemon.xcworkspace`




