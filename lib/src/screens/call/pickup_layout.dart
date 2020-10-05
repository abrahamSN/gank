import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pickup_page.dart';

import '../../models/call_model.dart';
import '../../repositories/repositories.dart';

class PickupLayout extends StatelessWidget {
  final CallRepository callRepository = CallRepository();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
  }
}
