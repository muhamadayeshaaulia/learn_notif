import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String _message = "No message received yet, waiting...";
  @override
void initState() {
super.initState();
setupFCM();
}
Future<void> setupFCM() async {
print("Setting up Firebase Cloud Messaging...");
final messaging = FirebaseMessaging.instance;
await messaging.requestPermission();
String? token = await messaging.getToken();
print("TOKEN SAYA: $token");
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
if (message.notification != null) {
setState(() {
_message = "${message.notification!.title}: ${message.notification!.body}";});
}
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
