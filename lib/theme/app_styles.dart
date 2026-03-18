import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────
/// 🎨 COLORS
/// ─────────────────────────────────────────────
class AppColors {
  static const Color beige = Color(0xFFEEE9E3);
  static const Color red = Color(0xFFD24636);
  static const Color yellow = Color(0xFFFFEECC);
  static const Color green = Color(0xFF232B0C);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

/// ─────────────────────────────────────────────
/// 🔘 BUTTON STYLES
/// ─────────────────────────────────────────────
class AppButtons {
  /// 🔴 Red text button (header / panier)
  static ButtonStyle redText = TextButton.styleFrom(
    backgroundColor: AppColors.red,
    foregroundColor: AppColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );

  /// ⚪ White text button (header / menu)
  static ButtonStyle whiteText = TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.black,
    side: const BorderSide(color: AppColors.black),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );

  /// 🟡 Yellow button
  static ButtonStyle yellowText = TextButton.styleFrom(
    backgroundColor: AppColors.yellow,
    foregroundColor: AppColors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}

/// ─────────────────────────────────────────────
/// 📝 TEXT STYLES
/// ─────────────────────────────────────────────
class AppTextStyles {
  // Home / page titles
  static const TextStyle pageTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  );

  static const TextStyle pageSubtitle = TextStyle(
    fontSize: 18,
    color: Colors.grey,
  );

  // Side menu main items
  static const TextStyle sideMenuMain = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  );

  // Side menu smaller items
  static const TextStyle sideMenuSub = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
}

/// ─────────────────────────────────────────────
/// 📐 LAYOUT
/// ─────────────────────────────────────────────
class AppLayout {
  /// Wraps content so it never exceeds 80% of screen width
  static Widget contentWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: child,
      ),
    );
  }
}
