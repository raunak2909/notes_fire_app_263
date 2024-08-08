import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  bool isPassObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Account', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 21,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Enter name here..'
                ),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email here..'
                ),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                    hintText: 'Enter age here..'
                ),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                    hintText: 'Enter gender here..'
                ),
              ),
              SizedBox(
                height: 11,
              ),
              TextField(
                controller: passController,
                obscureText: isPassObscure,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: (){
                      isPassObscure = !isPassObscure;
                      setState(() {

                      });
                    },
                      child: isPassObscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                    hintText: 'Enter pass here..'
                ),
              ),
              TextField(
                controller: confirmPassController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter pass here..'
                ),
              ),
              SizedBox(
                height: 21,
              ),
              ElevatedButton(onPressed: () async{

                /// get all value to be added when account is created
                String name = nameController.text.toString();
                String email = emailController.text.toString();
                String age = ageController.text.toString();
                String gender = genderController.text.toString();
                String pass = passController.text.toString();
                String confirmPass = confirmPassController.text.toString();

                //if(name.isNotEmpty && email.isNotEmpty && )

                if(pass==confirmPass){

                  FirebaseAuth mAuth = FirebaseAuth.instance;
                  try{
                    var cred = await mAuth.createUserWithEmailAndPassword(email: email, password: pass);
                    print("UserId: ${cred.user!.uid}");

                    FirebaseFirestore firestore = FirebaseFirestore.instance;

                    var docRef = await firestore.collection('users').doc(cred.user!.uid).set({
                      'email': email,
                      'name':name,
                      'age':age,
                      'gender':gender
                    });

                    print("User doc created!!");

                  } on FirebaseAuthException catch(e){
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    } else if(e.code=='invalid-email'){
                      print('The email is invalid!!');
                    }
                  } catch(e){

                  }

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords did not match!!')));
                }



              }, child: Text('SignUp'))
            ],
          ),
        ),
      ),
    );
  }
}