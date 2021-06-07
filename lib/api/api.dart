import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  blogList(int page) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://tdaacademy.in/tda_app/api/caffair?page=' + page.toString();
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
  }

  login(data) async {
    var fullUrl = 'https://confidenceeducare.com/nits-system-api/login';
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  Register(data) async {
    var fullUrl = 'https://confidenceeducare.com/api/user/registration';
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  sendOTP() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/user/send-otp';
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  verifyOTP(otp) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/user/verify-otp?otp=' + otp;

    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  streamSelection() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/stream-selection';
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  courseSelection() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/course-selection';
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  subjectSelection(standard_id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/app/user-app-details?standard_id=' +
            standard_id.toString();
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  chaptersList(subject_id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/app/chapters-list?subject_id=' +
            subject_id.toString();
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  topicsList(chapter_id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/app/topics-list?chapter_id=' +
            chapter_id.toString();
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  eNotesList(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/study-materials-list';
    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  studiedMaterial(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/studied/' + data;
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  getInstitute() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/user-institute';
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  moreSubjectsPrice(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/more-subject/' + data;
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  subjectPricing(subject_id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var fullUrl = 'https://confidenceeducare.com/api/app/subject/' +
        subject_id.toString();
    ;
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  timerList(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/app/show-timer-bookmark/' + id;

    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  getProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/user-profile';
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  submitScratchCard(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/redeem-scratch-card';
    return await http.post(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  getDiscount(couponCode) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/get-discount/' + couponCode;
    return await http.get(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  beforePayment(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl =
        'https://confidenceeducare.com/api/app/before-transaction' + data;
    return await http.post(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  progress(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/progress-count';
    return await http.post(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  performance() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/student/marks/obtain';
    return await http.post(Uri.parse(fullUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  takeTest(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = 'https://confidenceeducare.com/api/app/take-test';
    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + localStorage.getString('access_token')!
    });
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getHeaders() => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + _access_token()
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  _access_token() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    return await token;
  }
}
