import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'product_detail_page.dart';

class ShopPage extends StatefulWidget {
  final String? mainCategory;
  final String? subCategory;

  const ShopPage({super.key, this.mainCategory, this.subCategory});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isMenuOpen = false;
  final ScrollController _scrollController = ScrollController();

  Set<String> selectedMainCategories = {};
  Set<String> selectedSubCategories = {};
  Set<String> selectedBenefits = {};

  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  // --- New products list with extra fields (tastingNotes, ingredients, brewing)
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

  @override
  void initState() {
    super.initState();
    if (widget.mainCategory != null) {
      selectedMainCategories.add(widget.mainCategory!);
    }
    if (widget.subCategory != null) {
      selectedSubCategories.add(widget.subCategory!);
    }
  }

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  String _truncateTitle(String title) {
    const maxChars = 17;
    if (title.length <= maxChars) return title;
    return '${title.substring(0, maxChars)}...';
  }

  List<Map<String, String>> get filteredProducts {
    return products.where((product) {
      final matchesMain = selectedMainCategories.isEmpty ||
          selectedMainCategories.contains(product['mainCategory']);
      final matchesSub = selectedSubCategories.isEmpty ||
          selectedSubCategories.contains(product['subCategory']);
      final matchesBenefits = selectedBenefits.isEmpty ||
          selectedBenefits.any((b) =>
              (product['benefits'] ?? '').toLowerCase().contains(b.toLowerCase()));
      final q = searchQuery.toLowerCase();
      final matchesSearch =
          q.isEmpty || product.values.any((v) => v.toLowerCase().contains(q));
      return matchesMain && matchesSub && matchesBenefits && matchesSearch;
    }).toList();
  }

  void _openProductDetail(Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      ),
    );
  }

  void _openSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() => searchQuery = searchController.text);
                Navigator.pop(context);
              },
              child: const Text('Appliquer'),
            )
          ],
        ),
      ),
    );
  }

  void _openFilterModal() {
    const main = ['Beauté', 'Santé', 'Bien-être & Vitalité', 'Produits Locaux'];
    const sub = ['Infusions & Thés', 'Pilules & Compléments', 'Huiles & Crèmes', 'Épicerie', 'Beauté'];
    const benefits = ['Relaxation', 'Digestion', 'Énergie', 'Sommeil', 'Immunité', 'Cœur', 'Détox'];

    showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (_, setModal) => Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Catégories principales", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: main.map((c) {
                    final selected = selectedMainCategories.contains(c);
                    return FilterChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selected ? selectedMainCategories.remove(c) : selectedMainCategories.add(c);
                        });
                        setModal(() {});
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text("Sous-catégories", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: sub.map((c) {
                    final selected = selectedSubCategories.contains(c);
                    return FilterChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selected ? selectedSubCategories.remove(c) : selectedSubCategories.add(c);
                        });
                        setModal(() {});
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text("Bienfaits", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: benefits.map((c) {
                    final selected = selectedBenefits.contains(c);
                    return FilterChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selected ? selectedBenefits.remove(c) : selectedBenefits.add(c);
                        });
                        setModal(() {});
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Appliquer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Old style product card
  Widget _productCard(Map<String, String> p) {
    return InkWell(
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                height: 130,
                child: Image.asset(p['image']!, fit: BoxFit.cover),
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
                          p['type']!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        p['price']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _truncateTitle(p['name']!),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p['description'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "VOIR LE PRODUIT",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.chevron_right, size: 18),
                    ],
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(isMenuOpen: isMenuOpen, onMenuPressed: toggleMenu),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                AppLayout.contentWrapper(
                  context: context,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _openSearchModal,
                              icon: const Icon(Icons.search),
                              label: const Text('Rechercher'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _openFilterModal,
                              icon: const Icon(Icons.filter_list),
                              label: const Text('Filtrer'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (_, constraints) {
                          final crossAxisCount = (constraints.maxWidth ~/ 250).clamp(2, 4);
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredProducts.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (_, i) => _productCard(filteredProducts[i]),
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