import 'package:google_sign_in/google_sign_in.dart';
import 'package:agro_inteli_colombia/dominan/entities/user.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);

  // ESTADO DEL USUARIO
  //Stream<User?> get user => _auth.authStateChange();

  // USUARIO ACTUAL - DATOS
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Stream<GoogleSignInAccount?> get onCurrentUserChanged =>
      _googleSignIn.onCurrentUserChanged;

  // INICIA SESION CON GOOGLE
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      return googleUser;
    } catch (error) {
      print('Error al iniciar sesión con Google: $error');
      return null;
    }
  }

  // CIERRE SESION
  Future<void> signOut() => _googleSignIn.signOut();

  // VERIFICA SI ESTA CONECTADO

  Future<bool> isSignIn() => _googleSignIn.isSignedIn();
}
