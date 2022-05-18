import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseHelper{
  static final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  static final FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;
}