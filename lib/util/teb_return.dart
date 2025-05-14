// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

enum TebReturnType { error, sucess, info }

class TebCustomReturn {
  final TebReturnType returnType;
  final String message;
  final String returnCode;
  final Object? object;

  TebCustomReturn({
    required this.returnType,
    required this.message,
    this.returnCode = '0',
    this.object,
  });

  static TebCustomReturn get unauthorizedError {
    return TebCustomReturn(
      returnType: TebReturnType.error,
      message: 'Sem autorização de acesso',
      returnCode: '401',
    );
  }

  static TebCustomReturn error(String message) {
    return TebCustomReturn(
      returnType: TebReturnType.error,
      message: message,
    );
  }

  static TebCustomReturn get offline {
    return TebCustomReturn(
      returnType: TebReturnType.error,
      message: 'Sem conexão com internet',
      returnCode: '0',
    );
  }

  static TebCustomReturn? httpResponseError({required Response response}) {
    if (response.statusCode >= 400) {
      return TebCustomReturn(
        returnType: TebReturnType.error,
        message: 'Erro HTTP',
        returnCode: response.statusCode.toString(),
      );
    }

    if (response.body == 'null') {
      return TebCustomReturn(returnType: TebReturnType.error, message: 'Sem retorno do Firebase');
    }

    return null;
  }

  static TebCustomReturn authSignUpError(String error) {
    Map<String, String> authErrors = {
      'EMAIL_EXISTS': 'E-mail já foi cadastrado',
      'OPERATION_NOT_ALLOWED': 'Erro interno, acesso por e-mail e senha desativado',
      'USER_DISABLED': 'Usuário desativado',
      'INVALID_PASSWORD': 'Senha inválida',
      'INVALID_EMAIL': 'E-mail inválido',
      'EMAIL_NOT_FOUND': 'E-mail não encontrado',
      'weak-password': 'Senha inválida - muito fraca',
      'email-already-in-use': 'E-mail já foi cadastrado',
      'operation-not-allowed': 'Operação não permitida',
      'invalid-email': 'E-mail inválido',
      'user-disabled': 'Usuário desativado',
      'user-not-found': 'Usuário não encontrado',
      'wrong-password': 'Senha incorreta',
      'invalid-login-credentials': 'Usuário ou senha inválidos'
    };
    if (authErrors[error] == null) {
      return TebCustomReturn(returnType: TebReturnType.error, message: error);
    } else {
      return TebCustomReturn(returnType: TebReturnType.error, message: authErrors[error] ?? '');
    }
  }

  static TebCustomReturn changeUserError(String error) {
    Map<String, String> authErrors = {
      'EMAIL_EXISTS': 'O e-mail informado já está em uso',
      'INVALID_ID_TOKEN': 'Erro interno, token inválido',
      'WEAK_PASSWORD': 'A senha deve ter 6 ou mais caracteres',
    };
    if (authErrors[error] == null) {
      return TebCustomReturn(returnType: TebReturnType.error, message: 'Erro não tratado: $error');
    } else {
      return TebCustomReturn(returnType: TebReturnType.error, message: authErrors[error] ?? '');
    }
  }

  static TebCustomReturn get sucess {
    return TebCustomReturn(
      returnType: TebReturnType.sucess,
      message: 'Sucesso',
    );
  }
}
