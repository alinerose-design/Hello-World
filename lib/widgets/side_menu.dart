import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../theme/app_styles.dart';
import '../pages/home_page.dart';
import '../pages/shop_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../state/app_state.dart';

class SideMenu extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const SideMenu({super.key, required this.isOpen, required this.onClose});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  void _goToShop({String? mainCategory, String? subCategory}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShopPage(
          key: ValueKey('$mainCategory-$subCategory'),
          mainCategory: mainCategory,
          subCategory: subCategory,
        ),
      ),
    );
  }

  void _goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Future<void> _openNewsletterMail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'contact@aromatica-balance.com',
      queryParameters: {
        'subject': 'Newsletter subscription',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _openLoginOrProfile(bool logged) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => logged ? ProfilePage() : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logged = context.watch<AppState>().isLoggedIn;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final base = (screenHeight * 0.030).clamp(1.0, 18.0);
    final imageHeight = (screenHeight * 0.095).clamp(70.0, 120.0);

    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: const SizedBox.expand(),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          top: 0,
          bottom: 0,
          right: widget.isOpen ? 0 : -screenWidth,
          width: screenWidth,
          child: Material(
            color: AppColors.white,
            child: AppLayout.contentWrapper(
              context: context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _item('Accueil', base, _goToHome),
                  _divider(),

                  _item('Tous les produits', base, () => _goToShop()),

                  _imageItem(
                    title: 'Produits Locaux',
                    image: 'assets/images/menu_products.webp',
                    height: imageHeight,
                    base: base,
                    onTap: () => _goToShop(mainCategory: 'Produits Locaux'),
                  ),
                  SizedBox(height: base * 0.4),

                  _imageItem(
                    title: 'Pilules & Compléments',
                    image: 'assets/images/menu_pills.webp',
                    height: imageHeight,
                    base: base,
                    onTap: () =>
                        _goToShop(subCategory: 'Pilules & Compléments'),
                  ),

                  SizedBox(height: base * 0.4),

                  _imageItem(
                    title: 'Infusions & Thés',
                    image: 'assets/images/menu_tea.webp',
                    height: imageHeight,
                    base: base,
                    onTap: () =>
                        _goToShop(subCategory: 'Infusions & Thés'),
                  ),

                  SizedBox(height: base * 1.2),

                  _divider(),

                  _item(
                    'Bien-être & Vitalité',
                    base,
                        () => _goToShop(mainCategory: 'Bien-être & Vitalité'),
                  ),

                  _divider(),

                  _item(
                    'Beauté',
                    base,
                        () => _goToShop(mainCategory: 'Beauté'),
                  ),

                  _divider(),

                  _item(
                    'Santé',
                    base,
                        () => _goToShop(mainCategory: 'Santé'),
                  ),

                  _divider(),

                  // RED login/profile item
                  _item(
                    logged ? 'Profile' : 'Connexion',
                    base,
                        () => _openLoginOrProfile(logged),
                    color: AppColors.red,
                  ),

                  _divider(),

                  SizedBox(height: base * 0.6),

                  // Newsletter
                  GestureDetector(
                    onTap: _openNewsletterMail,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: base * 0.5),
                      child: Text(
                        'S’inscrire à la newsletter',
                        style: GoogleFonts.inter(
                          fontSize: base * 0.9,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: base),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(
      String title,
      double base,
      VoidCallback onTap, {
        Color? color,
      }) {
    final textColor = color ?? Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: base * 0.8), // slightly smaller
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: base * 1.1,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: base * 1.45,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageItem({
    required String title,
    required String image,
    required double height,
    required double base,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Positioned(
              top: base * 0.45,
              left: base * 0.45,
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: base * 1.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: base * 0.45,
              right: base * 0.45,
              child: Icon(
                Icons.chevron_right,
                size: base * 1.4,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, thickness: 1);
}