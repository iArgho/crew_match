import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String? imageUrl;

  final sampleImage =
      'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?auto=format&fit=crop&w=400&q=80';

  void _pickImage() {
    setState(() {
      imageUrl = sampleImage;
    });
    widget.onPick(widget.index);
  }

  void _removeImage() {
    setState(() {
      imageUrl = null;
    });
    widget.onRemove(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: imageUrl == null ? _pickImage : null,
      child: Container(
        width: 0.28.sw,
        height: 0.18.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey),
          color: Colors.grey[300],
          image:
              imageUrl != null
                  ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (imageUrl == null)
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
            if (imageUrl != null)
              Positioned(
                bottom: -4.r,
                right: -4.r,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: _removeImage,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
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
