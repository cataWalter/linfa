import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';

/// Photo picker widget for taking or selecting photos
class PhotoPicker extends StatefulWidget {
  const PhotoPicker({
    super.key,
    this.currentPhotoPath,
    required this.onPhotoSelected,
    this.isSquare = false,
  });

  final String? currentPhotoPath;
  final ValueChanged<String?> onPhotoSelected;
  final bool isSquare;

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null) {
        widget.onPhotoSelected(image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: LinfaColors.danger,
          ),
        );
      }
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppStrings.takePhoto),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppStrings.chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (widget.currentPhotoPath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: LinfaColors.danger),
                title: const Text(
                  AppStrings.removePhoto,
                  style: TextStyle(color: LinfaColors.danger),
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.onPhotoSelected(null);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showPhotoOptions,
      child: Container(
        width: double.infinity,
        height: widget.isSquare ? 200 : 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: widget.currentPhotoPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(widget.currentPhotoPath!),
                      fit: widget.isSquare ? BoxFit.cover : BoxFit.contain,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.photo,
                    style: LinfaTypography.getBodyMedium().copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
