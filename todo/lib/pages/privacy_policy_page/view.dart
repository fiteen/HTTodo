import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'state.dart';

Widget buildView(PrivacyPolicyPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black)
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black12),
        brightness: Brightness.light,
      ),
      body: Markdown(data: state.privacyPolicy),
    );
}