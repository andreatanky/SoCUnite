import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:SoCUniteTwo/services/auth_service.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final _form = GlobalKey<FormState>();
  
  // final formKey = GlobalKey<FormState>();
  // final formKey2 = GlobalKey<FormState>();
  String _newPassword;
  TextEditingController _oldPasswordController = new TextEditingController();

  void _changePassword(String password) async{
   //Create an instance of the current user. 
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_){
      print("Succesfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  bool checkCurrentPasswordValid = true;

  bool validate() {
    final form = _form.currentState;
    form.save();
    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ) ,
        title: Text("Change password",)
    ),
    body: Builder(builder: (context) {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, top: 15.0),
          child: Form(
            key: _form,
            child: Column(
            children: <Widget>[
        TextFormField(
          cursorColor: Colors.tealAccent,
          controller: _oldPasswordController,
           decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.tealAccent,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800]
              )
            ),
            labelStyle: TextStyle(color: Colors.grey[100]),
            labelText: "   Current password",
            //  errorText: checkCurrentPasswordValid 
            //  ? null 
            //  : "Please re-enter your current password"
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Password field cannot be empty";
            } else {
              return null;
            }
          },
        style: TextStyle(fontSize: 18, color: Colors.grey[100]),
        obscureText: true,
        ),
        TextFormField(
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.tealAccent,
              ),
            ),            
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800]
              )
            ),
             labelStyle: TextStyle(color: Colors.grey[100]),
             labelText: "   New password"
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Password field cannot be empty";
              } else if (value.length < 6) {
                return "Password has to be at least 6 characters long";
              } else {
                return null;
              }
            },
          style: TextStyle(fontSize: 18, color: Colors.grey[100]),
          obscureText: true,
          onSaved: (value) => _newPassword = value,
        ),
      SizedBox(height: 40),
      RaisedButton(
              onPressed: () {
                if(validate()) {
                  _changePassword(_newPassword);
                  //Navigator.of(context).pop(); //change password 
                  //print(_newPassword);
                  final snackBar = SnackBar(
            content: Text('Your password change is successful!'),
            duration: Duration(seconds: 3),
          );
                Scaffold.of(context).showSnackBar(snackBar);
                }          
              },
              color: Colors.blue[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Submit", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ]
            )
          )
        )
    );
    })
    );
    
    
    
  }
}