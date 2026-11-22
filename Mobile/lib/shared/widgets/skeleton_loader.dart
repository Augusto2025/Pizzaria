import 'package:flutter/material.dart';
import 'package:pizza/core/constants/app_colors.dart';

/// Skeleton loading widget with shimmer effect
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  /// Circular skeleton (for avatars, images)
  SkeletonLoader.circular({
    super.key,
    required double diameter,
    this.baseColor,
    this.highlightColor,
  }) : width = diameter,
       height = diameter,
       borderRadius = BorderRadius.circular(diameter / 2);

  /// Rectangular skeleton (for text, cards, containers)
  const SkeletonLoader.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? AppColors.surfaceVariant;
    final highlightColor = widget.highlightColor ?? AppColors.surface;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(baseColor, highlightColor, _animation.value),
            borderRadius: widget.borderRadius,
          ),
        );
      },
    );
  }
}

/// Skeleton for text lines
class SkeletonText extends StatelessWidget {
  final int lines;
  final double? width;
  final double height;
  final double spacing;

  const SkeletonText({
    super.key,
    this.lines = 3,
    this.width,
    this.height = 16,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (index) {
        final isLast = index == lines - 1;
        final lineWidth = width ?? (isLast ? 200.0 : double.infinity);
        return Padding(
          padding: EdgeInsets.only(bottom: index < lines - 1 ? spacing : 0),
          child: SkeletonLoader.rectangular(
            width: lineWidth,
            height: height,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        );
      }),
    );
  }
}

/// Skeleton for list items (cards)
class SkeletonListItem extends StatelessWidget {
  final bool hasImage;
  final bool hasSubtitle;
  final double height;

  const SkeletonListItem({
    super.key,
    this.hasImage = true,
    this.hasSubtitle = true,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (hasImage) ...[
            SkeletonLoader.rectangular(
              width: 80,
              height: 80,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonText(lines: 1, width: double.infinity, height: 18, spacing: 0),
                const SizedBox(height: 8),
                if (hasSubtitle)
                  SkeletonText(lines: 2, width: 150, height: 14, spacing: 6),
              ],
            ),
          ),
          SkeletonLoader.rectangular(
            width: 60,
            height: 24,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ],
      ),
    );
  }
}

/// Skeleton for grid items (product cards)
class SkeletonGridItem extends StatelessWidget {
  const SkeletonGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image skeleton
            SkeletonLoader.rectangular(
              width: double.infinity,
              height: 140,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            const SizedBox(height: 12),
            // Title skeleton
            SkeletonText(lines: 1, width: double.infinity, height: 18, spacing: 0),
            const SizedBox(height: 8),
            // Description skeleton
            SkeletonText(lines: 2, width: double.infinity, height: 14, spacing: 6),
            const SizedBox(height: 12),
            // Price + button skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoader.rectangular(width: 80, height: 20),
                SkeletonLoader.rectangular(
                  width: 50,
                  height: 36,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for order card
class SkeletonOrderCard extends StatelessWidget {
  const SkeletonOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: SkeletonText(lines: 1, width: double.infinity, height: 18)),
                const SizedBox(width: 12),
                SkeletonLoader.rectangular(
                  width: 100,
                  height: 24,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SkeletonText(lines: 1, width: 150, height: 14),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SkeletonLoader.rectangular(width: 80, height: 28),
                SkeletonLoader.rectangular(width: 100, height: 28),
                SkeletonLoader.rectangular(width: 150, height: 28),
              ],
            ),
            const SizedBox(height: 12),
            Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: 12),
            SkeletonText(lines: 1, width: 120, height: 14),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for cart item
class SkeletonCartItem extends StatelessWidget {
  const SkeletonCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SkeletonLoader.rectangular(
              width: 70,
              height: 70,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonText(lines: 1, width: double.infinity, height: 18),
                  const SizedBox(height: 8),
                  SkeletonText(lines: 1, width: 150, height: 14),
                  const SizedBox(height: 8),
                  SkeletonText(lines: 1, width: 100, height: 16),
                ],
              ),
            ),
            Column(
              children: [
                SkeletonLoader.rectangular(width: 100, height: 36),
                const SizedBox(height: 8),
                SkeletonText(lines: 1, width: 80, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for promotion card
class SkeletonPromotionCard extends StatelessWidget {
  const SkeletonPromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader.rectangular(
              width: 80,
              height: 20,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            const Spacer(),
            SkeletonText(lines: 1, width: double.infinity, height: 22),
            const SizedBox(height: 8),
            SkeletonText(lines: 1, width: 150, height: 16),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for quick action card
class SkeletonQuickActionCard extends StatelessWidget {
  const SkeletonQuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SkeletonLoader.circular(diameter: 56),
          const SizedBox(height: 10),
          SkeletonText(lines: 1, width: double.infinity, height: 14),
        ],
      ),
    );
  }
}

/// Skeleton for user info card (profile)
class SkeletonUserInfoCard extends StatelessWidget {
  const SkeletonUserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SkeletonLoader.circular(diameter: 96),
            const SizedBox(height: 16),
            SkeletonText(lines: 1, width: 180, height: 24),
            const SizedBox(height: 8),
            SkeletonText(lines: 1, width: 220, height: 16),
            const SizedBox(height: 4),
            SkeletonText(lines: 1, width: 160, height: 16),
            const SizedBox(height: 16),
            SkeletonLoader.rectangular(
              width: 150,
              height: 44,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton for profile menu option
class SkeletonProfileOption extends StatelessWidget {
  const SkeletonProfileOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: SkeletonLoader.circular(diameter: 44),
        title: SkeletonText(lines: 1, width: 120, height: 18),
        subtitle: SkeletonText(lines: 1, width: 180, height: 14),
        trailing: SkeletonLoader.circular(diameter: 24),
      ),
    );
  }
}

/// Shimmer effect wrapper for custom skeletons
class ShimmerSkeleton extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShimmerSkeleton({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}