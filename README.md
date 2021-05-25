# Vaccine in Flutter. This project is for demo only.

# introduction
I did want to publish this project into play store, however this is sensitive time to Google to prevent misleading information spread about COVID-19, so I paused my plan and public it. 

This is for my personal demo, in which I have tried different Fluter technique, for example, BLoC in Cubit for state management, Google Ads and Map services, as well as Firebase push notification. 

# BLoC
In project, I picked Cubit instead of BLoC for state management. It is a simple yet essential core in BLoC framework. It provides easy to use interface for developers to start BLoC pattern fast. It has many features that BLoC framework emphasis, for example, easy to predict state changes, reactive pattern for components subscription and Flutter DevTool previewable.

However, it does not have transforming features which BLoC class provides, nor the detailed logging for event received, under this limitation, we can log the state changes only. 

Depends on how complexity you want for your project, normally I choose easy yet powerful library for my projects, but I did doing a relatively comprehensive project that uses BLoC for better maintanence thereafter. 

# Difficulties
For Google's official Ads library, it is very hard to use and buggy, I can't integrate it into project easily, tho I think spend more time can still figure out the solution, I evenually picked unofficial one and seems works pretty good. 

For BLoC pattern, cubit is easy and did quite well, however I would pick RiverPods since next project, because imho Provider + Hooks inside RiverPods is killer pattern for flexibility and simplicity.

Null-safety is good for Dart 2.12 or later, but current not all libraries support and some library are essentials, for example, Firebase from Google. To make the project easy to integrate different libraries, I have explicity turn off the null-safety by unsound it (https://dart.dev/null-safety/unsound-null-safety). 

# Summary
Flutter is still under actively development, and syntax changes from time to time, my project may not be able to compile successfully under your environment, please make sure your Dart version stick to pub.yaml strictly. 
