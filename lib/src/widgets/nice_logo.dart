import 'package:flutter/material.dart';

import '../theme/nice_theme.dart';

class NiceLogo extends StatelessWidget {
  const NiceLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    // PLACEHOLDER_ASSET_LOGO: substitua este widget por Image.asset('assets/logo.png')
    // quando a logo oficial da loja estiver disponivel.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: compact ? 40 : 70,
              fontWeight: FontWeight.w900,
              height: 0.82,
              letterSpacing: 0,
              color: NiceTheme.charcoal,
            ),
            children: const [
              TextSpan(text: 'N'),
              TextSpan(text: 'i', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'C', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'E'),
            ],
          ),
        ),
        Text(
          'Streetwear by Japan',
          style: TextStyle(
            color: NiceTheme.charcoal.withOpacity(0.72),
            fontSize: compact ? 7 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
