import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For storing user details
import '../models/auth_model.dart';

abstract class RemoteDataSource {
  Future<AuthModel> signUp(String email, String password, String username);
  Future<AuthModel> signIn(String email, String password);
  Future<void> signOut();
  Future<AuthModel> getUserProfile();
  Future<void> verifyEmail();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  RemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  
Future<AuthModel> signUp(String email, String password, String username) async {
  try {
    // Create a user in Firebase Auth
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Save additional user data in Firestore with a default role
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'username': username,
      'email': email,
      'emailVerified': false,
      'role': 'user', // Default role assigned here
    });

    // Return AuthModel
    return AuthModel(
      uid: userCredential.user!.uid,
      email: email,
      emailVerified: userCredential.user!.emailVerified,
      username: username,
    );
  } catch (e) {
    throw Exception('Sign Up Failed: $e');
  }
}



  @override
  Future<AuthModel> signIn(String email, String password) async {
    try {
      // Sign in the user
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch additional user details from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      return AuthModel(
        uid: userCredential.user!.uid,
        email: email,
        emailVerified: userCredential.user!.emailVerified,
        username: userDoc['username'],
      );
    } catch (e) {
      throw Exception('Sign In Failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthModel> getUserProfile() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No user logged in');
      }

      // Fetch user details from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      return AuthModel(
        uid: user.uid,
        email: user.email!,
        emailVerified: user.emailVerified,
        username: userDoc['username'],
      );
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

 
 @override
 
Future<void> verifyEmail() async {
  User? user = _firebaseAuth.currentUser;

  if (user == null) {
    throw Exception('No user logged in');
  }

  // Reload the user's data to get the latest status
  await user.reload();
  user = _firebaseAuth.currentUser; // Update the reference after reload

  // Check if the email is already verified
  if (!user!.emailVerified) {
    throw Exception('Email not verified yet. Please check your inbox.');
  }
}


}
