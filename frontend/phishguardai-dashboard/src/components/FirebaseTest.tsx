import { useState, useEffect } from 'react';
import { 
  signInWithEmailAndPassword, 
  createUserWithEmailAndPassword, 
  signOut, 
  onAuthStateChanged
} from 'firebase/auth';
import type { User, AuthError } from 'firebase/auth';
import { auth } from '../firebase';

const FirebaseTest = () => {
  const [user, setUser] = useState<User | null>(null);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
    });

    return () => unsubscribe();
  }, []);

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');
    
    console.log('Attempting to sign up with:', email);
    
    try {
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      console.log('Sign up successful:', userCredential.user);
      setEmail('');
      setPassword('');
    } catch (err) {
      console.error('Sign up error:', err);
      const authError = err as AuthError;
      setError(`${authError.code}: ${authError.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignIn = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError('');
    
    console.log('Attempting to sign in with:', email);
    
    try {
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      console.log('Sign in successful:', userCredential.user);
      setEmail('');
      setPassword('');
    } catch (err) {
      console.error('Sign in error:', err);
      const authError = err as AuthError;
      setError(`${authError.code}: ${authError.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignOut = async () => {
    try {
      await signOut(auth);
    } catch (err) {
      const authError = err as AuthError;
      setError(authError.message);
    }
  };

  return (
    <div className="max-w-md mx-auto mt-8 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6 text-center text-gray-800">
        🔥 Firebase Test
      </h2>
      
      {user ? (
        <div className="text-center">
          <div className="mb-4 p-4 bg-green-100 rounded-lg">
            <h3 className="text-lg font-semibold text-green-800">✅ Authenticated!</h3>
            <p className="text-green-600">{user.email}</p>
            <p className="text-sm text-gray-500">UID: {user.uid}</p>
          </div>
          <button
            onClick={handleSignOut}
            className="w-full bg-red-500 text-white py-2 px-4 rounded-md hover:bg-red-600 transition duration-200"
          >
            Sign Out
          </button>
        </div>
      ) : (
        <form className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Email
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="test@example.com"
              required
            />
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Password
            </label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Password (min 6 chars)"
              required
            />
          </div>

          {error && (
            <div className="p-3 bg-red-100 border border-red-300 rounded-md">
              <p className="text-red-700 text-sm">{error}</p>
            </div>
          )}

          <div className="flex space-x-2">
            <button
              type="submit"
              onClick={handleSignIn}
              disabled={isLoading}
              className="flex-1 bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 disabled:opacity-50 transition duration-200"
            >
              {isLoading ? 'Loading...' : 'Sign In'}
            </button>
            <button
              type="button"
              onClick={handleSignUp}
              disabled={isLoading}
              className="flex-1 bg-green-500 text-white py-2 px-4 rounded-md hover:bg-green-600 disabled:opacity-50 transition duration-200"
            >
              {isLoading ? 'Loading...' : 'Sign Up'}
            </button>
          </div>
        </form>
      )}
      
      <div className="mt-4 p-3 bg-gray-100 rounded-md">
        <h4 className="text-sm font-semibold text-gray-700 mb-2">Firebase Configuration:</h4>
        <div className="text-xs text-gray-600 space-y-1">
          <p>API Key: {import.meta.env.VITE_FIREBASE_API_KEY ? '✅ Set' : '❌ Missing'}</p>
          <p>Auth Domain: {import.meta.env.VITE_FIREBASE_AUTH_DOMAIN ? '✅ Set' : '❌ Missing'}</p>
          <p>Project ID: {import.meta.env.VITE_FIREBASE_PROJECT_ID ? '✅ Set' : '❌ Missing'}</p>
          <p>App ID: {import.meta.env.VITE_FIREBASE_APP_ID ? '✅ Set' : '❌ Missing'}</p>
        </div>
        <div className="mt-2 text-xs text-gray-500">
          <p>Check browser console (F12) for detailed error logs</p>
        </div>
      </div>
    </div>
  );
};

export default FirebaseTest; 