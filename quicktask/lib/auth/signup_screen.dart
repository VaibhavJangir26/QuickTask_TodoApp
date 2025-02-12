import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import '../utility/toast_msg.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isPassVisible = false;

  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();

  void showPassword() {
    setState(() {
      isPassVisible = !isPassVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [

            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xfffff1eb),
                  Color(0xfface0f9),
                ])
              ),
            ),

            SingleChildScrollView(
              child: Container(
                width: width * .85,
                height: height * .9,
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      const Text("Create an account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),

                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (nameController.text.isEmpty) {
                            return "Enter the Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey))),
                      ),

                      const SizedBox(height: 5,),

                      TextFormField(
                        enableSuggestions: true,
                        enableIMEPersonalizedLearning: true,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (emailController.text.isEmpty) {
                            return "Enter the email";
                          }
                          if (!value!.contains('@')) {
                            return "Enter a valid mail";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey))
                        ),
                      ),

                      const SizedBox(height: 5,),

                      TextFormField(
                        controller: passwordController,
                        obscureText: isPassVisible ? false : true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (passwordController.text.isEmpty) {
                            return "Enter the Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              onPressed: showPassword,
                              icon: isPassVisible? const Icon(Icons.remove_red_eye) : const Icon(CupertinoIcons.eye_slash_fill),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey))),
                      ),

                      const SizedBox(height: 5,),


                      checkBoxList(height, width),

                      signupButton(height, width),

                      // continueWith(height, width),

                      // otherSignupOptions(height, width),

                      SizedBox(height: height * .005,),

                      moveToLoginScreen(height, width),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signupButton(double height,double width){
    return Container(
      width: width * .6,
      height: height * .095,
      padding: const EdgeInsets.all(8),

       child: Consumer<AuthenticationProvider>(
         builder: (context,value,widget){
           return ElevatedButton(
             style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)
                 )
             ),
             onPressed: () {
               if (!isChecked) {
                 ToastMsg.toastMsg("Please accept the T&Cs and Privacy Policy");
               }
               if (_formKey.currentState!.validate() && isChecked) {
                 value.signup(emailController.text.toString(), passwordController.text.toString(), nameController.text.toString(),context);
               }
              },
             child: value.isLoading?const SizedBox(
               width: 20,
               height: 20,
               child: CircularProgressIndicator(strokeWidth: 2.5,)):const Text("Register",style: TextStyle(fontSize: 15),),

           );
         },
       ),



    );
  }

  Widget checkBoxList(double height,double width){
    return CheckboxListTile(
        value: isChecked,
        activeColor: Colors.blue,
        controlAffinity: ListTileControlAffinity.leading,
        title: const Text("By clicking this you accept our T&Cs. and Privacy Policy.",
          style: TextStyle(fontSize: 11),
        ),
        onChanged: (bool? value) {
          setState(() {
            isChecked = value ?? false;
          });
        });
  }


  // Widget continueWith(double height,double width){
  //   return Container(
  //     width: width,
  //     height: height * .04,
  //     alignment: Alignment.center,
  //     child: const Text("--or Continue with--"),
  //   );
  // }
  //
  //
  // Widget otherSignupOptions(double height,double width){
  //   return Container(
  //     width: width,
  //     height: height * .08,
  //     padding: const EdgeInsets.all(4),
  //     alignment: Alignment.center,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const CircleAvatar(
  //           foregroundColor: Colors.grey,
  //           foregroundImage: AssetImage("assets/images/googlelogo.png"),
  //         ),
  //         SizedBox(width: width * .02,),
  //         const CircleAvatar(
  //           foregroundColor: Colors.grey,
  //           foregroundImage: AssetImage("assets/images/facebooklogo.png"),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget moveToLoginScreen(double height,double width){
    return  Container(
      width: width,
      height: height * .05,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Create an Account?"),
          SizedBox(width: width * .025,),
          InkWell(onTap: () => Navigator.pushNamed(context, "/login"),
              child: const Text("Login",
                style: TextStyle(color: Colors.pink),
              )
          ),
        ],
      ),
    );
  }



}
