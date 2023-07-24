import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/global_ui_viewmodel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController= TextEditingController();

  void initState(){

    _ui= Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel= Provider.of<AuthViewModel>(context, listen: false);
    _passwordController.text=_authViewModel!.loggedInUser!.password!;
    _nameController.text=_authViewModel!.loggedInUser!.name!;
    _emailController.text=_authViewModel!.loggedInUser!.email!;
    _bioController.text= _authViewModel!.loggedInUser!.about!;
    super.initState();
  }


  void changePassword(String password, String id) async{
    try {
      if (password == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please Fill Password")));
      }
      else {
        await _authViewModel.changePassword(password, id);
      }
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password too short, please enter a longer password")));
    }
  }

  void changeBio(String bio, String id) async{
    try {
      await _authViewModel.changeBio(bio, id);
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
    }
  }

// widget build 
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
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 89,
                child: CircleAvatar(
                  radius: 87,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                    backgroundColor: Colors.blue,
                    onBackgroundImageError: (e, s) {
                      debugPrint('image issue, $e,$s');
                    },
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
                        )
                    )
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
                builder: (context, _authViewModel, child)=>
                    SizedBox(
                      height: 70,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: (){
                          changePassword(_passwordController.text, _authViewModel!.loggedInUser!.id!);
                          changeBio(_bioController.text, _authViewModel!.loggedInUser!.id!);
                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.redAccent, //background color of button
                          // side: BorderSide(width:0, color:Colors.brown), //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                              fontSize: 18
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
