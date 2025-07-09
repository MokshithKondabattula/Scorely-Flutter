import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFF0087FF),
          elevation: 0.0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 11),
            child: Row(
              children: [
                Text(
                  'More',
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 2),

            Material(
              color: Colors.white,
              child: SizedBox(
                height: 48,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 15),
                  onTap: () {},
                  leading: Icon(
                    Icons.person_outline_outlined,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    'Browse Player',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1),
            Material(
              color: Colors.white,
              child: SizedBox(
                height: 48,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 15),
                  onTap: () {},
                  leading: Icon(
                    Icons.timelapse_outlined,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    'Archives',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 19),
            Material(
              color: Colors.white,
              child: SizedBox(
                height: 48,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 15),
                  onTap: () {},
                  leading: Icon(
                    Icons.timeline_outlined,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    'Records',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1),
            Material(
              color: Colors.white,
              child: SizedBox(
                height: 48,
                child: ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.only(left: 14),
                  leading: Icon(Icons.feedback, color: Colors.grey[600]),
                  title: Text(
                    'Feedback',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFE6F0FF),
    );
  }
}
