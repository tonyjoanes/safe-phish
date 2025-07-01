import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import FirebaseTest from './components/FirebaseTest'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-6">
            <div className="flex items-center">
              <h1 className="text-3xl font-bold text-gray-900">
                🛡️ PhishGuardAI
              </h1>
              <span className="ml-3 px-2 py-1 bg-blue-100 text-blue-800 text-sm font-medium rounded-full">
                v1.0.0
              </span>
            </div>
            <div className="flex items-center space-x-4">
              <span className="text-sm text-gray-500">Development Mode</span>
              <div className="flex space-x-2">
                <a href="https://vite.dev" target="_blank">
                  <img src={viteLogo} className="h-6 w-6" alt="Vite logo" />
                </a>
                <a href="https://react.dev" target="_blank">
                  <img src={reactLogo} className="h-6 w-6" alt="React logo" />
                </a>
              </div>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Welcome Section */}
        <div className="text-center mb-8">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">
            Welcome to PhishGuardAI Dashboard
          </h2>
          <p className="text-gray-600 max-w-2xl mx-auto">
            Your AI-powered phishing detection and prevention platform. 
            Test the authentication system below to get started.
          </p>
        </div>

        {/* Test Components */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {/* React Counter Test */}
          <div className="bg-white rounded-lg shadow-md p-6">
            <h3 className="text-xl font-semibold text-gray-800 mb-4">
              ⚛️ React Test
            </h3>
            <div className="text-center">
              <div className="mb-4">
                <button 
                  onClick={() => setCount((count) => count + 1)}
                  className="bg-blue-500 text-white px-6 py-2 rounded-md hover:bg-blue-600 transition duration-200"
                >
                  count is {count}
                </button>
              </div>
              <p className="text-sm text-gray-600">
                Click the button to test React state management
              </p>
            </div>
          </div>

          {/* API Health Check */}
          <div className="bg-white rounded-lg shadow-md p-6">
            <h3 className="text-xl font-semibold text-gray-800 mb-4">
              🔗 API Health Check
            </h3>
            <div className="text-center">
              <a 
                href="http://localhost:5000/health" 
                target="_blank" 
                rel="noopener noreferrer"
                className="inline-block bg-green-500 text-white px-6 py-2 rounded-md hover:bg-green-600 transition duration-200"
              >
                Test API Health
              </a>
              <p className="text-sm text-gray-600 mt-2">
                Click to test the backend API connection
              </p>
            </div>
          </div>
        </div>

        {/* Firebase Authentication Test */}
        <div className="mt-8">
          <FirebaseTest />
        </div>
      </main>

      {/* Footer */}
      <footer className="bg-white border-t border-gray-200 mt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex justify-between items-center">
            <p className="text-sm text-gray-500">
              © 2024 PhishGuardAI. Built with React + .NET + Firebase
            </p>
            <div className="flex items-center space-x-4 text-sm text-gray-500">
              <span>Frontend: {import.meta.env.VITE_API_URL ? '🟢' : '🔴'}</span>
              <span>Firebase: {import.meta.env.VITE_FIREBASE_API_KEY ? '🟢' : '🔴'}</span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default App
