import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_shipping,
                  size: 90,
                  color: Colors.green,
                ),
                const SizedBox(height: 32),
                const Text(
                  "Votre achat a bien été effectué !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Merci pour votre commande.\nVotre livraison est en préparation.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextButton(
                  style: AppButtons.redText,
                  onPressed: () {
                    Navigator.popUntil(
                        context, (route) => route.isFirst);
                  },
                  child: const Text("Retour à l'accueil"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}