import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessageing = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessageing.requestPermission();

    final fToken = await _firebaseMessageing.getToken();

    print("token : $fToken");
  }
}
