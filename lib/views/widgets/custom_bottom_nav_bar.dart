import 'package:flutter/material.dart';

import 'package:anystay/models/bottom_nav_item.dart';

import 'package:anystay/theme/theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
// final screenWidth = MediaQuery.of(context).size.width;

// final itemWidth = screenWidth / bottomNavItems.length;

// final bubblePosition = (itemWidth * currentIndex) + (itemWidth / 2) - 30;

    return Container(
      height: 100,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 75,
                color: AppTheme.primaryColor,
              )),

// AnimatedPositioned(

// duration: Duration(microseconds: 300),

// curve: Curves.easeIn,

// bottom: 60,

// left: bubblePosition,

// child: Container(

// width: 60,

// height: 30,

// decoration: BoxDecoration(

// color: AppTheme.primaryColor,

// borderRadius: const BorderRadius.only(

// topLeft: Radius.circular(30),

// topRight: Radius.circular(30),

// ),

// ),

//

// ),),

          Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Row(
                  children: List.generate(
                bottomNavItems.length,
                (index) {
                  return _buildNavIcon(index, context);
                },
              )))
        ],
      ),
    );
  }

  Widget _buildNavIcon(int index, BuildContext context) {
    final item = bottomNavItems[index];
    final isActive = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Transform for smooth raising animation
            Transform.translate(
              offset: Offset(0, isActive ? -25 : 0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: isActive ? 70 : 35,
                height: isActive ? 70 : 35,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icon centered

                    Icon(
                      isActive ? item.selectedIcon : item.unSelectedIcon,
                      size: isActive ? 45 : 35,
                      color: AppTheme.secondaryColor,
                    ),

                    const Spacer(),
                    // Label positioned at bottom with AnimatedOpacity
                    Positioned(
                      top: 55,
                      child: AnimatedOpacity(
                        opacity: isActive ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: Text(item.label,
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
