# Medify
Medify is a medication tracking application. It's built to help people take their medications on time and stay organized. Do you have a caregiver or somebody who helps look over you? Have them install the app as well and connect with them within the app which allows them to view your medications and ensure you're not forgetting to take your meds.

## Getting Started

### Registration
The first thing you need to do when you launch the app is register for a new account. Click the sign up button on the login screen and enter in all the required information. You can optionally enter your pharmacy's phone number allowing you to easily call them inside the app. Choose to sign up as a client or a caregiver (you can change this in settings afterwards if needed).

<img src="https://user-images.githubusercontent.com/55886048/114293370-90fef580-9a63-11eb-9a75-3abc9a58b0c8.png" alt="Image of Login Screen" width="250" height="500">&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/55886048/114293291-eab2f000-9a62-11eb-9e10-10f349ff1ff8.png" alt="Image of Registration Screen" width="250" height="500">

### Settings
On the profile tab click the settings gear icon to go to the settings screen. You can change the app's font size, toggle caregiver mode, and/or change your account's password. Settings are saved automatically when changed.

<img src="https://user-images.githubusercontent.com/55886048/114293137-aecb5b00-9a61-11eb-9834-3f4b18f875bd.png" alt="Image of Settings Screen" width="250" height="500">

### Add a New Medication
After you've registered for an account, you can begin to add your medications. Go to the search tab and search for your desired medication. Once you've found your medication, you can click on it to view more information about it like it's purpose, warnings, usages, and ingredients. To add the medication, click the plus icon next to it's name then fill out the form with all the required information. You can optionally enter the number of pills you have in your bottle to be notified when you're out of pills (assuming you're marking the medication as taken on the app's calendar every time you take a pill).

<img src="https://user-images.githubusercontent.com/55886048/114293902-256b5700-9a68-11eb-8135-468a0960c7ae.gif" alt="Gif of Adding a Medication" width="250" height="500">

### View Your Calendar
One the home tab, you are presented with a calendar that will display all of the medication events you have. A medication event is simply just a medication that repeats at the given interval (daily, weekly, etc.). View all the medications that you need to take for a specific day and mark a medication as taken after you've taken it. You can untake the medication by tapping on the undo button and accepting the confirmation popup.

<img src="https://user-images.githubusercontent.com/55886048/114292916-f7821480-9a5f-11eb-8429-2ff16614b352.png" alt="Image of Calendar Screen" width="250" height="500">

### View Medications
This allows you to see all your unique medications that you have. Click on a medication to view more information about it like you did when adding it except you can see more details like the pills remaining (if entered when adding the medication), repeat interval, start date and time. You can also click the Contact Pharmacy button which will navigate you to your device's phone dialer (if it has one) and if filled in during registration, with the pharmacy number you entered. To remove a medication and all its events on the calendar you can click the Remove Medication button.

<img src="https://user-images.githubusercontent.com/55886048/114293265-ac1d3580-9a62-11eb-88e3-87c337926e6b.png" alt="Image of View Medications Screen" width="250" height="500">

### Add Caregiver
If you have a caregiver or somebody who is watching over you and you want to give them access to view your medications then you can request to connect with them. On the profile tab, you can click the Add Caregiver button and enter in your caregiver's email to send a request to connect. You can view all your caregivers on the profile tab and if needed remove a caregiver by clicking the X button next to their names which will break the connection.

<img src="https://user-images.githubusercontent.com/55886048/114293226-67919a00-9a62-11eb-8627-678ac386d1d6.png" alt="Image of Add Caregiver Dialog" width="250" height="500">

### Connect With Clients
Give out your email to your clients and have them request to connect with you. Once you receive the request, accept or decline it. If you accept it, you can click on your client's name and view the medications that they have and whether or not they've taken it. To remove a client click the trash icon on the right of the toolbar.

<img src="https://user-images.githubusercontent.com/55886048/114293538-f69fb180-9a64-11eb-984d-6642de33e4b3.png" alt="Image of Clients Screen" width="250" height="500">

## Prerequisites
Designed for Android devices with a target SDK version of API level 29 and iOS devices with a target of iOS 12.0 or later. Built with Dart SDK version 2.12.1 and Flutter 2.0.2. This project does not currently support null safety as Dart did not have a stable release for it until near the end of development.

## Database Schema

<img src="https://user-images.githubusercontent.com/55886048/114292846-86daf800-9a5f-11eb-9874-2a8785ec36f8.JPG" alt="Image of Database Schema" width="600" height="400">

## Authors
* Abel Anderson
* Hasan Muslemani

## License
Currently unknown. Waiting for client's response.

## Acknowledgments
This app was created for Jodi Lecuyer as part of the final capstone project for the Mobile Application Development program at St. Clair College in Windsor, Ontario, Canada. Special thanks to our professors Darren Takaki, Cai Filiault, and Nicholas Sylvestre for their guidance, support, and feedback on this project.
