supabase.com  relational
appwrite.io
aws
apn apple push notification .. for ios
create ml

Firebase Cloud Fire store - no sql data base
fcm-clode messaging -- bkash daraz jey regular morning e notification padhay oigula


## Native firebase setup

firebase>>Go to console>>Create a new Firebase project>>Done>>Setting >>General>>Android


Android studio >> android >>app>>build.gradle.>>
android {
namespace = "com.tfs.firebase_flutter"  <-package name  >>

we copy this package name .. and paste it into Register app>>Android package name>>Resister >>
Download >> google-services.json >>android >>app>>paste >>

android >> app er vitor jei gradle ta acey oita app level gradle(build.gradle.kts)
android >> gradle er vitor jei gradle ta acey oita project level gradle(build.gradle.kts)

3 Add Firebase SDK >> 
Next >> Continue to the console

app level gradle  dependencies {  er vitor multidex add korbo .

## flutter e firebase add
search >> firebase core package >> copy and paste on pubspec.yaml in 36 line under this word (  cupertino_icons: ^1.0.8)
firebase_core: ^4.7.0

add also :
intl: ^0.20.2
get: ^4.7.3 


search : add firebase to your flutter app >>initialize Firebase >>add this text in main.dart inside the main function

update your app minSdk = 21 (app level gradle)

if kts/globby version need upgrade then upgrade it 


## ios setup (mac device must needed)

firebase>>Go to console>>Create a new Firebase project>>Done>>Setting >>General>>ios

Android Studio >>Project >> ios >> Mouse right click >> Go in last option >>Flutter(Open ios/macOS module in Xcode)


Xcode>>Runner >>identify>>Bundle identifier || Apple Bundle id for firebase

Download config file >> GoogleService info plist >> copy and drag it in Xcode >>Runner >>Runner >>paste

## flutter fire 
firebase CLI reference
fvm -- flutter version manager

windows : chocolatey command line tool
Mac : homebrew mac command line tool

install the Firebase CLI. ::click
Set up or update the CLI :click  https://firebase.google.com/docs/cli#setup_update_cli
Windows ::select

install node.js from this page link...https://nodejs.org/en
standalone binary >>Firebase CLI binary for Windows ::install :more info : run anyway ::

node.js ta o download koira raktey paro .. 

old use kora hoito--Realtime Database application theke read kortey cailey :  pub.dev theke firebase_database
https://firebase.google.com/docs/database/flutter/start

latest use kora hoy ata best --Firestore Database/Cloud Database/Document base no SQL  --- 


## FCM firebase cloud messaging

2 way tey send kora jay .. 1. cloud console .. 2. personal Server (HTTP/Admin SDK)
 ei 2 method diya request kora jay fcm er jonno ei msg gula FCM backend e jaibey .er por device SDK maintain koira send hoibo ..

Android er jonno direct fcm 
Apple er jonno APNs - Apple push notification service certificate antey hoibo .
Web push

## fcm setup 

Firebase console >> Product categories >>DevOps and engagement>>Engagement>>Messaging >>>>ei khan theke push notification create korar option peye jaibo 

https://pub.dev/ : firebase_messaging

firebase_messaging: ^16.2.0  pubspec.yaml e pub get korlam ..

take a permission for message receiving 
