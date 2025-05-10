# PushPals

PushPals ist eine mobile Anwendung, die es Nutzern ermöglicht, Challenges zu erstellen, zu teilen und zu verfolgen. Die App wurde fürAndroid entwickelt und basiert auf dem Flutter-Framework. Unsere Softwarearchitektur verwendet das MVC-Muster, um eine klare Trennung zwischen Logik, Daten und Benutzeroberfläche zu gewährleisten.

## Autoren
- **Manuel Walser**
- **Pascal Krajewski**

## Technologie-Stack

### Frontend
- **Framework:** Flutter
- **Plattformen:** Android

### Backend
- **Sprache:** JavaScript
- **Framework:** Node.js
- **Datenbank:** Supabase

## Softwarearchitektur
Die Anwendung basiert auf dem **MVC-Pattern** (Model-View-Controller):
- **Model:** Daten und Logik (z. B. Benutzer, Challenges, Übungen).
- **View:** Benutzeroberfläche in Flutter.
- **Controller:** Schnittstelle zwischen Model und View sowie die Implementierung der Logik.

## Features
- Erstellung von Challenges
- Teilen von Challenges mit Freunden
- Verfolgung des Fortschritts in Echtzeit

## Installation
### Voraussetzungen
- Flutter SDK

### Frontend starten
1. Flutter SDK installieren ([Flutter Documentation](https://flutter.dev/docs/get-started)).
2. Projekt klonen:
   ```bash
   git clone https://github.com/Pazflow/PushPals.git
   cd PushPals
   ```
3. Abhängigkeiten installieren:
   ```bash
   flutter pub get
   ```
4. Anwendung starten:
   ```bash
   flutter run
   ```

## Git-Routineablauf:
### Stelle sicher, dass alle Änderungen im Branch paz/manu committet sind
git add .
git commit -m "Deine Commit-Nachricht"

### Wechsle zum dev Branch und merge die Änderungen von paz/manu
git checkout dev
git merge paz

### Wechsle zum main Branch und merge die Änderungen von paz/manu
git checkout main
git merge paz

### Push die Änderungen zu den Remote-Branches
git push origin dev
git push origin main

## Lizenz
Dieses Projekt ist ein Privates Projekt und besitzt daher nur die Standardlizenz.