# Firebase Photo Upload App

This Flutter application demonstrates how to build a photo upload app using Firebase, Riverpod for state management, and Camera Awesome for camera functionality.

## Introduction

This project showcases a simple photo upload app connected to Firebase. Please note that, for demonstration purposes, this app does not require user authentication.

## Features

- **Firebase Integration:** The app communicates with Firebase for storage and Firestore for database functionality. Photos are uploaded to Firebase Storage, and corresponding documents are created in Firestore.

- **State Management:** Riverpod is used for state management within the app, allowing efficient data flow and management between different screens and widgets.

- **Camera Integration:** The Camera Awesome package is utilized for capturing photos. After taking a photo, it is displayed in the bottom-right corner and can be opened for uploading to the server.

## Getting Started

To get started with this Flutter project, follow these steps:

Clone the repository to your local machine.

### Usage

1. Launch the app and click on the "Upload new photo" button to open the camera screen.

2. Use the camera interface to take a photo.

3. After taking a photo, it appears in the bottom-right corner of the screen. Click on the photo to initiate the upload process.

4. The app will simulate the upload process, including adding the photo to Firebase Storage and creating a corresponding document in Firestore.

5. Explore the list of uploaded photos on the home screen.
