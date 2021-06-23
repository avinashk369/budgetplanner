import 'dart:convert';
import 'dart:io';

import 'package:budgetplanner/exception/bad_requrest.dart';
import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';
import 'package:budgetplanner/models/PaginationMeta.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepository.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  late FirebaseFirestore _firestore;
  UserRepositoryImpl() {
    _firestore = FirebaseFirestore.instance;
  }
  @override
  void createUserInDatabaseWithEmail(User user) {
    // TODO: implement createUserInDatabaseWithEmail
  }

  @override
  void createUserInDatabaseWithGoogleProvider(User firebaseUser) async {
    await _firestore
        .collection(user)
        .doc(firebaseUser.uid)
        .set({
          name: firebaseUser.displayName ?? firebaseUser.email,
          email: firebaseUser.email,
        })
        .whenComplete(() => print(
            'Created user in database with Google Provider. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}'))
        .catchError((error) {
          print(error.toString());
        });
  }

  @override
  void testingConnection(String title, String description) async {
    // TODO: implement testingConnection

    List<String> budgetCat = [
      'Travel',
      'Food & Drink',
      'Shopping',
      'Transport',
      'Home',
      'Bills & Fees',
      'Entertainment',
      'Car & Motors',
      'Personal',
      'HealthCare',
      'Education',
      'Groceries',
      'Gift',
      'Sports',
      'Beauty',
      'Business',
      'Others',
    ];

    final CollectionReference _mainCollection = _firestore.collection('notes');

    _firestore.collection("users").add({
      "title": "john",
      "age": 50,
      "description": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print(value.id);
      _firestore.collection("users").doc(value.id).collection("links").add({
        "user_id": value.id,
        "url": "blacky",
        "label": "cat",
        "active": 1,
      });
    }).catchError((onError) => print("error occured ${onError}"));

    var result = {
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    };

    // _mainCollection
    //     .doc("1234")
    //     .set({
    //       'name': title,
    //       'description': description,
    //     })
    //     .then((value) => print('user added'))
    //     .catchError((onError) => print("error occured ${onError}"));
    // _mainCollection.add(result).then((value) {
    //   print('user added');
    //   _firestore
    //       .collection("users")
    //       .doc(value.id)
    //       .collection("pets")
    //       .add({"petName": "blacky", "petType": "dog", "petAge": 1});
    // }).catchError((onError) => print("error occured ${onError}"));
  }

  @override
  Future<BaseModel<CaffairModel>> readCollections() async {
    // TODO: implement testingConnection

    CaffairModel records = CaffairModel();
    records.links = [];
    List<PaginationMeta> paginationMeta = [];

    var response = await _firestore.collection("users").get();
    response.docs.forEach((element) async {
      records = CaffairModel.fromJson(element.data());
      print(records.address!.street);
      var respons = await _firestore
          .collection("users")
          .doc(element.id)
          .collection("links")
          .where("user_id", isEqualTo: element.id)
          .get();
      print("size of ${respons.size}");
      respons.docs.forEach((element) {
        PaginationMeta paginationMeta1 =
            PaginationMeta.fromJson(element.data());
        paginationMeta.add(paginationMeta1);
      });
      records.links = paginationMeta;
      print("Printing label in ${records.links!.length}");

      // print("Printing title ${records!.title}");
    });
    // print("Printing label out ${records.links!.length}");

    // if (response.docs.isNotEmpty) {
    //   print(response.docs.first.id);
    //   records = CaffairModel.fromJson(
    //       response.docs.first.data() as Map<String, dynamic>);
    //   print(records.title);
    // } else {
    //   print("doc no found");
    // }

    return BaseModel()..data = records;
  }

  @override
  Future<BaseModel<UserModel>> getUser(String uid) async {
    UserModel records = UserModel();

    var response = await _firestore.collection(user).doc(uid).get();
    if (response.exists) {
      records = UserModel.fromJson(response.data() as Map<String, dynamic>);
    } else {}

    return BaseModel()..data = records;
  }
}
