import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ============================================= TÀI KHOẢN QUẢN LÝ ============================================

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String? role) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveUserRole(credential.user!.uid, email, role);
      return credential.user;
    } catch (e) {
      print('Lỗi không xác định: $e');
    }
    return null;
  }

  Future<void> saveUserRole(String uid, String email, String? role) async {
    try {
      await _firestore.collection('users_quan_ly').doc(uid).set({
        'role': role,
        'email': email,
      });
    } catch (e) {
      print('Lỗi khi lưu chức vụ người dùng: $e');
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users_quan_ly').doc(uid).get();
      return snapshot['role'];
    } catch (e) {
      print("Lỗi user chức vụ: $e");
      return null;
    }
  }

// ============================================= TÀI KHOẢN KHÁCH HÀNG ============================================
  Future<User?> signUpWithEmailAndPassword_Guest(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveUserRole_Guest(credential.user!.uid, email);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Lỗi không xác định: $e');
    }
    return null;
  }

  Future<void> saveUserRole_Guest(String uid, String? email) async {
    try {
      await _firestore.collection('users_guest').doc(uid).set({
        'uid': uid,
        'email': email,
      });
    } catch (e) {
      print('Lỗi khi lưu chức vụ người dùng: $e');
    }
  }

  Future<String?> getUserRole_Guest(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users_guest').doc(uid).get();
      return snapshot['role'];
    } catch (e) {
      print("Lỗi user chức vụ: $e");
      return null;
    }
  }

//  Future<void> saveDonHang(String userId, String hoVaTen, String sdt, String diaChi, String paymentMethod, int giaTien, int soLuong, String maSP) async {
//     try {
//       await FirebaseFirestore.instance.collection('users_guest').doc(userId).set({
//         'hoVaTen': hoVaTen,
//         'sdt': sdt,
//         'diaChi': diaChi,
//         'paymentMethod': paymentMethod,
//         'orders': FieldValue.arrayUnion([{
//           'giaTien': giaTien,
//           'soLuong': soLuong,
//           'maSP': maSP,
//         }])
//       });
//     } catch (e) {
//       throw e;
//     }
//   }

Future<void> saveDonHang(
      String userId,
      String hoVaTen,
      String sdt,
      String diaChi,
      String paymentMethod,
      int giaTien,
      int soLuong,
      String maSP,
      String email) async {
    await _firestore.collection('users_guest').doc(userId).collection('orders').add({
      'hoVaTen': hoVaTen,
      'sdt': sdt,
      'diaChi': diaChi,
      'paymentMethod': paymentMethod,
      'giaTien': giaTien,
      'soLuong': soLuong,
      'maSP': maSP,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

      }
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print('Lỗi không xác định: $e');
    }
    return null;
  }
}
