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
    // Request photo permission
    final permissionStatus = await _requestPhotoPermission();
    if (!permissionStatus.isGranted) {
      _showPermissionDeniedDialog();
      return;
    }

    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Compress image to reduce size
      );

      if (pickedImage != null && mounted) {
        setState(() {
          _pickedFile = File(pickedImage.path);
        });
        widget.onPick(widget.index);
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error picking image: $e");
      if (mounted) {
        _showErrorDialog("Failed to pick image. Please try again.");
      }
    }
  }

  Future<PermissionStatus> _requestPhotoPermission() async {
    if (Platform.isIOS) {
      return await Permission.photos.request();
    } else {
      // For Android, handle different permissions based on version
      final status = await Permission.storage.request();
      if (status.isGranted) return status;
      return await Permission.photos.request();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text(
              "Please grant photo access to select images. You can enable it in settings.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text("Open Settings"),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void _removeImage() {
    if (mounted) {
      setState(() {
        _pickedFile = null;
      });
      widget.onRemove(widget.index);
    }
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
