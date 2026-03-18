import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_styles.dart';
import '../pages/home_page.dart';
import '../pages/shop_page.dart';

class AppFooter extends StatefulWidget {
  final VoidCallback onBackToTop;

  const AppFooter({super.key, required this.onBackToTop});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  final TextEditingController _emailController = TextEditingController();

  // ───────── Newsletter Email
  Future<void> _submitNewsletter() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    final uri = Uri(
      scheme: 'mailto',
      path: 'contact@aromatica-balance.com',
      queryParameters: {
        'subject': 'Newsletter subscription',
        'body': 'Email: $email',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _emailController.clear();
    }
  }

  // ───────── Navigate to ShopPage with filters
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final base = height * 0.018;

    return Column(
      children: [

        // ───────── TOP LEAF BUTTON (Yellow Button with Padding)
        Container(
          width: double.infinity,
          height: base * 11,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/leaf-background.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: AppLayout.contentWrapper(
            context: context,
            child: Center(
              child: TextButton(
                style: AppButtons.yellowText,
                onPressed: () => _goToShop(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: base * 1.6,
                    vertical: base * 0.9,
                  ),
                  child: Text(
                    'Découvrir nos produits',
                    style: GoogleFonts.inter(
                      fontSize: base * 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // ───────── MENU SECTION
        Container(
          width: double.infinity,
          color: AppColors.beige,
          padding: EdgeInsets.symmetric(vertical: base * 2),
          child: AppLayout.contentWrapper(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _menuItem('Accueil', base, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }),
                _divider(),

                _menuItem('Tous les produits', base, () => _goToShop()),
                _menuItem(
                    'Produits Locaux',
                    base,
                        () => _goToShop(mainCategory: 'Produits Locaux'),
                    true),
                _menuItem(
                    'Pilules & Compléments',
                    base,
                        () => _goToShop(subCategory: 'Pilules & Compléments'),
                    true),
                _menuItem(
                    'Infusions & Thés',
                    base,
                        () => _goToShop(subCategory: 'Infusions & Thés'),
                    true),

                _divider(),

                _menuItem(
                    'Bien-être & Vitalité',
                    base,
                        () => _goToShop(mainCategory: 'Bien-être & Vitalité')),

                _divider(),

                _menuItem(
                    'Beauté',
                    base,
                        () => _goToShop(mainCategory: 'Beauté')),

                _divider(),

                _menuItem(
                    'Santé',
                    base,
                        () => _goToShop(mainCategory: 'Santé')),

                _divider(),

                SizedBox(height: base),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact',
                      style: GoogleFonts.inter(),
                    ),
                    Text(
                      '27 rue des Tanneurs 25200 Montbéliard France',
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ───────── NEWSLETTER
        Container(
          width: double.infinity,
          color: AppColors.red,
          padding: EdgeInsets.symmetric(vertical: base * 2),
          child: AppLayout.contentWrapper(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEWSLETTER',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: base * 2.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: base * 1.2),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Adresse email',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _submitNewsletter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: base * 1.6,
                          vertical: base,
                        ),
                        color: Colors.black,
                        child: const Text(
                          'S’inscrire',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: base * 2),

                // ───────── Aromatica & Balance with Red Rose font
                Center(
                  child: Text(
                    'Aromatica & Balance',
                    style: GoogleFonts.redRose(
                      color: AppColors.yellow,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ───────── BACK TO TOP (Black Circle with Arrow)
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: base * 1.4),
          child: AppLayout.contentWrapper(
            context: context,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: widget.onBackToTop,
                  child: Text(
                    'Retourner en haut',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),

                SizedBox(width: base * 0.8),

                InkWell(
                  onTap: widget.onBackToTop,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: base * 2.4,
                    height: base * 2.4,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ───────── MENU TEXT ITEMS
  Widget _menuItem(String title, double base, VoidCallback onTap,
      [bool small = false]) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: base * 1.1),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: small ? base * 1 : base * 1.4,
            fontWeight: small ? FontWeight.w700 : FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, thickness: 1);
}
