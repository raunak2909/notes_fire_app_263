import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginMobilePage extends StatelessWidget{

  TextEditingController mobNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: mobNoController,
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(onPressed: (){
      
              FirebaseAuth mAuth = FirebaseAuth.instance;
      
              mAuth.verifyPhoneNumber(
                phoneNumber: '+91${mobNoController.text.toString()}',
                  verificationCompleted: (authCred){
                    print('Verified successfully!!');
                  },
                  verificationFailed: (error){
                    print('Verification Failed!!: ${error.message}');
                  },
                  codeSent: (verificationId, resendToken){
                    ///when OTP is sent
                    ///move to next page
                  },
                  codeAutoRetrievalTimeout: (verificationId){
      
                  });
      
            }, child: Text('Send OTP'))
          ],
        ),
      ),
    );
  }

}