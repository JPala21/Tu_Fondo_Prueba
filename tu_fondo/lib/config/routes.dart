import 'package:go_router/go_router.dart';
import 'package:tu_fondo/modules/login/pages/login.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => Login())],
);
