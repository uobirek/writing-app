import 'package:flutter/material.dart';
import 'package:writing_app/utils/parallax_flow_delegate.dart';

@immutable
class ProjectListItem extends StatelessWidget {
  ProjectListItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  final String imageUrl;
  final String title;
  final String description;
  final GlobalKey _backgroundImageKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(BuildContext context) {
    return Positioned(
      left: 10,
      right: 10, // Added right padding to keep it consistent
      bottom: 10,
      child: Padding(
        padding: const EdgeInsets.all(8), // Same padding from all sides
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity, // Ensures constraints are respected
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Ensures "..." is shown for long text
              ),
            ),
            SizedBox(height: 4), // Adds spacing between title and description
            SizedBox(
              width: double.infinity, // Ensures constraints are respected
              child: Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
                overflow: TextOverflow.ellipsis, // Ensures "..." is shown
                maxLines: 2, // Allows two lines before truncating
              ),
            ),
          ],
        ),
      ),
    );
  }
}
