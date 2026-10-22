import 'package:miscelaneos/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static void registerActions() async {
    const quickActions = QuickActions();
    
    quickActions.initialize((String shortcutType) {
        // print('$shortcutType');

        switch(shortcutType){
          case 'biometric':
          router.push('/biometric');
          break;
          case 'compass':
          router.push('/compass');
          break;
          case 'pokemons':
          router.push('/pokemons');
          break;
          case 'charmander':
          router.push('/pokemons/4');
          break;

      }
      
    });
    await quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'biometric', localizedTitle: 'Biometric', icon: 'finger'),
      const ShortcutItem(type: 'compass', localizedTitle: 'Compass', icon: 'compass'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'Pokemons', icon: 'pokemons'),
      const ShortcutItem(type: 'charmander', localizedTitle: 'Charmander', icon: 'charmander'),
    ]);

  }
}
