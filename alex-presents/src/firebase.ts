// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore";
import { getAuth, GoogleAuthProvider } from "firebase/auth";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyC4LkXuL3F68JRw4Xf0fgfCznxe7MMH_Xc",
    authDomain: "alexpresents-91fa4.firebaseapp.com",
    projectId: "alexpresents-91fa4",
    storageBucket: "alexpresents-91fa4.firebasestorage.app",
    messagingSenderId: "587656771100",
    appId: "1:587656771100:web:4da39606bc0f10f678d1d9",
    measurementId: "G-DNKXE887ZP"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
export const db = getFirestore(app);
export const auth = getAuth(app);
export const provider = new GoogleAuthProvider();