import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthServices {
  // instance of firbaseauth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _verificationId = '';

  // error dialog 
  void errorDialog(BuildContext context, String error){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Error Occured!",
          style: TextStyle(
            color: Colors.red,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "error: $error",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // get current user name method
  Future<String> getCurrentUserName() async {
    try {
      final uid = _firebaseAuth.currentUser?.uid;

      if (uid == null) {
        throw Exception("User not logged in");
      }

      final userDoc = await _firestore
          .collection('Users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();
        return data?['name']; // returns the userDBId
      } else {
        throw Exception("User document not found");
      }
    } catch (e) {
      throw Exception("Error retrieving name: $e");
    }
  }

  // get current user method
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // SIGN IN METHODS
  // 1. Sign in with email and passwords
  Future<UserCredential> signInWithEmailAndPassword(String emailAddress, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress, 
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // 2. sign in with google
  signInWithGoogle() async {
    // google sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );


    // save user if it doesn't already exists
    _firestore.collection("Users").doc(gUser.id).set(
      {
        'uid': gUser.id,
        'email': gUser.email,
        'name': gUser.displayName,
        'userDbId': "${gUser.displayName}${gUser.id}",
      }
    );

    // finally lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // 3. sign in with google for web
  Future<void> signInWithGoogleForWeb() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } catch (e) {
      throw Exception(e);
    }
  }

  // SIGN UP METHODS
  // 1. sign up with email and passwords
  Future<UserCredential> signUpWithEmailAndPassword(String emailAddress, String password, String name) async {
    try{
      UserCredential newCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress, 
        password: password,
      );

      // save user in separate doc
      _firestore.collection("Users").doc(newCredential.user!.uid).set(
        {
          'uid': newCredential.user!.uid,
          'email': emailAddress,
          'name': name,
          'userDbId': "$name${newCredential.user!.uid}"
        }
      );

      return newCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  // Step 1: Send OTP to phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onAutoVerify,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (Android only)
          onAutoVerify(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Step 2: Verify OTP and sign in
  Future<UserCredential?> signInWithOTP({
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // SIGN OUT METHOD
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // get user db id
  Future<String> getUserDBId(String uid) async {
      final userDoc = await _firestore
          .collection('Users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();
        return data?['userDbId']; // returns the userDBId
      } else {
        throw Exception("User document not found");
      }
  }
}