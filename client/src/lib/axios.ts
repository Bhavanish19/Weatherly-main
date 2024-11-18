// lib/axios.ts
import axios from 'axios';

// Use a function to get the API base URL to handle both build and runtime
const getApiBaseUrl = () => {
  const apiBaseUrl = process.env.NEXT_PUBLIC_API_BASE_URL;
  if (!apiBaseUrl) {
    // Provide a default fallback or handle the error as needed
    console.warn('API_BASE_URL not found in environment, using default');
    return 'http://k8s-weatherapp-9192b5bb96-515230204.us-east-1.elb.amazonaws.com/api/v1/weather';
  }
  return apiBaseUrl;
};

const axiosInstance = axios.create({
  baseURL: getApiBaseUrl(),
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: false,
});

// Request interceptor
axiosInstance.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    // Add error handling for missing baseURL
    if (!config.baseURL) {
      console.warn('No baseURL provided. Falling back to default.');
      config.baseURL = getApiBaseUrl();
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  },
);

// Response interceptor with improved error handling
axiosInstance.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.code === 'ECONNABORTED') {
      return Promise.reject(new Error('Request timed out. Please try again.'));
    }
    if (error.response) {
      // Server responded with error status
      const message = error.response.data?.message || 'An error occurred';
      return Promise.reject(new Error(message));
    } else if (error.request) {
      // Request made but no response received
      return Promise.reject(new Error('No response from server. Please check your connection.'));
    } else {
      // Request setup error
      return Promise.reject(new Error('Error setting up the request.'));
    }
  },
);

export default axiosInstance;