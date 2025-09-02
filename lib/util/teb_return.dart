// ignore: depend_on_referenced_packages
import 'package:http/http.dart';

enum TebReturnType { error, sucess, info }

class TebReturn {
  final TebReturnType returnType;
  final String message;
  final String returnCode;
  final Object? object;

  TebReturn({required this.returnType, required this.message, this.returnCode = '0', this.object});

  static TebReturn get unauthorizedError {
    return TebReturn(
      returnType: TebReturnType.error,
      message: 'Sem autorização de acesso',
      returnCode: '401',
    );
  }

  static TebReturn error(String message) {
    return TebReturn(returnType: TebReturnType.error, message: message);
  }

  static TebReturn get offline {
    return TebReturn(
      returnType: TebReturnType.error,
      message: 'Sem conexão com internet',
      returnCode: '0',
    );
  }

  static TebReturn? httpResponseError({required Response response}) {
    if (response.statusCode >= 400) {
      return TebReturn(
        returnType: TebReturnType.error,
        message: 'Erro HTTP',
        returnCode: response.statusCode.toString(),
      );
    }

    if (response.body == 'null') {
      return TebReturn(returnType: TebReturnType.error, message: 'Sem retorno do Firebase');
    }

    return null;
  }

  static TebReturn authSignUpError(String error) {
    Map<String, String> authErrors = {
      'EMAIL_EXISTS': 'E-mail já foi cadastrado',
      'OPERATION_NOT_ALLOWED': 'Erro interno, acesso por e-mail e senha desativado',
      'USER_DISABLED': 'Usuário desativado',
      'INVALID_PASSWORD': 'Senha inválida',
      'INVALID_EMAIL': 'E-mail inválido',
      'EMAIL_NOT_FOUND': 'E-mail não encontrado',
      'weak-password': 'Senha inválida - muito fraca',
      'operation-not-allowed': 'Operação não permitida',
      'invalid-email': 'E-mail inválido',
      'user-disabled': 'Usuário desativado',
      'user-not-found': 'Usuário não encontrado',
      'email-already-in-use': 'Este e-mail não pode ser usado',
      'wrong-password': 'Senha incorreta',
      'invalid-credential': 'Usuário ou senha inválidos',
      'invalid-login-credentials': 'Usuário ou senha inválidos',
    };
    if (authErrors[error] == null) {
      return TebReturn(returnType: TebReturnType.error, message: error);
    } else {
      return TebReturn(returnType: TebReturnType.error, message: authErrors[error] ?? '');
    }
  }

  static TebReturn changeUserError(String error) {
    Map<String, String> authErrors = {
      'EMAIL_EXISTS': 'O e-mail informado já está em uso',
      'INVALID_ID_TOKEN': 'Erro interno, token inválido',
      'WEAK_PASSWORD': 'A senha deve ter 6 ou mais caracteres',
    };
    if (authErrors[error] == null) {
      return TebReturn(returnType: TebReturnType.error, message: 'Erro não tratado: $error');
    } else {
      return TebReturn(returnType: TebReturnType.error, message: authErrors[error] ?? '');
    }
  }

  static TebReturn get sucess {
    return TebReturn(returnType: TebReturnType.sucess, message: 'Sucesso');
  }
}
