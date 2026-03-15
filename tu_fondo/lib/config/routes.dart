import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tu_fondo/modules/login/pages/login.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: Login(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return PageTransition(
              type: .leftToRightPop,
              child: child,
            ).buildTransitions(context, animation, secondaryAnimation, child);
          },
        );
      },
    ),
  ],
);





// fade	
// rightToLeft	
// leftToRight	
// topToBottom	
// bottomToTop	
// scale	
// rotate	
// size	
// rightToLeftWithFade	
// leftToRightWithFade	