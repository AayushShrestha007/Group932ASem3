import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/global_ui_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _selectedImage;

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _passwordController.text = _authViewModel.loggedInUser!.password!;
    _nameController.text = _authViewModel.loggedInUser!.name!;
    _emailController.text = _authViewModel.loggedInUser!.email!;
    _bioController.text = _authViewModel.loggedInUser!.about!;
  }

  void changePassword(String password, String id) async {
    try {
      if (password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please Fill Password")));
      } else {
        await _authViewModel.changePassword(password, id);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password too short, please enter a longer password")));
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_selectedImage != null) {
      // Upload image to Firebase Storage and get the URL
      String? imageUrl = await _authViewModel.uploadProfileImage(_selectedImage!);

      if (imageUrl != null) {
        // Update the image URL in the user model
        _authViewModel.loggedInUser!.image = imageUrl;

        // Save the updated profile to the database
        await _authViewModel.updateUserProfile(_authViewModel.loggedInUser!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload profile image")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _selectImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 89,
                  child: CircleAvatar(
                    radius: 87,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: (_selectedImage != null)
                          ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      )
                          : Image.network(
                        _authViewModel.loggedInUser!.image ??
                            "https://picsum.photos/id/237/200/300",
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateProfile();
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed("/userselect");
                    };
                },
                child: Text('Update Profile'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
