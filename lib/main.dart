import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Splashcreen(),
    );
  }
}

class Splashcreen extends StatefulWidget {
  @override
  State<Splashcreen> createState() => _SplashcreenState();
}

class _SplashcreenState extends State<Splashcreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.black,
        child: Center(child: Column(
          children: [
            Container(child: Image.asset('images/web-dev-icon-2.png'),),
           Container(child: Image.asset('images/web_imag.png'),),
          ],
        )),
      ),
    );
  }
  splash() async {
    var user=await FirebaseAuth.instance.currentUser;
    print(user);
    //  var isSignedIn = await AuthService().handleAuth();
    setState(() {});
    if (user!=null){


      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));



    }
    else{

      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login_Page()));



    }
  }

}


class Login_Page extends StatefulWidget {



  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  FirebaseAuth auth=FirebaseAuth.instance;
  final _formkey=GlobalKey<FormState>();
PageController _pageController=PageController();
  TextEditingController email=TextEditingController();
  int _currentindex=0;
  TextEditingController password=TextEditingController();
  @override
  Future login()async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                  return HomeScreen();
                }));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(e.toString()), duration: Duration(seconds: 1),),);

    }
  }
  Future signin()async{
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.text.toString(), password: password.text.toString());
    }
    catch(e){
      if(e.toString().contains('empty')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Fields Empty'), duration: Duration(seconds: 1),),);
        print(e);
      }
      else if(e.toString().contains('already in use')){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Email already registered'), duration: Duration(seconds: 1),),);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.toString()), duration: Duration(seconds: 1),),);
      }
    }
  }

  void initState() {

 //   print(videoId);
    // TODO: implement initState
    super.initState();
  }
  @override

 // String videoId=YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU")??'';
  //print(videoId); // BBAyRBTfsOU



  Widget build(BuildContext context) {
   //print(auth.currentUser);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        itemBuilder: (BuildContext context,int pages){
          return _currentindex==0?Container(
            color: Colors.white,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                  height: 100.0,
                  child: Row(
                    children: [
                      Flexible(child: Text('<h1>Hey There,Sign Up to get started</h1> ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30.0),)),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(

                    controller: email,
                    onChanged: (email){
                      print(email);
                    },
                    decoration: InputDecoration(
                        hintText: "Email"

                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    onChanged: (pass){
                      print(pass);
                    },
                    decoration: InputDecoration(
                        hintText: "Password"

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    login();
                   // signin();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    //  color: Colors.red,
                    padding: EdgeInsets.all(20.0),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width*0.78,
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Container(child: Text('Have not enrolled yet?',style: TextStyle(color: Colors.black,fontSize: 18.0),)),
                    GestureDetector(
                        onTap: (){
                          _pageController.animateToPage(_currentindex=1, duration: Duration(milliseconds: 300), curve: Curves.decelerate);
                        },
                        child: Container(child: Text('Enroll here',style: TextStyle(color: Colors.blueAccent,fontSize: 18.0,fontWeight: FontWeight.w600),))),
                  ],
                ),

                //onReady () {
                //controller.addListener(listener);
                //},
                //),
              ],
            ),
          ):Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.07,
              ),
              Container(
               // margin: EdgeInsets.only(top: 50.0,left: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_left,size: 18.0,),
                    GestureDetector(
                        onTap: (){
                          _pageController.animateToPage(_currentindex=0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                        },
                        child: Text('Back',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18.0),)),
                  ],
                ),),
                //SizedBox(height: 150.0,),
              CircleAvatar(
                maxRadius: 80.0,
                child: Image.asset('images/1725265.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Registration Form',style: TextStyle(color: Colors.greenAccent,fontSize: 30.0,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(

                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  //padding: EdgeInsets.all(20.0),
                  child: TextFormField(

                    onChanged: (name){
                      print(name);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left:10.0,top: 10.0,bottom: 10.0),
                        // border: Border.d,
                        border: InputBorder.none,
                        hintText: "Name"

                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(

                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  //padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: email,
                    onChanged: (email){
                      print(email);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left:10.0,top: 10.0,bottom: 10.0),
                        // border: Border.d,
                        border: InputBorder.none,
                        hintText: "Email"

                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(

                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  //padding: EdgeInsets.all(20.0),
                  child: TextFormField(

                    onChanged: (phone){
                      print(phone);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left:10.0,top: 10.0,bottom: 10.0),
                        // border: Border.d,
                        border: InputBorder.none,
                        hintText: "Phone No."

                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(
                    
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  //padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: password,
                    onChanged: (pass){
                      print(pass);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left:10.0,top: 10.0,bottom: 10.0),
                     // border: Border.d,
                        border: InputBorder.none,
                        hintText: "Password"

                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){
                signin();
                if(auth.currentUser!=null) {
                  FirebaseFirestore.instance.collection("users")
                      .doc(email.text)
                      .set({
                    "name": "Rohit",
                    "email": email.text,
                    "phone": "8779682415"
                  })
                      .then((value) {
                    //   signin();
                    //Future.delayed(Duration(seconds: 2));
                    print('added');
                  });
                  email.clear();
                  password.clear();
                }
                },
                child: Container(
                  height: 40.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(child: Text('Register',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),)),),
              ),
            ],
          );
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      ),
    );

  }

}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cheatsheets'),
              ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("welcome page/home page"),
            GestureDetector(
              onTap: (){
                FirebaseAuth auth=FirebaseAuth.instance;
                auth.signOut();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>Login_Page(),));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                //  color: Colors.red,
                padding: EdgeInsets.all(20.0),
                height: 40.0,
                width: 100.0,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: ListView(

                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                          elevation: 10.0,

                      child:Center(child: Text('Start your journey with frontend')),
                    //  color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    elevation: 10.0,
                      child: Center(child: Text('Uncover the mistery behind with learning backend')),
                      //color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                     // width: 200.0,
                      child: Center(child: Text('Start making full stack projects')),
                      //color: Colors.green,
                    ),
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


