import 'package:flutter/material.dart';
import 'config/environment.dart';
import 'app.dart';

void main() {
  AppConfig(
    environment: Environment.demo,
    appName: 'ITE Store Demo',
    baseUrl: 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/demo/',
    enableCart: false, // VERY IMPORTANT: Cart is disabled in Demo!
    logoPath: 'assets/images/demo_logo.png',
  );
  runApp(const MyApp());
}