import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/user_model.dart';
import 'package:budgetplanner/resources/firestore/userRepositoryImpl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<UserModel> getUser() async {
    BaseModel<UserModel> user =
        await userRepositoryImpl.getUser("wyly5t8m8yTisWgEUA6BDRbd7xp2");
    print(user.data!.email);
    return user.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${course_image_url}"
                    "logo.jpeg"),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 4.0,
                ),
                child: IconButton(
                    icon: Icon(
                      EvaIcons.bellOutline,
                      size: 20,
                    ),
                    //color: kWhite,
                    onPressed: () {
                      currentTheme.toggleTheme();
                    }),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Patrol'),
              onPressed: () => setState(() {}),
            ),
            Text(
              "Hello",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
