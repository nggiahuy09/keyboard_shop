import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
final FirebaseFirestore storeInstance = FirebaseFirestore.instance;
final User? user = authInstance.currentUser;
final userUid = user!.uid;

const String USERS = 'users';
