import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shayarispot2/Constent/AppInfo/appInfo.dart';
import 'package:shayarispot2/Constent/Colors/Apptheme.dart';
import 'package:shayarispot2/Pages/EditorPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';
import '../../Constent/AppInfo/FontNames.dart';
import '../../Pages/SavedPage.dart';

Drawer AppDrawer(context, {tabindex, onclick}) {
  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Apptheme.splashColor,
          ),
          accountName: const Text(
            'Welcome To',
            style: TextStyle(fontSize: 10),
          ),
          accountEmail: Text(
            Appinfo.title,
            style: TextStyle(fontSize: 19, fontFamily: fontNames[5]),
          ),
          currentAccountPicture: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'assets/logo.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
        ListTile(
          selected: tabindex == 0,
          selectedColor: Apptheme.secendery,
          leading: const Icon(
            FontAwesomeIcons.home,
            size: 17,
          ),
          title: const Text('Home'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () {
            Navigator.of(context).pop();
            onclick(0);
          },
        ),
        ListTile(
          selected: tabindex == 1,
          selectedColor: Apptheme.secendery,
          leading: const Icon(
            FontAwesomeIcons.boxes,
            size: 17,
          ),
          title: const Text('Categories'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () {
            Navigator.of(context).pop();
            onclick(1);
          },
        ),

        ListTile(
          selectedColor: Apptheme.secendery,
          leading: const Icon(
            FontAwesomeIcons.paintbrush,
            size: 17,
          ),
          title: const Text('Shayari Editor'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditorPage(),
            ));
          },
        ),

        ListTile(
          selectedColor: Apptheme.secendery,
          leading: const Icon(
            FontAwesomeIcons.solidHeart,
            size: 17,
          ),
          title: const Text('Your Favorite'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SavedPage(),
            ));
          },
        ),

        ListTile(
          selected: tabindex == 3,
          selectedColor: Apptheme.secendery,
          leading: const Icon(
            FontAwesomeIcons.image,
            size: 17,
          ),
          title: const Text('Image Shayari'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () {
            Navigator.of(context).pop();
            onclick(3);
          },
        ),

        ListTile(
          leading: const Icon(
            FontAwesomeIcons.star,
            size: 17,
          ),
          title: const Text('Rating App'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () async {
            await StoreRedirect.redirect(
                androidAppId: "com.codexsourav.shayarispot");
          },
        ),

        // about us page
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.person,
            size: 17,
          ),
          title: const Text('About Us'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () async {
            final Uri url0 = Uri.parse(Appinfo.aboutus);
            await launchUrl(url0, mode: LaunchMode.externalApplication);
          },
        ),
        // privacy policy page
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.shield,
            size: 17,
          ),
          title: const Text('Privacy Policy'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () async {
            final Uri url0 = Uri.parse(Appinfo.privacypolicy);
            await launchUrl(url0, mode: LaunchMode.externalApplication);
          },
        ),
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.phone,
            size: 17,
          ),
          title: const Text('Contact Us'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          onTap: () async {
            final Uri url0 = Uri.parse(Appinfo.contactus);
            await launchUrl(url0, mode: LaunchMode.externalApplication);
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.pink,
                size: 17,
              ),
              title: const Text('Follow ME'),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                final Uri url0 = Uri.parse(Appinfo.instagram);
                await launchUrl(url0, mode: LaunchMode.externalApplication);
              },
            ),
          ),
        ),
      ],
    ),
  );
}
