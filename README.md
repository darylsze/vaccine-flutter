# Vaccine in Flutter. This project is for demo only.

# introduction
I did want to publish this project into play store, however this is sensitive time to Google to prevent misleading information spread about COVID-19, so I paused my plan and public it. 

This is for my personal demo, in which I have tried different Fluter technique, for example, BLoC in Cubit for state management, Google Ads and Map services, as well as Firebase push notification. 

# Tech involved
## BLoC
In project, I picked Cubit instead of BLoC for state management. It is a simple yet essential core in BLoC framework. It provides easy to use interface for developers to start BLoC pattern fast. It has many features that BLoC framework emphasis, for example, easy to predict state changes, reactive pattern for components subscription and Flutter DevTool previewable.

However, it does not have transforming features which BLoC class provides, nor the detailed logging for event received, under this limitation, we can log the state changes only. 

Depends on how complexity you want for your project, normally I choose easy yet powerful library for my projects, but I did doing a relatively comprehensive project that uses BLoC for better maintanence thereafter. 

## Theme
Dark theme and light theme

## Json Serializable
To deserialize json quickly from Restful Api, I used famous library json_serializable (https://github.com/google/json_serializable.dart) although the experience is bad (discuss in Summary section)

# Difficulties
## Google Adsense
For Google's official Ads library, it is very hard to use and buggy, I can't integrate it into project easily, tho I think spend more time can still figure out the solution, I evenually picked unofficial one and seems works pretty good. 

## BLoC
For BLoC pattern, cubit is easy and did quite well, however I would pick RiverPods since next project, because imho Provider + Hooks inside RiverPods is killer pattern for flexibility and simplicity.

## Null-safety
Null-safety is good for Dart 2.12 or later, but current not all libraries support and some library are essentials, for example, Firebase from Google. To make the project easy to integrate different libraries, I have explicity turn off the null-safety by unsound it (https://dart.dev/null-safety/unsound-null-safety). 

# Improvements
1. Commit message need to follow Semantic Versioning strictly in order to make auto release work to pump version itself.
2. Refactor project to use RiverPods
3. Abstract functions that returning widget to a standalone stateless component (as discussed [here](https://ithelp.ithome.com.tw/articles/10237959) and [here](https://github.com/flutter/flutter/issues/19269) that function widget produce different widget tree hierarchy)  

# Summary
It is my first time to write a complete production ready app with different Flutter famous libraries and recommended frameworks. During the development, I think Google aims high that provides so many UI libraries into Flutter, definitely make developers life easier than doing native. For parallex effects, go for SliverXXX, for simple informative structure, go for ListView, Column or Row. Such decorative way to develop UI provides unprecedented joyful to me. Doing Flutter is way faster  than React and native.

However, Dart lang seems is a big burden for this powerful framework because of its language limitation. As Kotlin, JavaScript, Swift has been a very good role model for us in these years, Dart lang seems to be verbose in syntax and very limit features, for example, ~~null-safety~~ (added in 2.12), immutability (need to add library for code generation), json serializable (need code generation again). It's a big concern for perfectionist. (update at 31 May: After reading [this book](https://book.flutterchina.club), I have compromised the disadvantages Dart brings, because it provides suppppper fast hot reload time in development due to the JIT support, it totally gave me 'WOW' compare to any languages in the market.)

BTW. Flutter is still under actively development, and syntax changes from time to time, my project may not be able to compile successfully under your environment, please make sure your Dart version stick to pubspec.yaml strictly. 
