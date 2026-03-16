import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_fondo/global/utils/validator.dart';
import 'package:tu_fondo/global/widgets/custom_text_button.dart';

void main() {
  // --- GRUPO 1: Lógica de Validadores ---
  group('Validator Suite', () {
    test('required: detecta vacío y espacios', () {
      expect(Validator.required(''), isNotNull);
      expect(Validator.required('   '), isNotNull);
      expect(Validator.required('Contenido'), isNull);
    });

    test('email: formato inválido vs válido', () {
      expect(Validator.email('invalido'), isNotNull);
      expect(Validator.email('test@ejemplo'), isNotNull);
      expect(Validator.email('test@ejemplo.com'), isNull);
    });

    test('numeric: solo permite números', () {
      expect(Validator.numeric('123a'), isNotNull);
      expect(Validator.numeric('abc'), isNotNull);
      expect(Validator.numeric('456'), isNull);
    });

    test('letters: solo permite letras', () {
      expect(Validator.letters('123'), isNotNull);
      expect(Validator.letters('Juan'), isNull);
      expect(Validator.letters('Juan Pérez'), isNull);
    });

    test('equal: contraseñas deben coincidir', () {
      expect(Validator.equal('pass1', 'pass2'), isNotNull);
      expect(Validator.equal('pass1', 'pass1'), isNull);
    });
  });

  // --- GRUPO 2: Componentes (Widgets) ---
  group('CustomTextButton Widget Tests', () {
    testWidgets('Debe mostrar el texto correctamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextButton(text: 'Acción', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Acción'), findsOneWidget);
    });

    testWidgets('Debe disparar el callback al presionar', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextButton(
              text: 'Click',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      expect(tapped, isTrue);
    });

    testWidgets('Factory .recover debe aplicar estilo especial', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextButton.recover('Recuperar', 14.0, () {}),
          ),
        ),
      );

      final Text textWidget = tester.widget(find.byType(Text));
      expect(textWidget.style?.decoration, TextDecoration.underline);
      expect(textWidget.style?.color, Colors.cyan.shade700);
    });
  });
}
