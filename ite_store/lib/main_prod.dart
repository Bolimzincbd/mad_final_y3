import 'package:flutter/material.dart';
import 'config/environment.dart';
import 'app.dart';

void main() {
  AppConfig(
    environment: Environment.prod,
    appName: 'ITE Store',
    baseUrl: 'https://smlp-pub.s3.ap-southeast-1.amazonaws.com/ite-store/prod/',
    enableCart: true,
  );
  runApp(const MyApp());
}