import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/cubits/send_picture/send_picture_cubit.dart';
import 'package:recipe_app/cubits/send_picture/send_picture_state.dart';
import 'package:recipe_app/screens/detected_item_screen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendPictureCubit(),
      child: const CameraScreenBody(),
    );
  }
}

class CameraScreenBody extends StatefulWidget {
  const CameraScreenBody({Key? key}) : super(key: key);

  @override
  _CameraScreenBodyState createState() => _CameraScreenBodyState();
}

class _CameraScreenBodyState extends State<CameraScreenBody> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late XFile pictureFile;
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePictureAndConfirm() async {
    try {
      XFile pictureFile = await _controller.takePicture();
      setState(() {
        pictureFile = pictureFile;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _pickImage() async {
    // Pick image logic
    // Replace this with your actual logic
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        // Do something with the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _takePictureAndConfirm();
                  context.read<SendPictureCubit>().sendPicture(pictureFile);
                },
                child: const Text('Take Picture'),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
            ],
          ),
          BlocBuilder<SendPictureCubit, SendPicture>(
            builder: (context, state) {
              return state is SendPictureLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (state is SendPictureSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetectedItemScreen(
                                  response: state.recipeResponse),
                            ),
                          );
                        }
                      },
                      child: const Text('View Recipes'),
                    );
            },
          ),
        ],
      ),
    );
  }
}
