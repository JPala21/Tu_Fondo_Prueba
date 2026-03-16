import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_fondo/global/controller/session_provider.dart';
import 'package:tu_fondo/modules/home/controllers/home_provider.dart';
class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    // Obtenemos HomeProvider y SessionProvider
    final homeProvider = context.read<HomeProvider>();
    final sessionProvider = context.read<SessionProvider>();
    final user = sessionProvider.user;

    // Solo si hay usuario
    if (user != null) {
      homeProvider.currentUserId = user.cedula;
      homeProvider.fetchUserTransactions().then((_) {
        setState(() => _loading = false);
      });
    } else {
      _loading = false;
    }
  }

  String formatDate(DateTime? date) {
    final d = date ?? DateTime.now();
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} – ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sessionProvider = context.watch<SessionProvider>();
    final user = sessionProvider.user;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (user == null) {
      return Center(
        child: Text(
          "Debes iniciar sesión para ver tus inversiones",
          style: TextStyle(color: colors.onSurface),
        ),
      );
    }

    final homeProvider = context.watch<HomeProvider>();
    final historial = homeProvider.historial;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Inversiones"),
        backgroundColor: colors.primary,
      ),
      body: historial.isEmpty
          ? Center(
              child: Text(
                "No tienes inversiones registradas",
                style: TextStyle(color: colors.onSurface.withAlpha(150)),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: historial.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final tx = historial[index];
                final invested = tx.status == 'active';
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: colors.onSurface.withAlpha(10),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.fundName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
           
                          const SizedBox(height: 4),
                          Text(
                            "Fecha: ${formatDate(tx.date)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.onSurface.withAlpha(100),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: invested
                              ? Colors.green.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          invested ? "Activa" : "Cancelada",
                          style: TextStyle(
                            color: invested ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
