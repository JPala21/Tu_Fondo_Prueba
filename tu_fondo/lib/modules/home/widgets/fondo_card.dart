import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/widgets/custom_button.dart';

class FondoCard extends StatelessWidget {
  final String imageUrl;
  final String nombreFondo;
  final int montoMinimo;
  final VoidCallback onInvertirPressed;
  final Color buttonColor;
  final String buttonText; // <-- agregar propiedad

  const FondoCard({
    super.key,
    required this.imageUrl,
    required this.nombreFondo,
    required this.montoMinimo,
    required this.onInvertirPressed,
    required this.buttonColor,
    required this.buttonText, // <-- recibir en constructor
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return ResponsiveBuilder(
      builder: (context, responsive) {
        final double imageHeight = responsive.hp(0.12);
        final double titleSize = responsive.scale(15);
        final double subtitleSize = responsive.scale(11);
        final double amountSize = responsive.scale(14);

        return Container(
          height: responsive.hp(0.25),
          padding: EdgeInsets.all(responsive.wp(0.03)),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.blueGrey.withAlpha(50)),
            boxShadow: [
              BoxShadow(
                color: colors.onSurface.withAlpha(10),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: imageHeight,
                    color: isDark
                        ? colors.onError
                        : colors.onSurface.withAlpha(10),
                    child: Icon(
                      Icons.insert_chart_outlined,
                      color: colors.primary,
                      size: responsive.scale(20),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: imageHeight,
                    color: isDark
                        ? colors.onError
                        : colors.onSurface.withAlpha(40),
                    child: Icon(Icons.error_outline, color: colors.error),
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  nombreFondo,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                    height: 1.1,
                  ),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                ),
              ),

              Text(
                'Monto mínimo',
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: colors.onSurface.withAlpha(100),
                ),
              ),

              Text(
                '\$ ${montoMinimo.toString()}',
                style: TextStyle(
                  fontSize: amountSize,
                  fontWeight: FontWeight.bold,
                  color: colors.secondary,
                ),
              ),

              CustomButton.primary(
                text: buttonText, // <-- usar el texto dinámico
                onPressed: onInvertirPressed,
                width: double.infinity,
                height: 25,
              ),
            ],
          ),
        );
      },
    );
  }
}
