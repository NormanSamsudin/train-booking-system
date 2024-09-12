## Simple Train Booking System
Mobile application that powered by flutter framework for the backend and Node.js for the backend. The key feature of the app is the ability to lock a seat on a first come first serve basis. 

## Video Demonstration

[![Video](https://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](https://www.youtube.com/watch?v=aEAOh3--aHg)

## Installation

You can ignore this part

Clone repository via HTTPs

```bash
git clone https://github.com/NormanSamsudin/train-booking-system.git
```

You need to install dependencies for the project. Dependencies is install by using a dependencies manager. 

```bash
flutter pub get
```

### Install Package manager

Node & npm

For installing Node.js and npm, utilize a Node version manager like nvm for managing multiple Node.js versions or use a Node installer if a version manager isn't feasible. To download the LTS version from the Node.js download page for macOS or Windows, and for Linux, consider using the NodeSource installer. For more instructions, refer to this Node and npm [installation guide](https://kinsta.com/blog/how-to-install-node-js/).

### Install MongoDB Database

MongoDB Community Edition on Windows

[installation guide](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-windows/).

## Backend Deployment

To deploy this project on your local machine

```bash
  npm run start
```

## Flutter

### Local IP Address

Change value of ip address on page global_variable.dart. Check your ip address on bash command.

```bash
  ipconfig //windows
  ifconfig //linux
```

### Run Flutter

To deploy this flutter projectrun on your local machine

```bash
  flutter run
```

## API Testing

#### Endpoint List

- POST: Booking a seat

```bash
  localhost:3000/api/seat/book-seat
```

- POST: Locking a seat

```bash
  localhost:3000/api/seat/lock-seat
```

- GET: Retrieving list of seat for spesific train and coach

```bash
  localhost:3000/api/seat/:plateNumber/:coach
```

- GET: Retrieving list of scheduled train

```bash
  localhost:3000/api/train
```

- POST: User signed in

```bash
  localhost:3000/api/vendor/signin
```

- POST: User signed in

```bash
  localhost:3000/api/vendor/signup
```

- GET: Retrieve seats booked

```bash
  localhost:3000/api/seats-with-train/:owner
```



