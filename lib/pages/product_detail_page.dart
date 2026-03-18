// lib/pages/product_detail_page.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';

import '../state/app_state.dart';
import '../pages/cart_page.dart';
import '../pages/login_page.dart';
import '../pages/favorites_page.dart';
import '../pages/shop_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isMenuOpen = false;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> allProducts = [
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

  void _showSnackBar({
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Message + action button
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(message, style: GoogleFonts.inter(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: onAction,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.white, // Make the text white
                    ),
                    child: Text(
                      actionLabel,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure white text
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Close X button
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.close, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black87, // Dark background for contrast
      ),
    );
  }
  Future<void> requireLogin(VoidCallback onSuccess) async {
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

  // --- TAG WIDGET ---
  Widget _tag(String text, {String? mainCategory, String? subCategory, bool isDesktop = false}) {
    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShopPage(
                      key: ValueKey('$mainCategory-$subCategory'),
                      mainCategory: mainCategory ?? text,
                      subCategory: subCategory,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 8),
        child: TextButton(
          style: AppButtons.whiteText,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ShopPage(
                  key: ValueKey('$mainCategory-$subCategory'),
                  mainCategory: mainCategory ?? text,
                  subCategory: subCategory,
                ),
              ),
            );
          },
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      );
    }
  }

  void _showTagsModal(BuildContext context, List<String> tags, Map<String, String> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.chevron_left),
                  label: const Text(
                    'Fermer les informations du produit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tagText) => _tag(
                  tagText,
                  mainCategory: product['mainCategory'],
                  subCategory: product['subCategory'],
                  isDesktop: false,
                )).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoBlock(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(value ?? '', style: GoogleFonts.inter()),
      ],
    );
  }

  List<Map<String, String>> _recommendedProducts(Map<String, String> base) {
    final baseSub = base['subCategory'] ?? '';
    final baseBenefits = (base['benefits'] ?? '').toLowerCase().split(' ');

    final scored = <MapEntry<Map<String, String>, int>>[];

    for (final p in allProducts) {
      if (p['name'] == base['name']) continue;

      int score = 0;
      if (p['subCategory'] == baseSub) score += 2;

      final pb = (p['benefits'] ?? '').toLowerCase().split(' ');
      for (final b in baseBenefits) {
        if (pb.contains(b)) score += 1;
      }

      if (score > 0) {
        scored.add(MapEntry(p, score));
      }
    }

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(3).map((e) => e.key).toList();
  }

  Widget _recommendedCard(Map<String, String> p) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: p),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5E9DA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 120,
                child: Image.asset(p['image']!, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['type'] ?? '', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    p['name']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(p['price']!, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final state = context.watch<AppState>();

    final image = product['image'];
    final name = product['name'] ?? '';
    final price = product['price'] ?? '';
    final type = product['type'] ?? '';
    final mainCategory = product['mainCategory'];
    final subCategory = product['subCategory'];

    final recs = _recommendedProducts(product);

    final List<String> tags = [
      if (mainCategory != null) mainCategory,
      if (subCategory != null) subCategory,
    ];

    bool isFavorite(Map<String, String> p) => state.favoritesSet.contains(p['name'] ?? '');

    final baseTheme = Theme.of(context);

    return Theme(
      data: baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppHeader(isMenuOpen: isMenuOpen, onMenuPressed: toggleMenu),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: isMenuOpen
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PRODUCT IMAGE + TAGS + FAVORITE
                  LayoutBuilder(builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    return Stack(
                      children: [
                        SizedBox(
                          height: 440,
                          width: double.infinity,
                          child: image != null && image.isNotEmpty
                              ? Image.asset(image, fit: BoxFit.cover)
                              : const Icon(Icons.image_not_supported, size: 120),
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          right: isMobile ? 16 : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isMobile)
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black45,
                                  ),
                                  onPressed: () => _showTagsModal(context, tags, product),
                                  icon: const Icon(Icons.info_outline, color: Colors.white),
                                  label: const Text(
                                    'Infos produit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              else
                                Wrap(
                                  children: tags.map((t) => _tag(
                                    t,
                                    mainCategory: mainCategory,
                                    subCategory: subCategory,
                                    isDesktop: true,
                                  )).toList(),
                                ),
                              if (isMobile) const SizedBox(height: 12),
                              if (isMobile)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton.icon(
                                    style: AppButtons.yellowText,
                                    icon: Icon(isFavorite(product) ? Icons.favorite : Icons.favorite_border),
                                    label: const Text('Ajouter aux favoris'),
                                    onPressed: () => requireLogin(() {
                                      final wasFavorite = isFavorite(product);
                                      state.toggleFavorite(product);

                                      _showSnackBar(
                                        message: wasFavorite
                                            ? "Le produit a été enlevé des favoris"
                                            : "Un produit a été ajouté aux favoris",
                                        actionLabel: "Voir la liste des favoris",
                                        onAction: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => const FavoritesPage()),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (!isMobile)
                          Positioned(
                            right: 16,
                            top: 16,
                            child: TextButton.icon(
                              style: AppButtons.yellowText,
                              icon: Icon(isFavorite(product) ? Icons.favorite : Icons.favorite_border),
                              label: const Text('Ajouter aux favoris'),
                              onPressed: () => requireLogin(() {
                                final wasFavorite = isFavorite(product);
                                state.toggleFavorite(product);

                                _showSnackBar(
                                  message: wasFavorite
                                      ? "Le produit a été enlevé des favoris"
                                      : "Un produit a été ajouté aux favoris",
                                  actionLabel: "Voir la liste des favoris",
                                  onAction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const FavoritesPage()),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),                      ],
                    );
                  }),

                  // --- Product Info ---
                  AppLayout.contentWrapper(
                    context: context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(type, style: GoogleFonts.inter()),
                            TextButton.icon(
                              style: AppButtons.redText,
                              onPressed: () => requireLogin(() {
                                state.addToCart(product);
                                _showSnackBar(
                                  message: "Un produit a été ajouté au panier",
                                  actionLabel: "Voir le panier",
                                  onAction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const CartPage(),
                                      ),
                                    );
                                  },
                                );
                              }),
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Ajouter au panier'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(name,
                            style: GoogleFonts.inter(
                                fontSize: 26, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        FractionallySizedBox(
                          widthFactor: 0.2,
                          alignment: Alignment.centerLeft,
                          child: Container(height: 2, color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        Text(price,
                            style: GoogleFonts.inter(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Opacity(
                            opacity: 0.6,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.arrow_back),
                                const SizedBox(width: 6),
                                Text(
                                  'Revenir à la liste des produits',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Container(height: 1, color: Colors.black26),
                  const SizedBox(height: 24),

                  // --- Tea/Product Info Block ---
                  AppLayout.contentWrapper(
                    context: context,
                    child: LayoutBuilder(builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 800;

                      if (subCategory == 'Infusions & Thés') {
                        return isMobile
                            ? Column(
                          children: [
                            SizedBox(
                              height: 220,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/tea_description.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: AppColors.beige,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _infoBlock('Notes', product['tastingNotes']),
                                  const SizedBox(height: 12),
                                  _infoBlock('Ingrédients', product['ingredients']),
                                  const SizedBox(height: 12),
                                  _infoBlock('Infusion', product['brewing']),
                                ],
                              ),
                            ),
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 320,
                                  child: Image.asset(
                                    'assets/images/tea_description.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 320,
                                  color: AppColors.beige,
                                  padding: const EdgeInsets.all(28),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _infoBlock('Notes', product['tastingNotes']),
                                      _infoBlock('Ingrédients', product['ingredients']),
                                      _infoBlock('Infusion', product['brewing']),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: AppColors.beige,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                product['description'] ?? 'Aucune description disponible.',
                                style: GoogleFonts.inter(),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ),

                  const SizedBox(height: 40),

                  // --- Recommended Products ---
                  if (recs.isNotEmpty)
                    AppLayout.contentWrapper(
                      context: context,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'PRODUITS RECOMMANDÉS',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                          const SizedBox(height: 16),
                          LayoutBuilder(builder: (context, constraints) {
                            final spacing = 16.0;
                            final itemWidth = constraints.maxWidth < 600
                                ? constraints.maxWidth
                                : (constraints.maxWidth - spacing * 2) / 3;

                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: recs
                                  .map((p) => SizedBox(
                                width: itemWidth,
                                child: _recommendedCard(p),
                              ))
                                  .toList(),
                            );
                          }),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),

                  AppFooter(onBackToTop: scrollToTop),
                ],
              ),
            ),
            SideMenu(isOpen: isMenuOpen, onClose: closeMenu),
          ],
        ),
      ),
    );
  }
}