import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'product_detail_page.dart';
import 'shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMenuOpen = false;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> products = [
    {
      "name": "Thé Vert Bio",
      "type": "Thé Vert",
      "price": "9€",
      "image": "assets/products_images/green_tea.jpg",
      "mainCategory": "Bien-être & Vitalité",
      "subCategory": "Infusions & Thés",
      "tags": "tea, infusion",
      "description": "Thé vert biologique riche en antioxydants pour soutenir le métabolisme.",
      "tastingNotes": "Herbacé, frais, légèrement sucré",
      "ingredients": "100% feuilles de thé vert biologique",
      "brewing": "Température: 75°C, Temps: 2-3 min"
    },
    {
      "name": "Thé Noir Assam",
      "type": "Thé Noir",
      "price": "10€",
      "image": "assets/products_images/black_tea.jpg",
      "mainCategory": "Bien-être & Vitalité",
      "subCategory": "Infusions & Thés",
      "tags": "tea, infusion",
      "description": "Thé noir intense et stimulant idéal pour le matin.",
      "tastingNotes": "Riche, malté, corsé",
      "ingredients": "100% feuilles de thé noir Assam",
      "brewing": "Température: 95°C, Temps: 3-5 min"
    },
    {
      "name": "Infusion Camomille",
      "type": "Infusion",
      "price": "8€",
      "image": "assets/products_images/chamomille_tea.jpg",
      "mainCategory": "Santé",
      "subCategory": "Infusions & Thés",
      "tags": "tea, infusion",
      "description": "Infusion douce favorisant détente et sommeil.",
      "tastingNotes": "Doux, floral, apaisant",
      "ingredients": "Fleurs de camomille 100% biologiques",
      "brewing": "Température: 90°C, Temps: 5-7 min"
    },
    {
      "name": "Capsules Oméga 3",
      "type": "Complément",
      "price": "18€",
      "image": "assets/products_images/omega3_capsules.jpg",
      "mainCategory": "Santé",
      "subCategory": "Pilules & Compléments",
      "tags": "complément",
      "description": "Complément alimentaire pour soutenir la santé cardiovasculaire."
    },
    {
      "name": "Poudre Protéinée",
      "type": "Complément",
      "price": "25€",
      "image": "assets/products_images/protein_powder.jpg",
      "mainCategory": "Santé",
      "subCategory": "Pilules & Compléments",
      "tags": "complément",
      "description": "Poudre protéinée pour récupération et vitalité."
    },
    {
      "name": "Baume Relaxant",
      "type": "Baume",
      "price": "15€",
      "image": "assets/products_images/relax_balm.jpg",
      "mainCategory": "Beauté",
      "subCategory": "Huiles & Crèmes",
      "tags": "beauté",
      "description": "Baume apaisant pour favoriser la détente."
    },
    {
      "name": "Miel de Lavande Local",
      "type": "Miel",
      "price": "14€",
      "image": "assets/products_images/lavender_honey.jpg",
      "mainCategory": "Produits Locaux",
      "subCategory": "Épicerie",
      "tags": "produits locaux",
      "description": "Miel de lavande récolté localement."
    },
    {
      "name": "Huile d’Olive Artisanale",
      "type": "Huile",
      "price": "18€",
      "image": "assets/products_images/olive_oil_local.jpg",
      "mainCategory": "Produits Locaux",
      "subCategory": "Épicerie",
      "tags": "produits locaux",
      "description": "Huile d’olive extra vierge issue d’un domaine local."
    },
    {
      "name": "Savon Lavande Artisanal",
      "type": "Savon",
      "price": "7€",
      "image": "assets/products_images/lavender_soap.jpg",
      "mainCategory": "Produits Locaux",
      "subCategory": "Beauté",
      "tags": "produits locaux",
      "description": "Savon artisanal à la lavande fabriqué localement."
    },
    {
      "name": "Mélange Plantes Détox",
      "type": "Infusion",
      "price": "12€",
      "image": "assets/products_images/herbal_mix.jpg",
      "mainCategory": "Bien-être & Vitalité",
      "subCategory": "Infusions & Thés",
      "tags": "tea, infusion",
      "description": "Mélange de plantes pour soutenir la détox naturelle.",
      "tastingNotes": "Herbacé, légèrement amer, frais",
      "ingredients": "Menthe, fenouil, ortie, pissenlit",
      "brewing": "Température: 95°C, Temps: 5-7 min"
    },
    {
      "name": "Infusion Gingembre",
      "type": "Infusion",
      "price": "9€",
      "image": "assets/products_images/ginger_tea.jpg",
      "mainCategory": "Bien-être & Vitalité",
      "subCategory": "Infusions & Thés",
      "tags": "tea, infusion",
      "description": "Infusion stimulante au gingembre.",
      "tastingNotes": "Épicé, piquant, revigorant",
      "ingredients": "Racine de gingembre séchée",
      "brewing": "Température: 95°C, Temps: 5 min"
    },
    {
      "name": "Pilules Multivitamines",
      "type": "Complément",
      "price": "15€",
      "image": "assets/products_images/pills.jpg",
      "mainCategory": "Santé",
      "subCategory": "Pilules & Compléments",
      "tags": "complément",
      "description": "Complexe multivitaminé pour soutenir énergie et immunité."
    }
  ];

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Widget _productCard(Map<String, String> product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5E9DA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                height: 120,
                child: Image.asset(
                  product['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['type'] ?? '',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['name']!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product['price']!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateVisibleProducts(double width) {
    // Adjusted for mobile: minimum 2 products per row
    if (width < 500) return 2; // Mobile small width
    const double minCardWidth = 260;
    const double spacing = 16;

    for (int count = 3; count >= 1; count--) {
      double neededWidth = (minCardWidth * count) + (spacing * (count - 1));
      if (width >= neededWidth) return count;
    }
    return 1; // fallback
  }

  Widget _nonWrappingProducts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        int visibleCount = _calculateVisibleProducts(constraints.maxWidth);

        if (visibleCount == 0) return const SizedBox.shrink();

        List<Widget> rowChildren = [];
        for (int i = 0; i < visibleCount && i < products.length; i++) {
          rowChildren.add(
            Expanded(child: _productCard(products[i])),
          );
          if (i != visibleCount - 1) rowChildren.add(const SizedBox(width: spacing));
        }

        return Row(children: rowChildren);
      },
    );
  }

  Widget _responsiveGreenSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 900;

        return Container(
          width: double.infinity,
          color: const Color(0xFF232B0C),
          child: isMobile
              ? Column(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/tea_detox_card.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Détox & Santé Naturelle',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEEE9E3),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Des solutions essentielles pour purifier l’organisme, retrouver l’équilibre et soutenir votre vitalité au quotidien.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEEE9E3),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
              : SizedBox(
            height: 280,
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/tea_detox_card.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Détox & Santé Naturelle',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEEE9E3),
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Des solutions essentielles pour purifier l’organisme, retrouver l’équilibre et soutenir votre vitalité au quotidien.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEEE9E3),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionCard({
    required Color backgroundColor,
    required Color textColor,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: AppLayout.contentWrapper(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(String text, {String? mainCategory, String? subCategory}) {
    return TextButton(
      style: AppButtons.redText,
      onPressed: () {
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
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                fontSize: 18, // increased font size for mobile
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _beigeCategoryCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 700;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
          child: AppLayout.contentWrapper(
            context: context,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.beige,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/pills_nature_detox.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  isMobile
                      ? Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: _categoryButton(
                          'Bien-être & Vitalité',
                          mainCategory: 'Bien-être & Vitalité',
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: _categoryButton(
                          'Santé',
                          mainCategory: 'Santé',
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: _categoryButton(
                          'Beauté',
                          mainCategory: 'Beauté',
                        ),
                      ),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _categoryButton(
                          'Bien-être & Vitalité',
                          mainCategory: 'Bien-être & Vitalité',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _categoryButton(
                          'Santé',
                          mainCategory: 'Santé',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _categoryButton(
                          'Beauté',
                          mainCategory: 'Beauté',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppHeader(
          isMenuOpen: isMenuOpen,
          onMenuPressed: toggleMenu,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: isMenuOpen
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/main_image_leaf.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.25),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Aromatica & Balance',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.redRose(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Solutions naturelles détox & santé pour retrouver l’équilibre et booster l’énergie au quotidien.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppLayout.contentWrapper(
                    context: context,
                    child: _nonWrappingProducts(),
                  ),
                  const SizedBox(height: 40),
                  _responsiveGreenSection(),
                  _sectionCard(
                    backgroundColor: const Color(0xFFD24636),
                    textColor: const Color(0xFFFFEECC),
                    title: 'Cuisine Détox & Équilibrée',
                    description:
                    'Des recettes et solutions culinaires simples pour nourrir le corps, soutenir la détox et allier plaisir et santé au quotidien.',
                  ),
                  const SizedBox(height: 16),
                  _beigeCategoryCard(),
                  const SizedBox(height: 40),
                  AppFooter(
                    onBackToTop: scrollToTop,
                  ),
                ],
              ),
            ),
            SideMenu(
              isOpen: isMenuOpen,
              onClose: closeMenu,
            ),
          ],
        ),
      ),
    );
  }
}