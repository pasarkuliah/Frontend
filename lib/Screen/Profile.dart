import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  void getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      username =
          sharedPreferences.getString('username') ?? 'failed to get username';
    });
  }

  @override
  Widget build(BuildContext context) {
    var styleFrom = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      minimumSize: Size(200, 50), // Width and height of the button
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/images/Logo_2.png', // Replace with actual logo asset path
              height: 100,
            ),
          ),
          SizedBox(height: 40),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
                'assets/images/profilee.jpg'), // Replace with actual user profile image asset path
          ),
          SizedBox(height: 20),
          Text(
            '${username}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Navigator.of(context)
                  .pushNamed("/login"); // Add logout functionality
            },
            style: styleFrom,
            child: Text('Logout',
                style:
                    TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
          ),
        ],
      ),
    );
  }
}
