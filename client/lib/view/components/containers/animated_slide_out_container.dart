import 'package:flutter/material.dart';

class AnimatedSlideOutContainer extends StatelessWidget {
  final bool isVisible;
  final String title;
  final VoidCallback onExit;
  final Animation<double> animation;
  final Widget content;

  const AnimatedSlideOutContainer({
    super.key,
    required this.isVisible,
    required this.title,
    required this.onExit,
    required this.animation,
    required this.content,
  });
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        right: isVisible ? 0 : -300,
        top: 0,
        bottom: 0,
        width: screenWidth > 500 ? 500 : screenWidth,
        child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero, 
              ).animate(animation),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.0),
                      blurRadius: 5,
                      offset: const Offset(-2, 0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, size: 24),
                          onPressed: onExit,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                            width: 24),
                      ],
                    ),
                    content,
                  ],
                ),
              ),
            )));
  }
}
