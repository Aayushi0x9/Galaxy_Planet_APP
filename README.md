# Galaxy Planets App

Explore the beauty of our galaxy with the **Galaxy Planets App**! This app provides an interactive experience to learn about planets, add favorites, and enjoy a visually stunning user interface. 

## Features

- **Explore Planets**: Swipe through the planets to view their details including position, distance from the sun, and velocity.
- **Favorites Management**: Mark your favorite planets and store them persistently using `shared_preferences`.
- **Smooth Navigation**: Navigate through the app effortlessly with the help of `GetX` for state management and navigation.
- **Liquid Swipe Animation**: Enjoy engaging transitions between screens using `liquid_swipe`.
- **Beautiful Dark UI**: Designed with a dark theme for a sleek and modern appearance.

  
## Packages Used

- **GetX**: For state management and navigation (`get: ^4.6.6`)
- **Shared Preferences**: To persist favorite planets even after app closure (`shared_preferences: ^2.3.3`)
- **Liquid Swipe**: For smooth page transitions (`liquid_swipe: ^3.1.0`)

  ## How It Works

1. **Planets List**: Browse through a list of planets fetched from a JSON file.
2. **Favorites**: Mark a planet as a favorite by tapping the heart icon. Favorites are stored locally using `shared_preferences`.
3. **Details Page**: Navigate to a planet's details page with interactive animations and a rotating planet image.
4. **Liquid Swipe**: Use swiping gestures to move through the planet details page for an immersive experience.

## Screenshots

<img src="https://github.com/user-attachments/assets/e1f822ca-0b6a-4aee-a33c-a27a90746de1" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/d9389c03-9e70-4dc6-9ce2-d5b675186043" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/d4514ae2-e26d-4be6-bb60-0ab98034e552" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/873dd660-f817-4a52-b1a7-e9c436b2420d" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/83f9d435-94c3-4e4f-947a-837a32f228ad" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/6c10a0d8-025a-48d5-8550-7a65e130e353" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/b7d01f58-39db-4608-ab0f-b6c0386ee189" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/b877f7f8-f2d5-46d9-b694-93ea3abb914f" width="250" height="550" />
<img src="https://github.com/user-attachments/assets/1578a897-a11f-4054-9617-b5a6096a9415" width="250" height="550" />

## Project Structure

```plaintext
lib/
├── controller/
│   └── planet_controller.dart
├── screens/
│   ├── home/
│   │   └── home_screen.dart
│   ├── detail/
│   │   └── detail_screen.dart
│   └── favourite/
│       └── favourite_screen.dart
├── utils/
│   └── routes/
│       └── app_routes.dart
└── main.dart
```
