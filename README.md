# MakersBnB specification

This is a web application that allows users to list spaces they have available, and to hire spaces for the night.

### Set up 

- Clone this repository to your local machine
- Run `bundle install` in the command line to install the relevant gems
- Connect to `psql` and create the `makerbnb` and `makersbnb_test` databases:

```
CREATE DATABASE makersbnb;
CREATE DATABASE makersbnb_test;
```

- To set up the appropriate tables, connect to each database in `psql` and run the SQL scripts in the `db/migrations` folder in the given order.

- Run `rackup` in the terminal
- Visit `http://localhost:9292/` in your browser

### Headline specifications

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.

### Mockups

Mockups for MakersBnB are available [here](https://github.com/makersacademy/course/blob/main/makersbnb/makers_bnb_images/MakersBnB_mockups.pdf).

## MVP

The minimum viable product of our BnB web-app is the ability to list a property with a name, description and price.

- A user is able to list a place.
- A user can name a listed place.
- A user can provide a description of a listed place.
- A user can provide a price per night of a listed place.

## Technologies used

- Ruby
- Rspec (test framework)
- Sinatra (Ruby web framework)
- Capybara (web feature test library)
- PostgreSQL (database manager)


## User Stories


User story 1

```
  As a user
  so that I can advertise my space to rent
  I want to be able to list a space
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
Space | list(create)


#### Feature breakdown

1. Can enter space details

2. CREATE space listing

------

User story 2

```
  As a user with multiple spaces
  so that I can list more than one space
  I want to be able to list multiple spaces
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
Space | list(create)

------

User story 3

```
  As a user
  so that I can distinguish between other spaces
  I want to be able to add a name to my space
```

Object | Messages
--------------- | ---------------
Person |
Space | addName

------

User story 4

```
  As a user
  so that I can distinguish between other spaces
  I want to be able to add a description to my space
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
Space | addDescription

------

User story 5

```
  As a user
  so that I can distinguish between other spaces
  I want to be able to add a price per night to my space
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
Space | addPrice

------

User story 6

```
  As a user
  so that I can only offer my space when it is available
  I want to be able to add a range of dates 
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
Space | addDates

------

User story 7

```
  As a user 
  so that I can hire a space
  I want to be able to request to stay for one night
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | RequestStay

------

User story 8

```
  As a host 
  so that I can manage my space
  I want to be able to approve a booking
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | ApproveBooking

------

User story 9

```
  As a user
  so that I can only see spaces that I can book
  I want to be shown available spaces
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | ShowAvailability

------

User story 10

```
  As a host
  so that I don't double book my space
  I want to only show available dates
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | UpdateAvailability

------

User story 11

```
  As a host
  so that I can receive multiple booking requests
  my space should show as available until I approve a booking
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | ShowAvailability
User | UpdateAvailability

------

User story 12

```
  As a user
  so that I can save my details
  I want to be able to sign up
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | SignUp

------

User story 13

```
  As a user
  so that I can access my account
  I want to be able to log in
```

#### Object Model


      Object | Messages
--------------- | ---------------
Person |
User | LogIn

------

User story 14

```
  As a user
  so that only I have access to my account
  I want to be able to log out
```

#### Object Model

Object | Messages
--------------- | ---------------
Person |
User | LogOut

------

A link to the user stories picture is [here](https://github.com/nelsonclaire/chitter-challenge/blob/master/public/user_stories.png)

