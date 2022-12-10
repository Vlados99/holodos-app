import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holodos/common/storage.dart';

class ImageGetter extends StatelessWidget {
  final String dir;
  final String imgName;

  final BoxFit? fit;
  final double? width;
  const ImageGetter({
    Key? key,
    required this.dir,
    required this.imgName,
    this.fit,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Storage.getImage(dir, imgName),
      builder: ((context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        } else {
          if (imgName.contains(".svg")) {
            return SvgPicture.network(snapshot.data!);
          }
          return Image.network(
            fit: fit,
            width: width,
            snapshot.data!,
          );
        }
      }),
    );
  }
}
