import 'package:FPay/routes/route_handler.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';
  static const viewfine = '/viewfine';
  static const newfine = '/newfine';
  static const profile = '/profile';
  static const settings = '/settings';
  static const edit = '/edit';
  // static const pass = '/pass';
  static const pass = '/pass/:officer';
  static const fine = '/fine';
  static const session = '/session';


  static void configureRouter(Router router) {
    router.define(splash,
        handler: splashHandler, transitionType: TransitionType.native);

    router.define(auth,
        handler: authHandler, transitionType: TransitionType.native);

    router.define(home,
        handler: homeHandler, transitionType: TransitionType.native);

    // router.define(viewfine,
    //     handler: viewfineHandler, transitionType: TransitionType.native);

    // router.define(newfine,
    //     handler: newfineHandler, transitionType: TransitionType.native);

    // router.define(profile,
    //     handler: profileHandler, transitionType: TransitionType.native);

    router.define(edit,
        handler: editHandler, transitionType: TransitionType.native);

    router.define(pass,
        handler: changePassHandler, transitionType: TransitionType.native);

    router.define(fine,
        handler: fineHandler, transitionType: TransitionType.native);
    
    router.define(session,
        handler: createSessionHandler, transitionType: TransitionType.native);
    
    
  }
}
