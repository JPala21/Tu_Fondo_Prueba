import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/modules/admin/controllers/admin_provider.dart';
import 'package:tu_fondo/modules/admin/widgets/admin_button.dart';

class AdminFondosView extends StatelessWidget {
  const AdminFondosView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final bool isDark = theme.brightness == Brightness.dark;

    return ChangeNotifierProvider(
      create: (_) => AdminProvider()..filterFondos(''),
      builder: (context, _) => ResponsiveBuilder(
        builder: (context, responsive) {
          final double imgSize = responsive.scale(50);

          return Consumer<AdminProvider>(
            builder: (context, provider, _) => Scaffold(
              backgroundColor: colors.surfaceContainerLow,
              appBar: AppBar(
                title: const Text(
                  "Gestión de Fondos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: colors.surface,
                elevation: 0,
              ),
              floatingActionButton: AdminButton(
                text: "Nuevo Fondo",
                icon: Icons.add_circle_outline,
                onPressed: () => provider.showEditor(context, null),
              ),

              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.wp(0.04)),
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: responsive.hp(0.02),
                    bottom: responsive.hp(0.1),
                  ),
                  itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    final fondo = provider.list[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: responsive.hp(0.015)),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: colors.shadow.withAlpha(5),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: fondo.imageUrl,
                            width: imgSize,
                            height: imgSize,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: isDark
                                  ? colors.onError.withAlpha(20)
                                  : colors.onSurface.withAlpha(10),
                              child: Icon(
                                Icons.insert_chart_outlined,
                                color: colors.primary,
                                size: responsive.scale(20),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: isDark
                                  ? colors.onError.withAlpha(20)
                                  : colors.onSurface.withAlpha(40),
                              child: Icon(
                                Icons.error_outline,
                                color: colors.error,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          fondo.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Inversión mín: \$${fondo.minMoney}",
                          style: TextStyle(
                            color: colors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildIconButton(
                              Icons.edit_rounded,
                              colors.primary,
                              () => provider.showEditor(context, fondo),
                            ),
                            const SizedBox(width: 8),
                            _buildIconButton(
                              Icons.delete_outline_rounded,
                              Colors.redAccent,
                              () => provider.deleteFondo(fondo.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
