import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'order_success_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isMenuOpen = false;
  String? editingField;

  final ScrollController _scrollController = ScrollController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalController = TextEditingController();

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Widget buildResponsiveField({
    required String label,
    required String keyName,
    required TextEditingController controller,
    required AppState state,
    required String value,
  }) {
    final bool isEditing = editingField == keyName;
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    if (!isEditing) {
      controller.text = value;
    }

    Widget valueWidget = isEditing
        ? TextField(
      controller: controller,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
      ),
    )
        : Text(value);

    Widget actionsWidget = isEditing
        ? Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: [
        TextButton(
          style: AppButtons.whiteText,
          onPressed: () {
            setState(() => editingField = null);
          },
          child: const Text("Annuler"),
        ),
        TextButton(
          style: AppButtons.redText,
          onPressed: () {
            state.updateUserField(keyName, controller.text);
            setState(() => editingField = null);
          },
          child: const Text("Mettre à jour"),
        ),
      ],
    )
        : TextButton.icon(
      style: AppButtons.whiteText,
      onPressed: () {
        setState(() => editingField = keyName);
      },
      icon: const Icon(Icons.edit, size: 18),
      label: const Text("Modifier"),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              valueWidget,
              const SizedBox(height: 12),
              actionsWidget,
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: valueWidget,
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: actionsWidget,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = state.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Non connecté")),
      );
    }

    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLayout.contentWrapper(
                  context: context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppColors.beige,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Confirmation de commande",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),

                            buildResponsiveField(
                              label: "Nom",
                              keyName: "name",
                              controller: nameController,
                              state: state,
                              value: user['name'] ?? '',
                            ),
                            buildResponsiveField(
                              label: "Adresse",
                              keyName: "address",
                              controller: addressController,
                              state: state,
                              value: user['address'] ?? '',
                            ),
                            buildResponsiveField(
                              label: "Ville",
                              keyName: "city",
                              controller: cityController,
                              state: state,
                              value: user['city'] ?? '',
                            ),
                            buildResponsiveField(
                              label: "Code postal",
                              keyName: "postalCode",
                              controller: postalController,
                              state: state,
                              value: user['postalCode'] ?? '',
                            ),

                            const SizedBox(height: 40),

                            TextButton.icon(
                              style: AppButtons.redText,
                              icon: const Icon(Icons.check),
                              label: const Text("Confirmer la commande"),
                              onPressed: () {
                                state.clearCart();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const OrderSuccessPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
                AppFooter(onBackToTop: scrollToTop),
              ],
            ),
          ),
          SideMenu(
            isOpen: isMenuOpen,
            onClose: closeMenu,
          ),
        ],
      ),
    );
  }
}