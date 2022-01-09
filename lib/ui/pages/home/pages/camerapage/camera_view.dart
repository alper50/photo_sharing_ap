import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/home/pages/camerapage/previewpage.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State {
  CameraController? controller;
  late List cameras;
  late int selectedCameraIndex;
  String? imgPath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      } else {
        print('No camera available');
      }
    }).catchError((err) {
      print('Error :${err.code}Error message : ${err.message}');
    });
  }


  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _cameraPreviewWidget(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[_cameraControlWidget(context),],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: CircleAvatar(
            backgroundColor: Colors.green,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            _onCapturePressed(context);
          },
        ),
      ),
    );
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error:${e.code}\nError message : ${e.description}';
    print(errorText);
  }

  void _onCapturePressed(context) async {
    try {
      final path = await controller!.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CamereVieww(
            imgPath: path.path,
          ),
        ),
      );
    } catch (e) {
      _showCameraException(e as CameraException);
    }
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
