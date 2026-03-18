// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'checkout_page.dart';
import 'product_detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final cart = state.cart;

    final Map<String, Map<String, dynamic>> grouped = {};
    for (final p in cart) {
      final name = p['name'] ?? '';
      if (!grouped.containsKey(name)) {
        grouped[name] = {'product': p, 'qty': 1};
      } else {
        grouped[name]!['qty']++;
      }
    }

    double parsePrice(String price) {
      final cleaned = price.replaceAll(RegExp(r'[^0-9.,]'), '').replaceAll(',', '.');
      return double.tryParse(cleaned) ?? 0;
    }

    double total = 0;
    for (final item in grouped.values) {
      final p = item['product'] as Map<String, String>;
      final qty = item['qty'] as int;
      total += parsePrice(p['price'] ?? '0') * qty;
    }

    void addOne(Map<String, String> product) {
      context.read<AppState>().addToCart(product);
    }

    void removeOne(Map<String, String> product) {
      final cartList = context.read<AppState>().cart;
      final index = cartList.indexWhere((e) => (e['name'] ?? '') == (product['name'] ?? ''));
      if (index != -1) {
        cartList.removeAt(index);
        (context.read<AppState>() as dynamic).notifyListeners();
      }
    }

    void removeAll(Map<String, String> product) {
      final cartList = context.read<AppState>().cart;
      cartList.removeWhere((e) => (e['name'] ?? '') == (product['name'] ?? ''));
      (context.read<AppState>() as dynamic).notifyListeners();
    }

    Widget _cartCard(Map<String, String> product, int qty) {
      final price = parsePrice(product['price'] ?? '0');
      final canMinus = qty > 1;
      final canPlus = qty < 100;

      return LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 450;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5E9DA),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if ((product['image'] ?? '').isNotEmpty)
                      Image.asset(product['image']!, width: 80, height: 80, fit: BoxFit.cover)
                    else
                      const Icon(Icons.image, size: 80),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(product['price'] ?? ''),
                          const SizedBox(height: 6),
                          Text("Sous-total: ${(price * qty).toStringAsFixed(2)}",
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline, color: canMinus ? null : Colors.grey),
                      onPressed: canMinus ? () => removeOne(product) : null,
                    ),
                    Text(qty.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: canPlus ? null : Colors.grey),
                      onPressed: canPlus ? () => addOne(product) : null,
                    ),
                    const SizedBox(width: 12),
                    TextButton.icon(
                      style: AppButtons.whiteText,
                      onPressed: () => removeAll(product),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text("Supprimer le produit"),
                    ),
                  ],
                ),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((product['image'] ?? '').isNotEmpty)
                  Image.asset(product['image']!, width: 100, height: 100, fit: BoxFit.cover)
                else
                  const Icon(Icons.image, size: 100),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(product['price'] ?? ''),
                      const SizedBox(height: 6),
                      Text("Sous-total: ${(price * qty).toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: canMinus ? null : Colors.grey),
                          onPressed: canMinus ? () => removeOne(product) : null,
                        ),
                        Text(qty.toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline, color: canPlus ? null : Colors.grey),
                          onPressed: canPlus ? () => addOne(product) : null,
                        ),
                      ],
                    ),
                    TextButton.icon(
                      style: AppButtons.whiteText,
                      onPressed: () => removeAll(product),
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text("Supprimer le produit"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

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
                      if (grouped.isEmpty)
                        const Center(child: Text("Panier vide"))
                      else
                        Column(
                          children: [
                            for (final item in grouped.values)
                              _cartCard(item['product'] as Map<String, String>, item['qty'] as int),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total: ${total.toStringAsFixed(2)}",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                TextButton.icon(
                                  style: AppButtons.redText,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const CheckoutPage()),
                                    );
                                  },
                                  icon: const Icon(Icons.payment),
                                  label: const Text("Valider le panier"),
                                )
                              ],
                            ),
                          ],
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