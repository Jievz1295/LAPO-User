import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapo_user/authentication/auth_screen.dart';
import 'package:lapo_user/global/global.dart';
import 'package:lapo_user/mainScreen/home_screen.dart';
import 'package:lapo_user/widgets/custom_text_field.dart';
import 'package:lapo_user/widgets/error_dialog.dart';
import 'package:lapo_user/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> 
{
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c)
        {
          return const ErrorDialog(
            message: "Please fill up the email/password!",
          );
        }
      );
    }
  }

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return const LoadingDialog(
            message: "Checking Credentials",
          );
        }
      );

      User? currentUser;
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(), 
      ).then((auth){
          currentUser = auth.user!;
      }).catchError((error){
        Navigator.pop(context);
        showDialog(
        context: context,
        builder: (c)
        {
          return ErrorDialog(
            message: error.message.toString(),
            );
           }
        );
      });

      if(currentUser != null)
      {
        readDataAndSetDataLocally(currentUser!);
      }
  }

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("users")
    .doc(currentUser.uid)
    .get()
    .then((snapshot) async{
        if(snapshot.exists)
        {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email", snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["name"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);

          List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
          await sharedPreferences!.setStringList("userCart", userCartList);


          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        }
        else
        {
          firebaseAuth.signOut();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));

           showDialog(
            context: context,
            builder: (c)
            {
              return const ErrorDialog(
                message: "No record found! Do sign up an account",
                );
              }
            );
        }
        
      });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                  "images/login.png",
                height: 270,
                ),
            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "E-mail",
                    isObsecre: false,
                    ),
                CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                        isObsecre: true,
                    ),
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors. blue,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: ()
              {
                formValidation();
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
            const SizedBox(height: 30,),
        ],
      ),
    );
  }
}