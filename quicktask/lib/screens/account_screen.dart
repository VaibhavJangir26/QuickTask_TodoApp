import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/providers/theme_provider.dart';
import '../providers/authentication_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8,),

                displayProfile(width, height),

                personalDetails(width, height),

                settings(width, height, context),

                faqs(width, height),

                logout(width, height),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayProfile(final width, final height) {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: width / 10,
          child: Image.asset("assets/images/profile.jpg")
        ),
        Text(
          authProvider.userInfoModel?.displayName?? "Guest",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(authProvider.userInfoModel?.email?? "guest@gmail.com"),
      ],
    );
  }

  Widget personalDetails(final width, final height) {
    return SizedBox(
      width: width * .85,
      height: height * .1,
      child: Card(
        child: ListTile(
          leading: const Card(
            elevation: 5,
            child: Icon(Icons.person, size: 25,),
          ),
          title: const Text("Personal details"),
          trailing: const Card(
            elevation: 5,
            child: Icon(Icons.keyboard_arrow_right),
          ),
          onTap: (){
            TextEditingController changePassword=TextEditingController();
            final formKey=GlobalKey<FormState>();
            showModalBottomSheet(
                context: context,
                elevation: 5,
                enableDrag: true,
                showDragHandle: true,
                backgroundColor: Theme.of(context).primaryColor,
                builder: (context){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Change Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                      Form(
                        key: formKey,
                        child: TextFormField(
                          controller: changePassword,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Required";
                            }
                            if(value.length<8){
                              return "Minimum 8 length password required.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "New Password",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width/2,
                        child: Consumer<AuthenticationProvider>(
                          builder: (context,value,widget){
                            return  ElevatedButton(onPressed: (){
                              if(formKey.currentState!.validate()){
                                value.changePassword(changePassword.text.toString());
                                changePassword.clear();
                                Navigator.pop(context);
                              }
                            }, child: value.isLoading? const CircularProgressIndicator(strokeWidth: 2.5,):const Text("Update"));
                          },

                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget settings(final width, final height, BuildContext context) {
    return SizedBox(
        width: width * .85,
        height: height * .1,
        child: Card(
          child: ListTile(

              leading: const Card(
                elevation: 5,
                child: Icon(Icons.settings, size: 25),
              ),

              title: const Text("Settings"),
              trailing: const Card(
                  child: Icon(Icons.keyboard_arrow_right)
              ),

              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).primaryColor,
                    showDragHandle: true,
                    useSafeArea: true,
                    builder: (context) => Consumer<ThemeProvider>(
                      builder:(context,value,child){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                                leading: const Icon(Icons.dark_mode),
                                title: const Text("Dark Theme"),
                                onTap: () {
                                  value.changeTheme(ThemeMode.dark);
                                  Navigator.pop(context);
                                }
                            ),
                            ListTile(
                                leading: const Icon(Icons.light_mode),
                                title: const Text("Light Theme"),
                                onTap: () {
                                  value.changeTheme(ThemeMode.light);
                                  Navigator.pop(context);
                                }
                            ),
                          ],
                        );
                      }
                    )
                );
              }
          ),
        )
    );
  }

  Widget faqs(final width, final height) {
    return SizedBox(
        width: width * .85,
        height: height * .1,
        child: Card(
          child: ListTile(
            leading: const Card(
              elevation: 5,
              child: Icon(Icons.question_mark, size: 25,),
            ),
            trailing: const Card(
              elevation: 5,
              child: Icon(Icons.keyboard_arrow_right,),
            ),
            title: const Text("FAQ's"),
            onTap: (){

              showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  showDragHandle: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 5,
                  useSafeArea: true,
                  builder: (context){
                return Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text("We're here to help you with anything and everything on QuickTask",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        const Text("FAQs",style: TextStyle(fontSize: 20),),

                        ExpansionTile(
                          title: const Text("How to create?"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          children: const [
                          Text("Click on add button and then create your new task."),
                          ],
                        ),
                        ExpansionTile(
                          title: const Text("How to delete?"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          children: const [
                            Text("Which todo you want to delete slide it from right to left to delete after confirm it."),
                          ],
                        ),
                        ExpansionTile(
                          title: const Text("How to change password?"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          children: const [
                            Text("Go to setting and see there is password change option from there change your password"),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        )
    );
  }

  Widget logout(final width, final height) {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    return SizedBox(
        width: width * .85,
        height: height * .1,
        child: Card(
          child: ListTile(
            leading: const Card(
              elevation: 5,
              child: Icon(Icons.logout, size: 25,),
            ),
            title: const Text("Logout"),
            onTap: () {
              authProvider.logout(context);
            },
          ),
        )
    );
  }
}
