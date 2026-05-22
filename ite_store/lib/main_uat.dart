import 'package:flutter/material.dart';
import 'config/environment.dart';
import 'app.dart';

void main() {
  AppConfig(
    environment: Environment.uat,
    appName: 'ITE Store Test',
    baseUrl: 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/uat/',
    enableCart: true,
  );
  runApp(const MyApp());
}