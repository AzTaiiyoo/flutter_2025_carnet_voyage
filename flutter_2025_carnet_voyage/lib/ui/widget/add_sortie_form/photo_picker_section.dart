import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_spacing.dart';
import 'form_card.dart';
import 'section_header.dart';

/// Section de sélection de photo avec aperçu
/// Permet de choisir une image depuis la galerie ou l'appareil photo
class PhotoPickerSection extends StatelessWidget {
  final String? imagePath;
  final ValueChanged<String?> onImageChanged;

  const PhotoPickerSection({
    super.key,
    this.imagePath,
    required this.onImageChanged,
  });

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (image != null) {
      onImageChanged(image.path);
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (image != null) {
      onImageChanged(image.path);
    }
  }

  void _removeImage() {
    onImageChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.photo_camera,
            title: 'Photo (optionnel)',
          ),
          SizedBox(height: AppSpacing.md),
          if (imagePath != null) ...[
            _buildImagePreview(colorScheme),
            SizedBox(height: AppSpacing.ms),
          ],
          _buildPickerButtons(),
        ],
      ),
    );
  }

  Widget _buildImagePreview(ColorScheme colorScheme) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: AppSpacing.photoRadius,
          child: Image.file(
            File(imagePath!),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: AppSpacing.sm,
          right: AppSpacing.sm,
          child: GestureDetector(
            onTap: _removeImage,
            child: Container(
              padding: EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: colorScheme.onError,
                size: AppSpacing.iconMs,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickerButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _pickImageFromGallery,
            icon: const Icon(Icons.photo_library),
            label: const Text('Galerie'),
          ),
        ),
        SizedBox(width: AppSpacing.ms),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _pickImageFromCamera,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Appareil'),
          ),
        ),
      ],
    );
  }
}
