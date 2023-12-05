import 'package:flutter/material.dart';

class GroupListItem extends StatelessWidget {
  const GroupListItem(
      {super.key, required this.name, required this.mesg, this.containerWidth});
  final String name;
  final String mesg;
  final containerWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.1, vertical: 1),
        leading: CircleAvatar(
          child: Image.asset(
            'assets/images/PNG Icons/CustomButtons001.png',
          ),
          radius: 50,
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        subtitle: Text(
          mesg,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
