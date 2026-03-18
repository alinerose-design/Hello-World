import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_styles.dart';
import '../pages/home_page.dart';
import '../pages/cart_page.dart';
import '../pages/login_page.dart';
import '../state/app_state.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isMenuOpen;
  final VoidCallback onMenuPressed;

  const AppHeader({
    super.key,
    required this.isMenuOpen,
    required this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  /// Reusable login requirement logic
  Future<void> _requireLogin(
      BuildContext context,
      VoidCallback onSuccess,
      ) async {
    final appState = context.read<AppState>();

    if (appState.isLoggedIn) {
      onSuccess();
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );

    if (context.read<AppState>().isLoggedIn) {
      onSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final base = screenHeight * 0.018;

    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          SizedBox(height: base * 2),
          AppBar(
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            title: LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final logoHeight =
                (availableWidth * 0.22).clamp(base * 3.2, base * 5.2);

                return Row(
                  children: [
                    // LOGO → HOME PAGE
                    Flexible(
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: base * 0.6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                                    (route) => false,
                              );
                            },
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: logoHeight,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ACTIONS
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // PANIER → LOGIN IF NOT CONNECTED
                        TextButton.icon(
                          onPressed: () => _requireLogin(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartPage(),
                              ),
                            );
                          }),
                          style: AppButtons.redText,
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 18,
                          ),
                          label: const Text('Panier'),
                        ),

                        SizedBox(width: base * 0.8),

                        // MENU BUTTON
                        TextButton.icon(
                          onPressed: onMenuPressed,
                          style: AppButtons.whiteText,
                          icon: Icon(
                            isMenuOpen
                                ? Icons.close
                                : Icons.menu,
                            size: 18,
                          ),
                          label: Text(
                            isMenuOpen ? 'Fermer' : 'Menu',
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}