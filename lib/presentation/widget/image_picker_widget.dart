import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerWidget extends StatefulWidget {
  final int index;
  final void Function(int) onPick;
  final void Function(int) onRemove;

  const ImagePickerWidget({
    super.key,
    required this.index,
    required this.onPick,
    required this.onRemove,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _pickedFile;

  Future<void> _pickImage() async {
    var permissionStatus = await Permission.photos.request();
    if (!permissionStatus.isGranted) {
      print("Permission denied");
      return;
    }

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedFile = File(pickedImage.path);
      });
      widget.onPick(widget.index);
    } else {
      print("No image selected");
    }
  }

  void _removeImage() {
    setState(() {
      _pickedFile = null;
    });
    widget.onRemove(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickedFile == null ? _pickImage : null,
      child: Container(
        width: 0.28.sw,
        height: 0.18.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey),
          color: Colors.grey[300],
          image:
              _pickedFile != null
                  ? DecorationImage(
                    image: FileImage(_pickedFile!),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (_pickedFile == null)
              Positioned(
                bottom: -4.r,
                right: -4.r,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: _pickImage,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink[400],
                    ),
                    child: const Icon(Icons.add, size: 24, color: Colors.white),
                  ),
                ),
              ),
            if (_pickedFile != null)
              Positioned(
                bottom: -4.r,
                right: -4.r,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: _removeImage,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
