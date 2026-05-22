import 'package:flutter/material.dart';
import 'config/environment.dart';
import 'app.dart';

void main() {

  AppConfig(
    environment: Environment.dev,
    appName: 'ITE Store Dev',
    baseUrl: 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/dev/',
    enableCart: true,
    logoPath: 'assets/images/dev_logo.png',
  );
  runApp(const MyApp());
}