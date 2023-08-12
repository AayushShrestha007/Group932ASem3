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
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _passwordController.text = _authViewModel.loggedInUser?.password ?? '';
    _nameController.text = _authViewModel.loggedInUser?.name ?? '';
    _emailController.text = _authViewModel.loggedInUser?.email ?? '';
    _bioController.text = _authViewModel.loggedInUser?.about ?? '';
    super.initState();
  }

  void changePassword(String password, String id) async {
    try {
      if (password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Fill Password")),
        );
      } else {
        await _authViewModel.changePassword(password, id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password Changed Successfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password too short, please enter a longer password")),
      );
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

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
        if (_authViewModel.loggedInUser != null) {
          _authViewModel.loggedInUser!.image = imageUrl;

          // Save the updated profile to the database
          await _authViewModel.updateUserProfile(_authViewModel.loggedInUser!);
        }
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
                        _authViewModel.loggedInUser?.image ?? "https://picsum.photos/id/237/200/300",
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: "Type Bio...",
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<AuthViewModel>(
                builder: (context, _authViewModel, child) => SizedBox(
                  height: 70,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      changePassword(
                        _passwordController.text,
                        _authViewModel.loggedInUser?.id ?? '',
                      );
                      _updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}