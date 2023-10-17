import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData?
      rightIcon; // Tandai sebagai nullable menggunakan tanda tanya (?)
  final String page;
  final Function? leftCallback;
  final Function?
      rightCallback; // Tandai sebagai nullable menggunakan tanda tanya (?)

  CustomAppBar(this.leftIcon, this.page,
      {this.rightIcon, this.leftCallback, this.rightCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback!() : null,
            child: _buildIcon(leftIcon),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              page,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (rightIcon != null) // Tambahkan kondisi ini
            GestureDetector(
              onTap: rightCallback != null ? () => rightCallback!() : null,
              child: _buildIcon(rightIcon!),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon),
    );
  }
}
