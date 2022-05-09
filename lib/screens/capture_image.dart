import 'dart:io';

import 'package:budgetplanner/utils/PreferenceUtils.dart';
import 'package:budgetplanner/utils/app_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({Key? key}) : super(key: key);

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  late CameraDescription camera;
  late CameraController controller;
  bool _isInited = false;
  String? _url;
  XFile? image; //for captured image
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      print(cameras);
      // setState(() {});
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((value) => {
            setState(() {
              _isInited = true;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // child: _isInited ? CameraPreview(controller) : Container()
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  PreferenceUtils.getString("Logged In user - "),
                  style: kLabelStyleBold.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  PreferenceUtils.getString(user_name),
                  style: kLabelStyleBold.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Expanded(
              child: _isInited
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: CameraPreview(controller),
                    )
                  : Container(),
            ),
            Container(
              height: 152,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: _url != null
                        ? Image.file(
                            File(_url!),
                            height: 120,
                            width: 120,
                          )
                        : Container(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: Text('Capture Image'),
          onPressed: () async {
            // final path = join(
            //     (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
            // await controller.takePicture().then((res) => {
            //       setState(() {
            //         _url = path;
            //       })
            //     });
            try {
              if (controller != null) {
                //check if contrller is not null
                if (controller.value.isInitialized) {
                  //check if controller is initialized
                  image = await controller.takePicture(); //capture image
                  setState(() {
                    //update UI
                    print("path name ${image!.path}");
                    _url = image!.path;
                  });
                }
              }
            } catch (e) {
              print(e); //show error
            }
          },
        ),
      ),
    );
  }
}
