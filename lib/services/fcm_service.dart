// create FCM service
import 'dart:convert';
import 'package:http/http.dart' as http;

class FCMService{
  static const String FCMAPI = "AAAAufOxYZQ:APA91bH9oAXeqKO8L2rwwxy_NDImingRxawlLyJRB4aQys18yzPYLL7VAT3G7nzgzbrf5JN4SvthjAyp2SrjiibtM4EfeOV4nQ1yodQOgIpMVmEMEtzL2_zHqdgj2uFvBPTQznxCp4UF";

  static String makePayLoadWithToken(String? token,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'to': token,
      'data': data,
      'notification': notification,
    });
  }

  static String makePayLoadWithTopic(String? topic,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'topic': topic,
      'data': data,
      'notification': notification,
    });
  }

  static Future<void> sendPushMessage(String? token,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$FCMAPI'
        },
        body: makePayLoadWithToken(token, data, notification),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
