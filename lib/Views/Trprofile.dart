import 'package:finalproject/Models/Client.dart';
import 'package:finalproject/Utils/ClientConfig.dart';
import 'package:finalproject/Utils/utils.dart';
import 'package:finalproject/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:finalproject/Views/HomePage.dart';


class Trprofile extends StatefulWidget {
  const Trprofile({super.key, required this.title});

  final String title;

  @override
  State<Trprofile> createState() => TrprofilePageState();
}
class RegisterscreenPageState extends State<RegisterScreen> {