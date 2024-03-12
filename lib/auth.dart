import 'package:chat/image_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class Auth_Screen extends StatefulWidget {
  const Auth_Screen({super.key});

  @override
  State<Auth_Screen> createState() => _Auth_ScreenState();
}

class _Auth_ScreenState extends State<Auth_Screen> {
  final _form = GlobalKey<FormState>();

  bool type = true;
  bool _isLogin = false;
  var _Email_add = "";
  var _Password = "";
  var _Entered_username = "";
  File? _selectedImage;

  void _onSubmit() async {
    final _isValid = _form.currentState!.validate();

    if (_isValid) {
      print(_Email_add);
      print(_Password);
    }

    if (!_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();

    try {
      if (_isLogin) {
        final AccountCreate = await _firebase.signInWithEmailAndPassword(
            email: _Email_add, password: _Password);
     //   print(AccountCreate);
      } else {
        final AccountCreate = await _firebase.createUserWithEmailAndPassword(
            email: _Email_add, password: _Password);
        final StorageRef = FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child('${AccountCreate.user!.uid}.jpg');
        await StorageRef.putFile(_selectedImage!);
        final url_image = await StorageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(AccountCreate.user!.uid)
            .set({
          'username': _Entered_username,
          'email': _Email_add,
          'image_url': url_image,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message ?? '')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                child: Image.asset("assets/images/chat.png"),
              ),
              Text(
                _isLogin ? "Login" : "Sign Up",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            Image_uploads(
                              onPickImage: (File pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          // UserImagePicker(
                          //   onPickImage: (File pickedImage) {
                          //     _selectedImage = pickedImage;
                          //   },
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: "Email Address"),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please entre a valid email address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _Email_add = value!;
                            },
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "User Name"),
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return "Please enter a valid user name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _Entered_username = value!;
                              },
                            ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      type = !type;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color:
                                        type ? Colors.black12 : Colors.purple,
                                  ),
                                )),
                            obscureText: type,
                            onSaved: (value) {
                              _Password = value!;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: _onSubmit,
                                  child: Text(
                                    _isLogin ? "Login" : "Signup",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? "Create an account"
                                    : "I already have an account. Login.")),
                          )
                        ],
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
