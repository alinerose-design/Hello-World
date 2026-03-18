import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/app_header.dart';
import '../widgets/side_menu.dart';
import '../widgets/footer.dart';
import '../theme/app_styles.dart';
import 'favorites_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? editingKey;
  final TextEditingController controller = TextEditingController();
  bool isMenuOpen = false;

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);
  void closeMenu() => setState(() => isMenuOpen = false);

  Future<void> _confirmDelete(BuildContext context, AppState state) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text('Êtes vous sûr ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Non')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Oui')),
        ],
      ),
    );

    if (ok == true) {
      await state.deleteAccount();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  Widget buildEditableRow(
      String label, String keyName, String value, AppState state) {
    final bool isEditing = editingKey == keyName;
    final bool isMobile = MediaQuery.of(context).size.width < 700;

    if (!isEditing) controller.text = value;

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
          onPressed: () => setState(() => editingKey = null),
          child: const Text("Annuler"),
        ),
        TextButton(
          style: AppButtons.redText,
          onPressed: () {
            state.updateUserField(keyName, controller.text);
            setState(() => editingKey = null);
          },
          child: const Text("Mettre à jour"),
        ),
      ],
    )
        : TextButton.icon(
      style: AppButtons.whiteText,
      onPressed: () {
        controller.text = value;
        setState(() => editingKey = keyName);
      },
      icon: const Icon(Icons.edit, size: 18),
      label: const Text("Modifier"),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              valueWidget,
              const SizedBox(height: 8),
              actionsWidget,
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 120,
                  child: Text(label,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(width: 16),
              Expanded(flex: 3, child: valueWidget),
              const SizedBox(width: 16),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: actionsWidget,
                  )),
            ],
          ),
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }

  Widget buildActionTile({
    required String label,
    required VoidCallback onTap,
    Color? textColor,
    bool isTrailingChevron = true,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            label,
            style: TextStyle(
              color: textColor ?? AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: isTrailingChevron ? const Icon(Icons.chevron_right) : null,
          onTap: onTap,
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
        body: Center(child: Text('Non connecté')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white, // background white
      appBar: AppHeader(
        isMenuOpen: isMenuOpen,
        onMenuPressed: toggleMenu,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
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
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildEditableRow('Nom', 'name', user['name'] ?? '', state),
                      buildEditableRow(
                          'Email', 'email', user['email'] ?? '', state),
                      buildEditableRow(
                          'Adresse', 'address', user['address'] ?? '', state),
                      buildEditableRow('Ville', 'city', user['city'] ?? '', state),
                      buildEditableRow('Code postal', 'postalCode',
                          user['postalCode'] ?? '', state),

                      const SizedBox(height: 16),

                      buildActionTile(
                        label: 'Liste des produits favoris',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FavoritesPage()),
                          );
                        },
                      ),
                      buildActionTile(
                        label: 'Se déconnecter',
                        onTap: () {
                          state.logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        textColor: AppColors.black.withOpacity(0.6),
                        isTrailingChevron: false,
                      ),
                      buildActionTile(
                        label: 'Supprimer le compte',
                        onTap: () => _confirmDelete(context, state),
                        textColor: AppColors.red,
                        isTrailingChevron: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                AppFooter(onBackToTop: () {}),
                const SizedBox(height: 32),
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