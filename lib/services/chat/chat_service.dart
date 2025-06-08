import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/models/message.dart';
import 'package:message_app/services/auth/auth_services.dart';

class ChatService {
  // get instance of firestore and firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices();

  // fetch users current name
  Future<String> fetchUsersCurrentName() async {
    final AuthServices authServices = AuthServices();
    final name = await authServices.getCurrentUserName();
    return name;
  }

  // fetch users userdbid
  Future<String> fetchUserDbId() async {
    final AuthServices authServices = AuthServices();
    String userDbId = await authServices.getUserDBId(authServices.getCurrentUser()!.uid);
    return userDbId;
  }


  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current users info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    String name = await fetchUsersCurrentName();

    // create a message
    Message newMessage = Message(
      senderId: currentUserId,
      senderName: name,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct a chat room id for two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
      .collection("chat_rooms")
      .doc(chatRoomId)
      .collection("messages")
      .add(newMessage.toMap());
  }

  // recieve message
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
      .collection("chat_rooms")
      .doc(chatRoomId)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
  }

  // add user to people firestore by using email
  Future<void> addUserToPeopleByEmail(String emailToAdd) async {
      // Step 1: Get current user's userDBId
      final currentUserId = _firebaseAuth.currentUser!.uid;
      String currentUserDbId = await _authServices.getUserDBId(currentUserId);
      // Step 2: Search for the user by email
      final querySnapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: emailToAdd)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("docs not found");
      }

      final userToAdd = querySnapshot.docs.first.data();

      // Optional: Check if already exists (if you want to prevent duplicates)
      final peopleRef = _firestore
          .collection('users_data')
          .doc(currentUserDbId)
          .collection('people');

      final existing = await peopleRef
          .where('uid', isEqualTo: userToAdd['uid'])
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        throw Exception("Error: user already exists");
      }

      // Step 3: Add the user to the "people" subcollection
      await peopleRef.add({
        'name': userToAdd['name'],
        'email': userToAdd['email'],
        'uid': userToAdd['uid'],
        'userDbId': userToAdd['userDbId'],
      });
  }

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() async* {
  final String userDbId = await fetchUserDbId();

  yield* _firestore
      .collection("users_data")
      .doc(userDbId)
      .collection("people")
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
  }
}
