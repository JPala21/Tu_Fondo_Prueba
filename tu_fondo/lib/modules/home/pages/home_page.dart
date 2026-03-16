import 'package:flutter/material.dart';
import 'package:tu_fondo/config/responsive_builder.dart';
import 'package:tu_fondo/global/widgets/custom_text_fiel.dart';
import 'package:tu_fondo/modules/home/widgets/fondo_card.dart';

final List<Map<String, dynamic>> _allFondos = [
  {
    'imageUrl':
        'https://image.api.playstation.com/vulcan/ap/rnd/202106/1716/09r9Wj4C9A0Y9R1X0U0W1H4B.png',
    'nombre': 'Fondo de Crecimiento Tecnológico ACCES FUND',
    'montoMinimo': 500,
  },
  {
    'imageUrl':
        'https://i.blogs.es/e32e91/the-last-of-us-part-ii-naughty-dog-playstation-4_4081041-3840x2160/1366_2000.jpeg',
    'nombre': 'Fondo de Energía Sostenible VERDE INVEST',
    'montoMinimo': 250,
  },
  {
    'imageUrl':
        'https://s1.eestatic.com/2023/12/07/actualidad/815429112_238241477_1706x960.jpg',
    'nombre': 'Fondo de Mercados Emergentes GLOBAL OPPORTUNITY',
    'montoMinimo': 1000,
  },
  {
    'imageUrl':
        'https://phantom-marca.unidadeditorial.es/6d41829e0839e3f1604a520d3674d8ac/resize/828/f/jpg/assets/multimedia/imagenes/2023/08/21/16926017267073.jpg',
    'nombre': 'Fondo de Crecimiento Tecnológico ACCES FUND 2',
    'montoMinimo': 500,
  },
  {
    'imageUrl':
        'https://static1.squarespace.com/static/54b794e5e4b0965377f3e841/54b7ae64e4b0cc6a5285741f/60d4b96615b364177d33d1b8/1624898142345/LOU2_EllieW_03_final.jpg',
    'nombre': 'Fondo de Energía Sostenible VERDE INVEST 2',
    'montoMinimo': 250,
  },
  {
    'imageUrl': 'https://w.wallhaven.cc/full/2e/wallhaven-2exovg.png',
    'nombre': 'Fondo de Mercados Emergentes GLOBAL OPPORTUNITY 2',
    'montoMinimo': 1000,
  },
];

class InversionListView extends StatefulWidget {
  const InversionListView({super.key});

  @override
  State<InversionListView> createState() => _InversionListViewState();
}

class _InversionListViewState extends State<InversionListView> {
  final TextEditingController _filterController = TextEditingController();
  // 1. Inicializa con la lista completa directamente o en el initState
  List<Map<String, dynamic>> _filteredFondos = [];

  @override
  void initState() {
    super.initState();
    _filteredFondos = _allFondos; // Asegúrate de que _allFondos sea accesible
  }

  void _filterFondos(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFondos = _allFondos;
      } else {
        _filteredFondos = _allFondos
            .where(
              (fondo) =>
                  fondo['nombre'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ResponsiveBuilder(
      builder: (context, responsive) {
        // Lógica de columnas
        int crossAxisCount = responsive.isMobile
            ? 2
            : (responsive.isTablet ? 3 : 4);

        return Scaffold(
          backgroundColor: colors.surface,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: responsive.hp(0.2),
                pinned: true,
                backgroundColor: colors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Fondos de Inversión',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.scale(16),
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.primary, colors.primary.withAlpha(180)],
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
                      controller: _filterController,
                      onChanged: _filterFondos,
                      onToggle: () {
                        _filterController.clear();
                        _filterFondos('');
                      },
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(responsive.wp(0.03)),
                sliver: _filteredFondos.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(child: Text("No se encontraron fondos")),
                      )
                    : SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final fondo = _filteredFondos[index];
                          return FondoCard(
                            imageUrl: fondo['imageUrl'],
                            nombreFondo: fondo['nombre'],
                            montoMinimo: fondo['montoMinimo'],
                            onInvertirPressed: () => print("Invertir"),
                          );
                        }, childCount: _filteredFondos.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: responsive.isMobile ? 0.72 : 0.85,
                        ),
                      ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: responsive.hp(0.2))),
            ],
          ),
        );
      },
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
