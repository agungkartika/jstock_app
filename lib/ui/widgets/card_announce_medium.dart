import 'package:flutter/material.dart';

class CardAnnounceMedium extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? iconData;

  const CardAnnounceMedium({
    super.key,
    required this.title,
    this.subtitle,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.9; // 90% dari lebar layar
    cardWidth = cardWidth > 600 ? 600 : cardWidth; // Batas maksimal 600px

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(32),
        visualDensity:
            const VisualDensity(vertical: VisualDensity.maximumDensity),
        leading: iconData != null
            ? Icon(
                iconData, // Gunakan iconData yang diberikan
                size: 48,
                color: Colors.white,
              )
            : null,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )
            : null,
      ),
    );
  }
}
