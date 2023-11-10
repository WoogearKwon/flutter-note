import 'package:flutter/material.dart';
import 'package:flutter_note/presentation/screen/ui/theme/palette.dart';
import 'package:provider/provider.dart';
import 'unsplash_photos_view_model.dart';

export 'unsplash_photos_view_model.dart';

class UnsplashPhotosScreen extends StatelessWidget {
  const UnsplashPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnsplashPhotosViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // use it as child so that it doesn't need to be rebuilt.
            width: double.infinity,
            color: Palette.retroBlue02Light,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(viewModel.photos.length, (index) {

                return GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Image.network(viewModel.photos[index].urls.thumb),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
