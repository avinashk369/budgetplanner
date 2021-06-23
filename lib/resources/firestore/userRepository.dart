import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class UserRepository {
  void createUserInDatabaseWithEmail(auth.User user);
  void createUserInDatabaseWithGoogleProvider(auth.User user);
  void testingConnection(String name, String age);
  Future<BaseModel<CaffairModel>> readCollections();
  Future<BaseModel<UserModel>> getUser(String uid);
}
