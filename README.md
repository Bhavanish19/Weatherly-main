# Weatherly - Your Ultimate Weather Companion

Weatherly is a comprehensive weather application that provides real-time updates, forecasts, and detailed weather metrics. Built with modern web technologies, Weatherly aims to provide a seamless and engaging user experience, no matter where you are or what device you're using.

## 🚀 Key Features

- 🌍 **Real-time weather updates and forecasts**
- 🌡️ **Detailed weather metrics** including temperature, humidity, and wind speed
- 🌆 **Air quality monitoring** and **UV index tracking**
- 🎨 **Light/Dark theme support** for user preference
- 🌐 **Multi-language support** for a diverse audience
- 📱 **Responsive design** for various devices
- ♿ **Accessibility-focused interface** ensuring everyone can use the app
- 🗺️ **Interactive weather maps** to visualize weather data intuitively

## 🛠️ Built With

- **Next.js**: React framework for production
- **React**: JavaScript library for building user interfaces
- **TypeScript**: Typed superset of JavaScript
- **Tailwind CSS**: Utility-first CSS framework for rapid styling
- **Radix UI**: Unstyled, accessible components for React
- **Lucide React**: Beautiful and consistent icon pack
- **Recharts**: Composable charting library for visualizing weather metrics
- **React Leaflet**: Maps integration to provide interactive weather maps
- **next-themes**: Theme management for light and dark modes
- **React Error Boundary**: Error handling to enhance app reliability

## 📈 Development Process

The development of Weatherly focused on providing a robust yet intuitive user experience. Throughout the project, special attention was paid to the following:

- 🌍 **Core Weather Tracking Features**: Integrated essential weather tracking capabilities, such as real-time updates, forecast accuracy, and detailed weather metrics.
- 🔍 **OpenWeather API Integration**: Integrated the OpenWeather API to ensure accurate and up-to-date weather information.
- 🎨 **Responsive UI**: Designed and implemented a user interface that adapts smoothly to different screen sizes and themes, enhancing the user experience.
- ♿ **Accessibility**: Implemented accessibility features to make Weatherly usable by everyone, regardless of their abilities.
- ⚡ **Performance Optimization**: Optimized the app's performance to provide a seamless experience on both desktop and mobile devices.

## 🌤️ Weather API Server

The backend of Weatherly is powered by a high-performance, TypeScript-based Express server that integrates with the OpenWeather API. It offers comprehensive weather data with reliability and efficiency.

### 🚀 Key Features

- **Comprehensive Weather Data**
  - 🌍 Real-time weather conditions and detailed forecasts
  - 🌆 Air pollution metrics for informed decision-making
  - 🏙️ City search functionality for finding weather in different locations

- **Robust Security**
  - 🛡️ Rate limiting to protect against excessive requests
  - 🔐 CORS configuration for controlled resource sharing
  - 🛑 Helmet for security headers
  - ✅ Environment variable validation to ensure proper configuration

- **Performance Optimized**
  - 🚄 In-memory caching for fast response times
  - 📦 Response compression for optimized network usage
  - ⚠️ Efficient error handling to ensure stability
  - 📋 Request logging to keep track of server activity

- **Type Safety**
  - 📘 Full TypeScript implementation for reliable development
  - ✅ Zod validation schemas for input validation
  - 💻 Type-safe request handling to reduce runtime errors

### 🛠️ Built With

- **Express.js**: Fast, unopinionated web framework for building backend services
- **TypeScript**: Type-safe JavaScript to enhance code quality
- **Helmet**: Middleware for enhancing security
- **CORS**: Cross-origin resource sharing configuration
- **Compression**: Response compression to improve performance
- **Zod**: Runtime type validation for type safety
- **Express Rate Limit**: Middleware for limiting repeated requests
- **Winston**: Logging library for monitoring server events
- **Axios**: HTTP client for making API requests

## 📜 How to Run the Project

1. **Clone the Repository**: Clone this repository to your local machine using `git clone <repository-url>`.

2. **Install Dependencies**: Navigate to the project directory and run `npm install` to install all required dependencies.

3. **Configure Environment Variables**: Create a `.env` file in the root directory with the following keys:
   - `API_KEY`: Your OpenWeather API key.
   - Other necessary keys for security and configuration.

4. **Run the Development Server**: Run `npm run dev` to start the Next.js development server.

5. **Start the API Server**: In a separate terminal, navigate to the `server` folder and run `npm start` to start the Express.js server.

6. **Access the Application**: Once the development server is running, you can access Weatherly in your browser at `http://localhost:3000`.

## 📄 License

This project is licensed under the MIT License. Feel free to use, modify, and distribute as per the terms of the license.

## 💬 Contributions

Contributions are always welcome! Feel free to open issues, fork the repository, and submit pull requests. Let's make Weatherly even better together!

## 🙌 Acknowledgements

- **OpenWeather API** for providing comprehensive weather data.
- **React Leaflet** for interactive map functionalities.
- **Radix UI** for accessible components.

## 📞 Contact

For any inquiries, issues, or suggestions, please contact:
- **Email**: [your-email@example.com]
- **GitHub**: [Your GitHub Profile]

Thank you for using Weatherly! 🌤️

We hope you enjoy your experience and always stay informed about the weather around you.

