import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netflix_app/auth/presentation/login_page.dart';

import '../../infrastructure/user_details.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  bool isFile = false;
  File? fileImage;
  Uint8List? memoryImage;
  @override
  Widget build(BuildContext context) {
    final detailsStatus = context.watch<DetailsCubit>().state;
    final imagePickedStatus = context.watch<PickedConfirmImageCubit>().state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // if (fileImage == null && memoryImage == null)
        if (imagePickedStatus == ImagePickedConfirmStatus.none)
          Center(
              child: Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile == null) return;

                  final file = File(pickedFile.path);
                  setState(() {
                    fileImage = file;
                  });

                  addImageAndSetImagePicked(file);
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/person.jpg'),
                  radius: 65,
                ),
              ),
              Positioned(
                top: 80,
                left: 90,
                child: IgnorePointer(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 25, 25),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      Icons.camera_enhance,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )),
        if (imagePickedStatus == ImagePickedConfirmStatus.imageCanceled ||
            imagePickedStatus == ImagePickedConfirmStatus.imageConfirmed)
          buildFileImage(detailsStatus),
      ],
    );
  }

  Widget buildFileImage(UserDetails detailsStatus) => Stack(
        children: [
          GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile == null) return;

              final file = File(pickedFile.path);
              setState(() {
                fileImage = file;
              });

              addImageAndSetImagePicked(file);
            },
            child: detailsStatus.image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(
                      detailsStatus.image!,
                    ),
                    radius: 65,
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/person.jpg'),
                    radius: 65,
                  ),
          ),
          Positioned(
            top: 80,
            left: 90,
            child: IgnorePointer(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 26, 25, 25),
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.camera_enhance,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
  void addImageAndSetImagePicked(File file) {
    context.read<PickedConfirmImageCubit>().setImagePicked();
    context.read<ImagePreviewCubit>().setImagePreview(file);
  }

  Widget buildButton() => ElevatedButton(
      child: const Text('Pick Image'),
      onPressed: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile == null) return;

        final file = File(pickedFile.path);
        setState(() {
          fileImage = file;
        });
        addToDetail(file);
      });
  void addToDetail(File file) => context.read<DetailsCubit>().addImage(file);
}

enum ImagePickedConfirmStatus {
  none,
  imagePicked,
  imageConfirmed,
  imageCanceled,
}

class PickedConfirmImageCubit extends Cubit<ImagePickedConfirmStatus> {
  PickedConfirmImageCubit() : super(ImagePickedConfirmStatus.none);
  void setImagePicked() => emit(ImagePickedConfirmStatus.imagePicked);
  void setImageConfirmed() => emit(ImagePickedConfirmStatus.imageConfirmed);
  void setImageNone() => emit(ImagePickedConfirmStatus.imageCanceled);
}
