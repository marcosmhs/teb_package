import 'package:encrypt/encrypt.dart';

class TebAesEncrypt {
  late Key _ivKey;
  late IV _fixedIVKey;

  TebAesEncrypt({required String ivKey, required String fixedIvKey}) {
    if (ivKey.isNotEmpty) _ivKey = Key.fromUtf8(ivKey);
    if (fixedIvKey.isNotEmpty) _fixedIVKey = IV.fromUtf8(fixedIvKey);
  }

  // É recomendado gerar um novo IV para cada criptografia.
  // O IV deve ter 16 bytes para AES.
  IV _gerarIV() {
    return IV.fromSecureRandom(16); // Gera um IV aleatório seguro de 16 bytes
  }

  /// Criptografa os dados fornecidos utilizando o algoritmo especificado.
  ///
  /// Este método recebe uma string de entrada e retorna uma versão criptografada
  /// da mesma. O algoritmo de criptografia utilizado pode variar conforme a
  /// implementação. Certifique-se de que a chave e os parâmetros necessários
  /// estejam corretamente configurados antes de chamar este método.
  ///
  /// Parâmetros:
  /// - [input]: A string que será criptografada.
  ///
  /// Retorna:
  /// Uma string representando os dados criptografados.
  ///
  /// Lança:
  /// Pode lançar uma exceção se ocorrer um erro durante o processo de criptografia.
  String aesEncryp({required String text}) {
    if (text.isEmpty) return '';

    final iv = _gerarIV();
    // Usando AES no modo CTR (Counter Mode). Outras opções incluem CBC.
    // CTR é geralmente preferido por sua simplicidade e capacidade de paralelização.
    final encrypter = Encrypter(AES(_ivKey, mode: AESMode.ctr, padding: null));

    final encrypted = encrypter.encrypt(text, iv: iv);

    // Para armazenar ou transmitir, combine o IV e o texto cifrado.
    // Uma forma comum é concatenar IV (em base64) + separador + texto cifrado (em base64).
    // Ou retornar um objeto/mapa com ambos.
    // Aqui, vamos retornar IV.base64:encrypted.base64
    return '${iv.base64}:${encrypted.base64}';
  }

  /// Descriptografa os dados fornecidos e retorna um mapa contendo os resultados.
  ///
  /// O mapa retornado possui os seguintes elementos:
  /// - `'message'` (`String?`): Mensagem de erro detalhando o motivo da falha, caso a operação não seja bem-sucedida; caso contrário, será `null`.
  /// - `'success'` (`bool`): Indica se a operação de descriptografia foi bem-sucedida.
  /// - `'decryptedText'` (`String?`): Contém os dados descriptografados, caso a operação tenha sucesso; caso contrário, será ''.///
  ///
  /// Retorna:
  ///   Um `Map<String, dynamic>` com as chaves `'success'`, `'data'` e `'error'`, detalhando o resultado da operação de descriptografia.
  Map<String, dynamic> aesDecrypt({required String encryptedText}) {
    if (encryptedText.isEmpty) return {'message': 'Encrypt text empty', 'sucess': false, 'decryptedText': ''};

    try {
      final parts = encryptedText.split(':');
      if (parts.length != 2) {
        return {'message': 'Invalid text format', 'sucess': false, 'decryptedText': ''};
      }

      final iv = IV.fromBase64(parts[0]);
      final textPart = parts[1];

      final encrypter = Encrypter(AES(_ivKey, mode: AESMode.ctr, padding: null));

      final decryptedText = encrypter.decrypt(Encrypted.fromBase64(textPart), iv: iv);
      return {'message': 'Sucess', 'sucess': true, 'decryptedText': decryptedText};
    } catch (e) {
      return {'message': e.toString(), 'sucess': false, 'decryptedText': ''};
    }
  }

  // Para campos buscáveis (menos seguro devido à natureza determinística)
  String encryp({required String text}) {
    if (text.isEmpty) return '';
    // Normalização: Converta para minúsculas ou outra forma canônica ANTES de criptografar
    // para garantir que buscas como "email@ex.com" e "Email@ex.com" funcionem.
    final textoNormalizado = text.toLowerCase(); // Exemplo de normalização

    final encrypter = Encrypter(AES(_ivKey, mode: AESMode.ctr, padding: null));
    final encrypted = encrypter.encrypt(textoNormalizado, iv: _fixedIVKey);
    // Como o IV é fixo e conhecido, não precisamos armazená-lo junto com o texto cifrado.
    return encrypted.base64;
  }

  Map<String, dynamic> decrypt({required String encryptedText}) {
    if (encryptedText.isEmpty) return {'message': 'Encrypt text empty', 'sucess': false, 'decryptedText': ''};
    try {
      final encrypter = Encrypter(AES(_ivKey, mode: AESMode.ctr, padding: null));
      // Usamos o mesmo _fixedIV para descriptografar
      final decryptedText = encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: _fixedIVKey);
      return {'message': 'Sucess', 'sucess': true, 'decryptedText': decryptedText};
    } catch (e) {
      return {'message': e.toString(), 'sucess': false, 'decryptedText': ''};
    }
  }
}
