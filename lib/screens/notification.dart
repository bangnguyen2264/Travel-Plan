import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travel_plan/styles/colors.dart';
import '../widgets/appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppBar(title: 'Thông báo'),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0)),
                    contentPadding: EdgeInsets.all(20),
                    fillColor: AppColors.neutral_8,
                    filled: true,
                    hintText: "Search notification",
                    prefixIcon: const Icon(Icons.search)),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: ((context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                              extentRatio: .3,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  icon: Icons.reply,
                                  backgroundColor: AppColors.neutral_6,
                                ),
                                SlidableAction(
                                  onPressed: (context) {},
                                  icon: Icons.delete,
                                  backgroundColor: AppColors.errorColor,
                                )
                              ]),
                          child: const ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/avt.png"),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Thông báo"),
                                Text(
                                  "2h",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "Đây là thông báo dàiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) => Divider(
                            color: AppColors.neutral_7,
                            indent: deviceWidth * 0.8,
                            endIndent: deviceWidth * 0.8,
                          ),
                      itemCount: 10))
            ],
          ),
        ));
  }
}

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sử dụng một container để căn chỉnh hình ảnh và văn bản
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/images/empty-noti.png',
                      width: 0.8 *
                          deviceWidth, // Đặt kích thước của hình ảnh theo nhu cầu
                      height: 0.3 * deviceHeight,
                      fit: BoxFit.contain),
                ),
                // SizedBox(height: 100), // Khoảng cách giữa hình ảnh và văn bản
                Text(
                  "Bạn chưa có thông báo mới",
                  style: TextStyle(color: Color(0xFF757575)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
