import 'package:flutter/material.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/widgets/custom_button.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';

class AdminFondoSheet extends StatefulWidget {
  final FondoModel? fondo;
  final Function(Map<String, dynamic> data) onPressed;

  const AdminFondoSheet({super.key, this.fondo, required this.onPressed});

  @override
  State<AdminFondoSheet> createState() => _AdminFondoSheetState();
}

class _AdminFondoSheetState extends State<AdminFondoSheet> {
  final nameCtrl = TextEditingController();
  final imageCtrl = TextEditingController();
  final moneyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.fondo != null) {
      nameCtrl.text = widget.fondo!.name;
      imageCtrl.text = widget.fondo!.imageUrl;
      moneyCtrl.text = widget.fondo!.minMoney.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.fondo != null;

    return ResponsiveBuilder(
      builder: (context, responsive) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: responsive.wp(0.05),
            right: responsive.wp(0.05),
            top: responsive.hp(0.02),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? "Editar Fondo" : "Nuevo Fondo",
                style: TextStyle(
                  fontSize: responsive.scale(18),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: responsive.hp(0.02)),

              CustomTextField.all(
                label: "Nombre",
                prefixIcon: const Icon(Icons.badge_outlined),
                controller: nameCtrl,
              ),

              SizedBox(height: responsive.hp(0.015)),

              CustomTextField.all(
                label: "URL Imagen",
                prefixIcon: const Icon(Icons.image_outlined),
                controller: imageCtrl,
              ),

              SizedBox(height: responsive.hp(0.015)),

              CustomTextField.all(
                label: "Inversión mínima",
                prefixIcon: const Icon(Icons.attach_money_outlined),
                controller: moneyCtrl,
                typeInput: TextInputType.number,
              ),

              SizedBox(height: responsive.hp(0.025)),

              SizedBox(
                width: double.infinity,
                child: CustomButton.outlined(
                  onPressed: () {
                    final data = {
                      "name": nameCtrl.text.trim(),
                      "imageUrl": imageCtrl.text.trim(),
                      "minMoney": int.tryParse(moneyCtrl.text) ?? 0,
                    };

                    widget.onPressed(data);

                    Navigator.pop(context);
                  },
                  text: isEdit ? "Actualizar" : "Crear",
                ),
              ),

              SizedBox(height: responsive.hp(0.02)),
            ],
          ),
        );
      },
    );
  }
}
