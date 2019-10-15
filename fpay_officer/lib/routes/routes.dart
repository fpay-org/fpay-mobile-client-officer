import 'package:FPay/routes/route_handler.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';

  static void configureRouter(Router router) {
    router.define(splash,
        handler: splashHandler, transitionType: TransitionType.native);

    router.define(auth,
        handler: authHandler, transitionType: TransitionType.native);

    router.define(home,
        handler: homeHandler, transitionType: TransitionType.native);
  }
}
