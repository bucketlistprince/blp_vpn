import 'package:flutter/material.dart';

class VPNButton extends StatefulWidget {
  final bool isConnected;
  final VoidCallback onPressed;
  final bool isConnecting; // New parameter to indicate connection progress

  const VPNButton({
    Key? key,
    required this.isConnected,
    required this.onPressed,
    this.isConnecting = false,
  }) : super(key: key);

  @override

  _VPNButtonState createState() => _VPNButtonState();
}

class _VPNButtonState extends State<VPNButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: widget.isConnected ? Colors.green : Colors.red,
            side: BorderSide(
              color: widget.isConnecting
                  ? Colors.yellow.withOpacity(_animation.value)
                  : (widget.isConnected ? Colors.green : Colors.red),
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
          child: Text(
            widget.isConnected ? 'Disconnect' : 'Connect',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
    );
  }
}
