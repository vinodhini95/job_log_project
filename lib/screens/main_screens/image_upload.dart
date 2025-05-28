
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_elevator_button.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_text_field.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/dropdown_text_field.dart';
import 'package:gnb_project/model/property_model.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final TextEditingController textFieldController = TextEditingController();
  XFile? _pickedImage;
  String? _selectedPropertyId;

  final List<String> _propertyIds = [
    'P-001',
    'P-002',
    'P-003',
  ]; // Example property IDs

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? pickedFile;

      if (kIsWeb) {
        // Request camera access from the browser
        pickedFile = await picker.pickImage(source: ImageSource.camera);
      } else {
        // For Android or iOS (or desktop fallback)
        pickedFile = await picker.pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear);
      }

      if (pickedFile != null) {
        setState(() {
          _pickedImage = pickedFile;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
  }

  void _retryImage() {
    setState(() => _pickedImage = null);
  }

  void _submitImage() {
    if (_pickedImage == null || _selectedPropertyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a property and capture an image."),
        ),
      );
      return;
    }

    // You can now associate _pickedImage with _selectedPropertyId here.
    debugPrint("Image path: ${_pickedImage!.path}");
    debugPrint("Associated Property ID: $_selectedPropertyId");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Image submitted successfully!")),
    );
    context.read<JobLogProvider>().addeProperty(Property.fromJson({
         "id":_selectedPropertyId,
         "title":textFieldController.text,
         "imagePath":_pickedImage
      }));
    // Optionally clear state
    setState(() {
      _pickedImage = null;
      _selectedPropertyId = null;
      textFieldController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: "Take Photo",
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Dropdown to select property
              DropdownTextField(
                onchangeValue: (value) =>
                    setState(() => _selectedPropertyId = value),
                selectedValue: _selectedPropertyId,
                labelText: 'Select Property ID',
                listData: _propertyIds,
              ),
              const SizedBox(height: 20),
        
              /// Name of property
              AppTextFormField(
                isRequired: true,
                controller: textFieldController,
                readOnly: false,
                labelText: "Property Name",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Property Name Requeried";
                  }
        
                  return null;
                },
              ),
              const SizedBox(height: 20),
        
              /// Take or Retry button
              if (_pickedImage == null)
                AppElevatorButton(
                  label: "Take Photo",
                  onPressed: pickImage,
                  icon: Icons.camera_alt_outlined,
                )
              else
                AppElevatorButton(
                  label: "Retry",
                  onPressed: _retryImage,
                  icon: Icons.refresh,
                ),
        
              const SizedBox(height: 20),
        
              /// Preview Image
              if (_pickedImage != null)
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: kIsWeb
                      ? Image.network(_pickedImage!.path, fit: BoxFit.cover)
                      : Image.file(File(_pickedImage!.path), fit: BoxFit.cover),
                ),
        
              const SizedBox(height: 20),
        
              /// Submit button
              if (_pickedImage != null)
                AppElevatorButton(
                  label: "Submit Image",
                  onPressed: _submitImage,
                  icon: Icons.check_circle_outline,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
