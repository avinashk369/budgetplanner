import 'package:budgetplanner/screens/user/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Authentication {
  /**
   * firbase intialization and check if the user is already logged in or not
   * in case of logged in navigate the user to user info screen
   */
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

/**
 * firebase sign in with gmail id
 */
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            ),
          );
        }
      }
    }
    return user;
  }

/**
 * firbase sign up with email and password
 */
  static Future<User?> registerWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'The account already exists with a different credential.',
          ),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'The password provided is too weak.',
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error occurred using Google Sign-In. Try again.',
        ),
      );
    }
    return user;
  }

/**
 * firebase signin with email and password
 */
  static Future<User?> signinWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'No user found for that email.',
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'Wrong password provided for that user.',
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error occurred using Google Sign-In. Try again.',
        ),
      );
    }
    return user;
  }

/**
 * snackbar alert to show the response message
 */
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.redAccent.shade100,
      content: Text(
        content,
      ),
    );
  }

/**
 * firbase signout function
 */
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  /**
   * send sign in link to the user
   */
  static Future<void> sendSigninLink() async {
    var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url: 'https://mrbudget.page.link',
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'com.finance.budgetplanner',
        androidPackageName: 'com.finance.budgetplanner',
        // installIfNotAvailable
        androidInstallApp: true,

        // minimumVersion
        androidMinimumVersion: '16');

    var emailAuth = 'techcamino@gmail.com';
    FirebaseAuth.instance
        .sendSignInLinkToEmail(email: emailAuth, actionCodeSettings: acs)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification '));
  }

  /**
   * firebase password less sign in using dynamic link
   */
  static Future<User?> signInWithEmailAndLink(
      String emailLink, String email) async {
    var auth = FirebaseAuth.instance;
    User? user;
// Retrieve the email from wherever you stored it
    var emailAuth = 'techcamino@gmail.com';
// Confirm the link is a sign-in with email link.
    if (auth.isSignInWithEmailLink(emailLink)) {
      // The client SDK will parse the code from the link for you.
      auth
          .signInWithEmailLink(email: email, emailLink: emailLink)
          .then((value) {
        // You can access the new user via value.user
        // Additional user info profile *not* available via:
        // value.additionalUserInfo.profile == null
        // You can check if the user is new or existing:
        // value.additionalUserInfo.isNewUser;
        user = value.user;
        print('Successfully signed in with email link!');
      }).catchError((onError) {
        print('Error signing in with email link $onError');
      });
    }
    return user;
  }
}
