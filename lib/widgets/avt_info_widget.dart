import 'package:flutter/material.dart';
import 'package:travel_plan/models/user.dart';
import 'package:travel_plan/styles/colors.dart';

class EditableAvatar extends StatelessWidget {
  final String pathUrl;

  const EditableAvatar({
    required this.pathUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container chứa avatar  và nút chỉnh sửa
      margin: EdgeInsets.only(bottom: 32),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50, // Độ lớn của avatar
            backgroundImage: NetworkImage(
              pathUrl,
            ), // Ảnh avatar
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Xử lý khi avatar được nhấp
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFBBB00),
                  radius: 15,
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
