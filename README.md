# Grocery-Shopping-App

## Objective
The goal of this project was to develop a grocery shopping application using Flutter, adhering to clean architecture principles and implementing BLoC for state management. The app replicates the design provided in the attached Figma file and integrates with a given API to fetch and display grocery data.

## Architecture
The app is built using the clean architecture principles, which separates the codebase into distinct layers:

#### Presentation Layer: 
Manages the UI and user interactions. This includes the implementation of pages and widgets that interact with the BLoC for state management.
#### Domain Layer: 
Contains the core business logic and entities. This layer handles use cases and interacts with the data layer.
#### Data Layer: 
Responsible for data fetching, parsing, and handling API interactions. It includes repositories and data sources.

## State Management
The app uses BLoC (Business Logic Component) for state management. This ensures that state changes are handled predictably and that the UI updates in response to user interactions and data changes.

## Features
Display Products: Fetch and display grocery products using the provided API.
Routing: Provides smooth navigation between different pages within the app.
UI Implementation
The app follows the design specifications provided in the Figma file, including layout, color scheme, typography, and user experience elements.

## API Integration
The app integrates with the provided API for fetching grocery data. It includes proper error handling, loading states, and response parsing.

## Packages Used
Dependency Injection: get_it for managing app dependencies.
Network Requests: http package for handling API requests and network interactions.


![Screenshot_20240827_184412](https://github.com/user-attachments/assets/2e9507ce-feaf-42d7-8e07-26ea036b0f83)
![Screenshot_20240827_184341](https://github.com/user-attachments/assets/185cc408-12a9-442d-9e36-74441e1b23c4)
![Screenshot_20240827_184833](https://github.com/user-attachments/assets/1f1f644a-9652-4dd6-81c3-11ab0dac208c)
![Screenshot_20240827_184359](https://github.com/user-attachments/assets/e0db0857-15a0-4cbc-8542-e0822191574b)








