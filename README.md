## Scorely - Live Cricket Score App

 Scorely is a Flutter-powered mobile and web app built for cricket lovers, delivering live scores, Cricket News, match info, and upcoming series schedule.

## Features

- Live match scores and status
- Stay updated with the latest cricket news in an in-app feed.
- List of upcoming series (ODIs, T20Is, Tests, Domestic Matches)
- Match details with team names, logos, scores, and status
- Pull-to-refresh and auto refresh every 10 Seconds
- Simple and clean UI


## Screenshots

- Splash Screen </br>
  <img src="screenshots/splashscreen.png"  alt="Splash Screen" width="310" height="660"/>

- Featured Tab (Mobile View) </br>
  <img src="screenshots/Featured_tab.png" alt="Featured Tab" width="310" height="660"/>

- Upcoming Feed (Mobile View) </br>
  <img src="screenshots/upcoming_tab.png" alt="Upcoming Feed" width="310" height="660"/>

- News Feed (Mobile View) </br>
  <img src="screenshots/NewsFeed_Mobile.png" alt="News Feed" width="310" height="660"/>

- More Sections(Mobile View) </br>
  <img src="screenshots/More_Sections_Mobile.png" alt="More Sections" width="310" height="660"/>

- News Feed (Windows UI)   </br>
  <img src="screenshots/Windows_NewsFeed.png" alt="News Feed Windows" style="max-width:100%; height:auto;" />

- Flutter Windows UI – Featured Tab     </br>
  <img src="screenshots/Windows_featured.png" alt="Flutter Windows UI (Featured Tab)" style="max-width:100%; height:auto;" />

- Flutter Windows UI – Upcoming Feed    </br>
  <img src="screenshots/Windows_upcoming.png" alt="Flutter Windows UI (Upcoming Feed)" style="max-width:100%; height:auto;" />

## Backend Infrastructure

### Match Data API

API Used: CricAPI

Type: RESTful API

### News Feed

Source: ESPN Cricinfo Home RSS Feed

Type: RSS (XML)
 

## Frontend Architecture

Framework: Flutter (Cross-platform SDK)

Language: Dart

Networking: `http` package for REST and XML fetching

XML Parsing: `xml` package used for handling RSS News Feed

Navigation: navigator: v1.1.1
