import 'package:baranh_rider/Widgets/text_widget.dart';
import 'package:baranh_rider/utils/config.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';

import '../Screens/login.dart';
import '../backend/orders.dart';
import '../utils/dynamic_sizes.dart';
import 'loader.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final List snapshot;
  final int index;
  const TakePictureScreen({
    Key? key,
    required this.camera,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customBlack,
      appBar: customAppbar(
          context: context,
          text1: "Take a picture",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customOrange),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: CameraPreview(_controller)),
                ClickPicture(
                  controller: _controller,
                  initializeControllerFuture: _initializeControllerFuture,
                  snapshot: widget.snapshot,
                  index: widget.index,
                ),
                text(context, "Photo", 0.04, CustomColors.customOrange),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Loader();
          }
        },
      ),
    );
  }
}

class ClickPicture extends StatefulWidget {
  final List snapshot;
  final int index;
  final CameraController controller;
  final Future<void> initializeControllerFuture;
  const ClickPicture(
      {Key? key,
      required this.controller,
      required this.initializeControllerFuture,
      required this.snapshot,
      required this.index})
      : super(key: key);

  @override
  State<ClickPicture> createState() => _ClickPictureState();
}

class _ClickPictureState extends State<ClickPicture> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        // Take the Picture in a try / catch block. If anything goes wrong,
        // catch the error.

        try {
          // Ensure that the camera is initialized.
          await widget.initializeControllerFuture;

          // Attempt to take a picture and get the file `image`
          // where it was saved.
          // final XFile image = await widget.controller.takePicture();
          // final encodeImage = base64Encode(await image.readAsBytes());
          var res = await RiderFunctionality().setOrderStatus(
              widget.snapshot[widget.index]["sale_no"], "not at home", "0", "");
          if (res == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: text(context, "Check your internt or try again", 0.04,
                    CustomColors.customWhite)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    text(context, "Success", 0.04, CustomColors.customWhite)));
          }
          // If the picture was taken, display it on a new screen.

          setState(() {
            isLoading = false;
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          // If an error occurs, log the error to the console.
          debugPrint(e.toString());
        }
      },
      child: CircleAvatar(
        radius: CustomSizes().dynamicWidth(context, 0.1),
        child: (isLoading == true)
            ? const CircularProgressIndicator(
                color: CustomColors.customWhite,
              )
            : Icon(
                Icons.camera,
                size: CustomSizes().dynamicWidth(context, 0.07),
              ),
      ),
    );
  }
}
