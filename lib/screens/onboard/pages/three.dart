import 'package:budgetplanner/screens/onboard/widgets/next_page_button.dart';
import 'package:budgetplanner/screens/onboard/widgets/ripple.dart';
import 'package:budgetplanner/screens/user/email_signin.dart';
import 'package:budgetplanner/screens/user/user_login.dart';
import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class Three extends StatefulWidget {
  final double screenHeight;

  const Three({
    required this.screenHeight,
  }) : assert(screenHeight != null);

  @override
  _ThreeState createState() => _ThreeState();
}

class _ThreeState extends State<Three> with TickerProviderStateMixin {
  late AnimationController _rippleAnimationController;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: widget.screenHeight,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _rippleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDark,
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'photo-1566501206188…' (shape)
          Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'YOUR ULTIMATEPERSONAL TRAINER',
                        style: kTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Personalized workouts and plans for any fitness goal and skill level',
                        style: kSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        image: DecorationImage(
                          image: const AssetImage('assets/images/three.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: NextPageButton(
                          onPressed: () async => await _nextPage(),
                        ),
                      ),
                    )
                  ],
                )
              ])),
          AnimatedBuilder(
            animation: _rippleAnimation,
            builder: (_, Widget? child) {
              return Ripple(
                radius: _rippleAnimation.value,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _nextPage() async {
    await _rippleAnimationController.forward();
    PreferenceUtils.putBool(has_seen, true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => UserLogin())); //EmailSignin()
  }
}
