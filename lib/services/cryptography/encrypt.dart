import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptDecrypt {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptData(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted;
  }

  static decryptData(text) {
    return encrypter.decrypt(text,iv: iv);
  }
}
