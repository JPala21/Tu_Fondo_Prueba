import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
import 'package:tu_fondo/global/widgets/button_mode_color.dart';
import 'package:tu_fondo/global/widgets/custom_button_icon.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/home/controllers/home_provider.dart';
import 'package:tu_fondo/modules/home/models/fondo_model.dart';
import 'package:tu_fondo/modules/home/widgets/fondo_card.dart';
import 'package:tu_fondo/modules/home/widgets/notification_selector.dart';
import 'package:tu_fondo/modules/login/models/user_model.dart';

class InversionListView extends StatelessWidget {
  const InversionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sessionProvider = context.read<SessionProvider>();
    final isLogged = sessionProvider.isLogged;
    final user = sessionProvider.user;

    return ChangeNotifierProvider(
      create: (context) => HomeProvider()..filterFondos(''),
      child: ResponsiveBuilder(
        builder: (context, responsive) {
          int crossAxisCount = responsive.isMobile
              ? 2
              : (responsive.isTablet ? 3 : 4);

          return Consumer<HomeProvider>(
            builder: (context, provider, child) => Scaffold(
              backgroundColor: colors.surface,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: responsive.hp(0.2),
                    pinned: true,
                    actions: [
                      ButtonModeColor(
                        height: responsive.hp(0.3),
                        width: responsive.wp(0.1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButtonIcon.loginOrLogout(
                          context: context,
                          radius: 30,
                          iconSize: 25,
                        ),
                      ),
                    ],
                    backgroundColor: colors.surface,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Fondos de Inversión',
                        style: TextStyle(
                          color: colors.onSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.scale(16),
                        ),
                      ),
                      centerTitle: true,
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors.primary,
                              colors.primary.withAlpha(180),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Filtro de búsqueda
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverFilterHeaderDelegate(
                      height: responsive.hp(0.1),
                      child: Container(
                        width: double.infinity,
                        height: responsive.hp(0.3),
                        color: colors.surface,
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(0.04),
                          vertical: 10,
                        ),
                        child: CustomTextField.find(
                          label: 'Buscar fondo...',
                          controller: provider.controllerFind,
                          onChanged: provider.filterFondos,
                          onToggle: () {
                            provider.controllerFind.clear();
                            provider.filterFondos('');
                          },
                        ),
                      ),
                    ),
                  ),

                  // Grid de fondos
                  SliverPadding(
                    padding: EdgeInsets.all(responsive.wp(0.03)),
                    sliver: provider.list.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Text("No se encontraron fondos"),
                            ),
                          )
                        : SliverGrid(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final fondo = provider.list[index];
                              final isInvested = provider.isInvested(fondo.id);

                              return FondoCard(
                                imageUrl: fondo.imageUrl,
                                nombreFondo: fondo.name,
                                montoMinimo: fondo.minMoney,
                                buttonColor: isInvested
                                    ? Colors.redAccent
                                    : colors.primary,
                                buttonText: isInvested
                                    ? "Cancelar Inversión"
                                    : "Invertir",
                                onInvertirPressed: () async {
                                  if (!isLogged || user == null) {
                                    context.push('/login');
                                    return;
                                  }

                                  if (isInvested) {
                                    await provider.cancelInvestment(
                                      context: context,
                                      fondo: fondo,
                                      user: user,
                                    );
                                  } else {
                                    await _showInvestmentDialog(
                                      context,
                                      fondo,
                                      user,
                                    );
                                  }
                                },
                              );
                            }, childCount: provider.list.length),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: responsive.isMobile
                                      ? 0.72
                                      : 0.85,
                                  crossAxisCount: crossAxisCount,
                                ),
                          ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: responsive.hp(0.2)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showInvestmentDialog(
    BuildContext context,
    FondoModel fondo,
    User user,
  ) async {
    bool isSms = true;
    final provider = context.read<HomeProvider>();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("Invertir en ${fondo.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Monto a invertir: \$${fondo.minMoney}"),
              const SizedBox(height: 15),
              NotificationSelector(
                isSms: isSms,
                onChanged: (val) => setState(() => isSms = val),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text("Confirmar"),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      await provider.investMoney(
        context: context,
        fondo: fondo,
        user: user,
        isSms: isSms,
      );
    }
  }
}

class _SliverFilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverFilterHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverFilterHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}
