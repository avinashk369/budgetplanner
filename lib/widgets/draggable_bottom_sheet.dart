import 'package:flutter/material.dart';

import 'theme_constants.dart';

class DraggableBottomSheet {
  final BuildContext context;

  DraggableBottomSheet(this.context);

/**
 * how to call from widget class
 * paste below code inside widget click function
 */
// showModalBottomSheet(
//    context: context,
//    enableDrag: true,
//    isScrollControlled: true,
//    backgroundColor: Colors.transparent,
//    builder: (context) => buildSheet(),
//  );
  Widget makeDissmisable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          child: child,
          onTap: () {},
        ),
      );
  Widget buildSheet(Widget layout) => makeDissmisable(
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, scrollController) => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            //padding: EdgeInsets.all(10),
            child: ListView(
              controller: scrollController,
              children: [
                SizedBox(height: 15),
                Center(
                  child: Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                      color: Theme.of(context).primaryColor.withOpacity(.12),
                    ),
                  ),
                ),
                layout
              ],
            ),
          ),
        ),
      );

  /**
       * show alert dialog
       */
  showSuccessMessage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: whiteColor,
              content: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 260,
                    color: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                      child: Column(
                        children: [
                          Text(
                            'Successful !!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 32, right: 20),
                            child: Text(
                              'Thanks for purchasing the premium content',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: Text(
                              'Okay',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -64,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 50,
                        child: Icon(
                          Icons.assignment_turned_in,
                          color: Colors.white,
                          size: 40,
                        ),
                      )),
                ],
              ),
            ));
  }
}
