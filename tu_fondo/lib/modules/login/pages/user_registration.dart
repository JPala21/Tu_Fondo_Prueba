import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/utils/validator.dart';
import 'package:tu_fondo/global/widgets/button_mode_color.dart';
import 'package:tu_fondo/global/widgets/custom_avatar.dart';
import 'package:tu_fondo/global/widgets/custom_button.dart';
import 'package:tu_fondo/global/widgets/custom_divider.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/login/controllers/register_provider.dart';

class UserRegistrationView extends StatelessWidget {
  const UserRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
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
          body: Consumer<RegisterProvider>(
            builder: (context, provider, _) => Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(responsive.scale(12)),
                child: Card(
                  shadowColor: colorScheme.primary.withAlpha(77),
                  color: colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.scale(16),
                      vertical: responsive.scale(14),
                    ),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        spacing: 15,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomAvatar.icon(
                            responsive.scale(30),
                            Icon(Icons.person_add, size: responsive.scale(40),color: Colors.white60,),
                          ),
                          Text(
                            "Crear Cuenta",
                            style: TextStyle(
                              fontSize: responsive.scale(26),
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            "Completa los siguientes datos",
                            style: TextStyle(
                              fontSize: responsive.scale(14),
                              color: colorScheme.onSurface.withAlpha(0180),
                            ),
                          ),

                          CustomTextField.all(
                            label: "Nombre",
                            prefixIcon: Icon(Icons.person),
                            controller: provider.nombreController,
                            validator: Validator.letters,
                          ),

                          CustomTextField.all(
                            label: "Apellido",
                            prefixIcon: Icon(Icons.person_outline),
                            controller: provider.apellidoController,
                            validator: Validator.letters,
                          ),

                          // CÉDULA
                          CustomTextField.all(
                            label: "Cédula",
                            prefixIcon: Icon(Icons.badge),
                            controller: provider.cedulaController,
                            validator: Validator.numeric,
                          ),

                          CustomTextField.all(
                            label: "Correo Electrónico",
                            prefixIcon: Icon(Icons.email),
                            controller: provider.emailController,
                            validator: Validator.email,
                          ),

                          // CONTRASEÑA
                          CustomTextField.password(
                            controller: provider.passwordController,
                            obscure: provider.obscurePassword,
                            onToggle: provider.togglePassword,
                            validator: Validator.password,
                            label: 'Contraseña',
                          ),

                          CustomTextField.password(
                            controller: provider.confirmPasswordController,
                            obscure: provider.obscureConfirmPassword,
                            onToggle: provider.toggleConfirmPassword,
                            validator: (value) => Validator.equal(
                              value,
                              provider.passwordController.text,
                            ),
                            label: "Confirmar Contraseña",
                          ),

                          SizedBox(height: responsive.scale(6)),

                          CustomButton.primary(
                            text: "REGISTRARSE",
                            onPressed: () => provider.send(context),
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
                            text: "YA TENGO UNA CUENTA",
                            onPressed: () => context.pop(context),
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
