import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final String images;
  final dynamic nextScreen;
  final String text;
  final double height;
  final double width;

  const SplashPage({
    super.key,
    required this.height,
    required this.width,
    required this.images,
    required this.nextScreen,
    required this.text,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ));
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-5, 0),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeIn),
  );

  @override
  void initState() {
    _controller.forward();
    super.initState();
    splashScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> splashScreen() async {
    await Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return widget.nextScreen;
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.images,
                        package: 'splashpage_package'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SlideTransition(
                    textDirection: TextDirection.rtl,
                    position: _offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(_controller),
                        child: Text(
                          widget.text,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
