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




