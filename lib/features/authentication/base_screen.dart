import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 600;

            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  stops: const [0, 0.5, 0.8, 1],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 40,
                    ),
                    child: Column(
                      // Use flexible layout based on screen size
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRect(
                          child: Image.asset(
                            'assets/images/welcome.jpg',
                            width: isMobile ? 200 : 350,
                            height: isMobile ? 200 : 350,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: isMobile ? 40 : 60),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
