// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'product_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isMenuOpen = false;
  final ScrollController _scrollController = ScrollController();

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _openProductDetail(Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      ),
    );
  }

  Widget _favoriteCard(Map<String, String> p) {
    final state = context.read<AppState>();

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _openProductDetail(p),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5E9DA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                height: 130,
                child: Image.asset(
                  p['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          p['type'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        p['price'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p['name'] ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "VOIR LE PRODUIT",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      style: AppButtons.redText,
                      onPressed: () {
                        state.toggleFavorite(p);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Le produit a été enlever des favoris"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite),
                      label: Flexible(
                        child: Text(
                          "Retirer de la liste des favoris",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final favorites = state.favorites ?? [];

    return Scaffold(
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
                AppLayout.contentWrapper(
                  context: context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Opacity(
                          opacity: 0.6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_back, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Revenir à la page précédente',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (favorites.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 80),
                            child: Text(
                              'Aucun produit favori',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        LayoutBuilder(
                          builder: (_, constraints) {
                            final maxWidth = constraints.maxWidth;
                            final crossAxisCount =
                            (maxWidth ~/ 250).clamp(1, 4);

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: favorites.length,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 320,
                              ),
                              itemBuilder: (_, i) =>
                                  _favoriteCard(favorites[i]),
                            );
                          },
                        ),
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
    );
  }
}