# flutter_du_13

## Project

This project is an e-shop app where people can buy and sell all kind of stuff. There is 2 types of account : buyer or seller.

## Deploy the app locally

First clone this project and enter the project directory.

### On Ios

You need a Mac with Xcode installed.
Open a simulator with `open -a Simulator` in your terminal.
Then run `flutter run`.

More infos on : https://docs.flutter.dev/get-started/install/macos#ios-setup

### On Web

Run `flutter run -d chrome`.

### On Android

Install Android Studio.
Open an Android Simulator or connect an Android device.
Then run `flutter run`.
More infos on : https://docs.flutter.dev/get-started/install/macos#install-android-studio


### Dependencies

  blackfoot_flutter_lint: This is used to check every error and warning in the project.
  More infos on : https://pub.dev/packages/blackfoot_flutter_lint

  cloud_firestore: This dependence is the database.
  More infos on : https://pub.dev/packages/cloud_firestore

  cupertino_icons: This is a dependence to add some icons in our application.
  More infos on : https://pub.dev/packages/cupertino_icons

  curved_navigation_bar: This is used to cretae all the animation and the design of our buttom bar on mobile devices.
  More infos on : https://pub.dev/packages/curved_navigation_bar

  firebase_auth: firebase dependency is for manage the authentification.
  More infos on : https://pub.dev/packages/firebase_auth

  firebase_core: firebase dependency is for initialise firabase in our application.
  More infos on : https://pub.dev/packages/firebase_core

  firebase_storage: firebase dependencie to manage the files.
  More infos on : https://pub.dev/packages/firebase_storage

  firebase_storage_web: firebase dependencie to manage the web files.
  More infos on : https://pub.dev/packages/firebase_storage_web

  flutter
    sdk: flutter : This is all basics import from flutter that allow us to do everithing in the project.

  flutter_svg: This dependence is used to allowed us to load the svg files.
  More infos on : https://pub.dev/packages/flutter_svg

  fluttertoast: This dependence is used to display some toast / pop up when an action in the app is completed / done.
  More infos on : https://pub.dev/packages/fluttertoast

  go_router: Allowed us to change between the screen and add a path in the url for all tha pages.
  More infos on : https://pub.dev/packages/go_router

  image_picker: Allowed us to select the picture from our devices.
  More infos on : https://pub.dev/packages/image_picker

  provider: The provider dependency give us the right to share some variable between the screens. This is verry helpful to retrive the data from another scren and perfom the action choosen.
  More infos on : https://pub.dev/packages/provider
  
  ### Architecture
  
  `/assets` Contain all images and fonts of the application
  `/android` Contain all files relative to Android execution.
  `/ios` Contain all files relative to iOS execution.
  `/lib/` Contain all source code
  `/lib/animations` File code for animation
  `/lib/constants` Files with colors and responsive constants
  `/lib/providers` Files code with all the model provider
  `/lib/screens` Folders for each page of the application
  `/lib/ui` shared components
  `/lib/utils` functions that can be used in all the application
  `/lib/router.dart` Contain all route of the application.
