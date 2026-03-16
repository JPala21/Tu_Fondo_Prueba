import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/widgets/button_mode_color.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/home/controllers/home_provider.dart';
import 'package:tu_fondo/modules/home/widgets/fondo_card.dart';

class InversionListView extends StatelessWidget {
  const InversionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
                          // Tu factory personalizado
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
                              return FondoCard(
                                imageUrl: fondo.imageUrl,
                                nombreFondo: fondo.name,
                                montoMinimo: fondo.minMoney,
                                onInvertirPressed: () => print("Invertir"),
                              );
                            }, childCount: provider.list.length),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: responsive.isMobile
                                      ? 0.72
                                      : 0.85,
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
