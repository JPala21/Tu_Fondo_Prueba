import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/utils/validator.dart';
import 'package:tu_fondo/global/widgets/button_mode_color.dart';
import 'package:tu_fondo/global/widgets/custom_avatar.dart';
import 'package:tu_fondo/global/widgets/custom_button.dart';
import 'package:tu_fondo/global/widgets/custom_divider.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/login/controllers/login_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: ResponsiveBuilder(
        builder: (context, responsive) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              ButtonModeColor(
                height: responsive.hp(0.3),
                width: responsive.wp(0.1),
              ),
            ],
          ),
          backgroundColor: colorScheme.onSurface,
          body: Consumer<LoginProvider>(
            builder: (context, provider, _) => Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(responsive.scale(12)),
                child: Card(
                  elevation: 10,
                  shadowColor: colorScheme.primary.withAlpha(77),
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.scale(12),
                      vertical: responsive.scale(10),
                    ),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        spacing: 15,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomAvatar.logo(responsive.scale(50)),

                          Text(
                            "Bienvenido",
                            style: TextStyle(
                              fontSize: responsive.scale(25),
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),

                          Text(
                            "Inicia sesión para continuar",
                            style: TextStyle(
                              fontSize: responsive.scale(14),
                              color: colorScheme.onSurface.withAlpha(0180),
                            ),
                          ),

                          CustomTextField.user(
                            provider.emailController,
                            Validator.email,
                          ),
                          SizedBox(height: responsive.hp(0.01)),
                          CustomTextField.password(
                            controller: provider.passwordController,
                            obscure: provider.obscurePassword,
                            onToggle: provider.updateObscurePassword,
                            validator: Validator.password,
                            label: 'Contraseña',
                          ),
                          SizedBox(height: responsive.hp(0.05)),
                          CustomButton.primary(
                            text: "INICIAR SESIÓN",
                            onPressed: () => provider.findUser(context),
                            width: responsive.wp(1),
                            height: responsive.hp(0.05),
                            fontSize: responsive.scale(14),
                          ),

                          CustomDividerText(
                            text: "o",
                            horizontalPadding: responsive.scale(14),
                            textSize: responsive.scale(14),
                          ),

                          CustomButton.outlined(
                            text: "CREAR CUENTA",
                            onPressed: () {
                              Navigator.pushNamed(context, 'user_registration');
                            },
                            width: responsive.wp(1),
                            height: responsive.hp(0.05),
                            fontSize: responsive.scale(14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
