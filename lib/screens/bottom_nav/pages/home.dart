import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budgetplanner/bloc/caffair/caffairbloc.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/widgets/config.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CaffairBloc _caffairBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _caffairBloc = CaffairBloc()..add(LoadCaffairListEvent(pageNumber: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _caffairBloc),
        // BlocProvider(
        //     create: (_) => WorkoutBloc()..add(WorkoutLoadEvent(token: token))),
        // BlocProvider<CourseBloc>(
        //   create: (_) => CourseBloc()
        //     ..add(CourseLoadEvent(token: token))
        //     ..add(LoadBasicEvent(token: token))
        //     ..add(LoadMasterEvent(token: token))
        //     ..add(LoadSkilledEvent(token: token)),
        // ),
      ],
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0.5,
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
              // Padding(
              //   padding: EdgeInsets.only(bottom: 2.0),
              //   child: IconButton(
              //     icon: Icon(
              //       EvaIcons.arrowDown,
              //       color: kWhite,
              //     ),
              //     onPressed: () {
              //_showReportDialog();
              //   },
              // ),
              //),
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
                      color: kWhite,
                      onPressed: () {
                        currentTheme.toggleTheme();
                      }),
                ),
                BlocBuilder<CaffairBloc, CaffairState>(
                  builder: (context, state) {
                    if (state is CaffairListLoaded) {
                      print(state.caffairList.data!.length);
                      //if (userId > 0)
                      return Container(
                        child: Text(
                          state.caffairList.data![0].title!,
                          style: TextStyle(color: kBlack),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                // Positioned(
                //   right: 10,
                //   top: 12,
                //   child: Container(
                //     padding: EdgeInsets.all(1),
                //     decoration: BoxDecoration(
                //       color: red,
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     constraints: BoxConstraints(
                //       minWidth: 13,
                //       minHeight: 13,
                //     ),
                //     child: Text(
                //       '1',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 10,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // )
              ],
            ),
            // IconButton(
            //     icon: Icon(
            //       Icons.account_circle,
            //       size: 21,
            //     ),
            //     color: kWhite,
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => RegistrationPage()));
            //     }),
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
      ),
    );
  }
}
