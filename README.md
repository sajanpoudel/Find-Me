 <h1> FIND ME </h1> 
  
Find Me is an cross-platform mobile application where you can find any of your lost items.

![original](https://user-images.githubusercontent.com/35656849/198723651-6a28e072-09c6-4cfb-8865-a8f551ce9d8a.png)


<h2>Inspiration</h2>

Losing something valuable to you is not a good feeling. I lost my bag full of personal documents on my way to Texas last week in a hackathon program at University of Texas at Austin. I panicked and it was important. Someone could have found it and I wished I would have known the person somehow or that person could let me know that he/she had found it. So I came up with an idea of building an app that lets people know about what they have lost.

<h2>What it does? </h2>
If someone finds anything, they just only submit a photo of it, add their name, and give the relevant information about the item. This would facilitate the app's use in making things more easily accessible. A phone call's feature to reach a person who has misplaced an item and found it is also available.

<h2>How we built it?</h2>
We built this app by using flutter, Firestore, Google map API, Dart, 3D graphics, Google login API and Firebase auth.


<h2>What are the Future Steps?</h2>
In order to monitor exactly where the individual found the item, we intend to integrate the Google Maps function in the near future. For the various products, we also intend to integrate the meta data option. To filter and display items within a certain distance, we might implement a distance Search function.

<h2>Demo: </h2>

 ![image description](https://github.com/sajanpoudel/Find-Me/blob/demo-video/videoplayback.gif) 


## Run the app

1. Install Flutter and create a Firebase project with Authentication and Storage enabled.
2. Add your own `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) to the platform folders.
3. Fetch packages and start the app:

```
flutter pub get
flutter run
```

## Project layout

- `lib/main.dart` starts Firebase and the app, `lib/routes.dart` lists the named routes.
- `lib/screens/home` shows the lost items and `lib/screens/upload` lets someone post a found item with a photo.
- `lib/screens/sign_in`, `sign_up` and `forgot_password` handle authentication.
- `lib/components/` has the widgets shared between screens.

## Tests

```
flutter test
```
