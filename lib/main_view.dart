import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:particles_fly/particles_fly.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SvgPicture.asset(
            "assets/images/portrait.svg",
            height: 500,
            color: Colors.amber,
          ),
        ),
        ParticlesFly(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          awayAnimationCurve: Curves.bounceInOut,
          isRandomColor: true,
          connectDots: true,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
                child: ListTile(
              leading: Icon(
                Icons.verified_user,
                color: Colors.amberAccent,
              ),
              title: Text(
                "Remove all the particles from the painting by clicking and share a clear picture!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "Downloaded Picture is automatically saved in your Downloads Folder!"),
            )),
          ],
        ),
      ],
    );
  }
}
