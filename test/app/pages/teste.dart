import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  final StreamController<bool> formValidController = StreamController<bool>();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  testWidgets('Botão de login habilita quando o formulário é válido', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: const Key('campoEmail'),
                  onChanged: (value) {
                    if (isValidEmail(value)) {
                      formValidController.add(true);
                    } else {
                      formValidController.add(false);
                    }
                  },
                  validator: (value) {
                    if (value == null || !isValidEmail(value)) {
                      return 'Por favor, insira um e-mail válido.';
                    }
                    return null;
                  },
                ),
                StreamBuilder<bool>(
                  stream: formValidController.stream,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      key: const Key('botaoLogin'),
                      onPressed: snapshot.data == true ? () {} : null,
                      child: const Text('Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /// Verifica se o botão está inicialmente desabilitado
    var botaoLogin = widgetTester.widget<ElevatedButton>(find.byKey(const Key('botaoLogin')));
    expect(botaoLogin.onPressed, isNull);

    /// Insere um e-mail válido
    await widgetTester.enterText(find.byKey(const Key('campoEmail')), 'dener@deneroliveira.com.br');

    /// Reconstrói o widget após a entrada do texto
    await widgetTester.pumpAndSettle();

    botaoLogin = widgetTester.widget<ElevatedButton>(find.byKey(const Key('botaoLogin')));

    /// Verifica se o botão está habilitado após inserir um e-mail válido
    expect(botaoLogin.onPressed, isNotNull);
  });
}
