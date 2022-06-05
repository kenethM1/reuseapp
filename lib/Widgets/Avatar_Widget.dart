import 'package:flutter/material.dart';

import '../models/Product.dart';
import '../utils/colors.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.profilePicture,
    required this.size,
  }) : super(key: key);

  final String profilePicture;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorsApp.secondary,
      radius: size,
      child: profilePicture.isNotEmpty
          ? ClipOval(
              child: Image.network(
                profilePicture,
                fit: BoxFit.cover,
                errorBuilder: (context, object, error) => const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                loadingBuilder: (context, widget, imageChunk) =>
                    (imageChunk?.expectedTotalBytes ?? 0) /
                                (imageChunk?.cumulativeBytesLoaded ?? 0) >
                            0.5
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorsApp.secondary),
                              ),
                            ),
                          )
                        : widget,
              ),
            )
          : const Icon(
              Icons.person,
              color: Colors.white,
            ),
    );
  }
}
