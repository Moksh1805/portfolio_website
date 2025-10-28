import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moksh Khodakiya | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Dark Theme Setup
        scaffoldBackgroundColor: const Color(0xFF121212),
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          // Define a modern font if you include one (e.g., GoogleFonts.poppins)
          bodyMedium: TextStyle(color: Color(0xFFE0E0E0)),
          displayLarge: TextStyle(color: Color(0xFFE0E0E0), fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Color(0xFF00FF99), fontWeight: FontWeight.w500),
          titleLarge: TextStyle(color: Color(0xFFE0E0E0), fontWeight: FontWeight.bold),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF99), // Accent color
          surface: Color(0xFF1E1E1E), // Card background
        ),
      ),
      home: PortfolioHomePage(),
    );
  }
}

// -----------------------------------------------------
// Primary Colors and Constants
// -----------------------------------------------------
//const Color _kAccentColor = Color(0xFF00FF99);
//const Color _kDarkBgLight = Color(0xFF1E1E1E);
//const Color _kTextColorMedium = Color(0xFFA0A0A0);
const Color _kTextColorLight = Color(0xFFE0E0E0);


const Color _kAccentColor = Color(0xFF00FF99);
const Color _kDarkBgLight = Color(0xFF1E1E1E);
const Color _kTextColorMedium = Color(0xFFA0A0A0);
const double _kPadding = 80.0;
const Color _kDarkBg = Color(0xFF121212);
const double _kMobilePadding = 30.0; // Responsive padding for smaller screens



// Helper function for responsive padding
EdgeInsets _getResponsivePadding(double screenWidth, {double vertical = 0.0}) {
  final double horizontalPadding = screenWidth < 600 ? _kMobilePadding : _kPadding;
  return EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: vertical);
}

final GlobalKey _homeKey = GlobalKey();
final GlobalKey _educationKey = GlobalKey();
final GlobalKey _projectsKey = GlobalKey();
final GlobalKey _experienceKey = GlobalKey();
final GlobalKey _certificationsKey = GlobalKey();

String activeSection = 'HOME';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsiveness (basic)
    final screenWidth = MediaQuery.of(context).size.width;

    final Map<String, GlobalKey> sectionKeys = {
      'HOME': _homeKey,
      'ABOUT': _homeKey, // Assuming 'About' scrolls to the Hero Section
      'EDUCATION': _educationKey,
      'PROJECTS': _projectsKey,
      'EXPERIENCE': _experienceKey,
      'CERTIFICATIONS': _certificationsKey,
      // 'CONTACT': _homeKey, // Footer is usually the contact section
    };

    return Scaffold(
      endDrawer: MobileDrawer(
        sectionKeys: sectionKeys,
        onSectionClicked: (sectionKey) {
          setState(() {
            activeSection = sectionKey; // Update active section
          });
        },
      ),
      body: Column(
        children: [
          Navbar(sectionKeys: sectionKeys),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // 1. Navigation Bar
                  //const Navbar(),
                  //Navbar(sectionKeys: sectionKeys),
                  // 2. Hero Section
                  Padding(
                    key: _homeKey, // ASSIGN KEY HERE
                    padding: _getResponsivePadding(screenWidth, vertical: 100.0),
                    child: HeroSection(screenWidth: screenWidth),
                  ),
                  // 3. Skills Section (NEWLY MODIFIED)
                  Padding(
                    padding: _getResponsivePadding(screenWidth, vertical: 50.0),
                    child: const SkillsSection(),
                  ),
                  Padding(
                    key: _experienceKey,
                    padding: _getResponsivePadding(screenWidth).copyWith(bottom: 100.0),
                    child: const ExperienceSection(), // Renamed and modified
                  ),
                  // 4. Projects Grid (Now a full section)
                  Padding(
                    key: _projectsKey, // ASSIGN KEY HERE
                    padding: _getResponsivePadding(screenWidth).copyWith(bottom: 100.0),
                    child: const ProjectsSection(),// Renamed and modified
                  ),
                  Padding(
                    key: _certificationsKey,
                    padding: _getResponsivePadding(screenWidth).copyWith(bottom: 100.0),
                    child: const CertificationsSection(), // Renamed and modified
                  ),
                  Padding(
                    key: _educationKey,
                    padding: _getResponsivePadding(screenWidth).copyWith(bottom: 100.0),
                    child: const EducationSection(), // Renamed and modified
                  ),
                  // 5. Footer
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------
// 1. Navbar Widget (Unchanged)
// -----------------------------------------------------

class Navbar extends StatefulWidget {
  final Map<String, GlobalKey> sectionKeys;
  const Navbar({super.key, required this.sectionKeys});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String activeSection = 'Home';
  @override
  Widget build(BuildContext context) {
    // Determine screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800; // Define your breakpoint

    return Container(
      padding: _getResponsivePadding(screenWidth, vertical: 20.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'MK',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _kAccentColor,
            ),
          ),

          // Switch between Row (Desktop) and IconButton (Mobile)
          if (isLargeScreen)
          // Desktop/Web Navigation (Row)
            Row(
              children: <Widget>[
                NavLink(text: 'HOME',  targetKey: widget.sectionKeys['HOME'],
                  isActive: activeSection == 'Home',
                  onSectionClicked: () {
                  setState(() => activeSection = 'Home');
                },),

                NavLink(text: 'EXPERIENCE', targetKey: widget.sectionKeys['EXPERIENCE'],
                  isActive: activeSection == 'Experience',
                  onSectionClicked: () {
                    setState(() => activeSection = 'Experience');
                  },), // NEW LINK
                NavLink(text: 'PROJECTS', targetKey: widget.sectionKeys['PROJECTS'],
                  isActive: activeSection == 'Projects',
                  onSectionClicked: () {
                    setState(() => activeSection = 'Projects');
                  },),

                NavLink(text: 'CERTIFICATIONS', targetKey: widget.sectionKeys['CERTIFICATIONS'] ,
                  isActive: activeSection == 'Certificates',
                  onSectionClicked: () {
                    setState(() => activeSection = 'Certificates');
                  },),
                NavLink(text: 'EDUCATION', targetKey: widget.sectionKeys['EDUCATION'],
                  isActive: activeSection == 'Education',
                  onSectionClicked: () {
                    setState(() => activeSection = 'Education');
                  },
                ),
                // NEW LINK
                //NavLink(text: 'CONTACT', targetKey: widget.sectionKeys['CONTACT']),
              ],
            )
          else
          // Mobile Navigation (Hamburger Icon)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: _kAccentColor),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Use endDrawer for right-side menu
                },
              ),
            ),
        ],
      ),
    );
  }
}

// class NavLink extends StatelessWidget {
//   final String text;
//   final bool isActive;
//   final bool isDrawerItem; // New flag for styling drawer items
//   final GlobalKey? targetKey;
//   final VoidCallback? onPressed;
//
//   const NavLink({super.key, required this.text, this.isActive = false, this.isDrawerItem = false, this.targetKey, this.onPressed});
//
//   void _scrollToTarget(BuildContext context) {
//     if (targetKey?.currentContext != null) {
//       Scrollable.ensureVisible(
//         targetKey!.currentContext!,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//         alignment: 0.0, // Scroll to the top of the target widget
//       );
//     }
//     // Close drawer after navigation on mobile
//     if (isDrawerItem) {
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // If it's a drawer item, use different padding and styling
//     if (isDrawerItem) {
//       return ListTile(
//         title: Text(
//           text,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//             color: isActive ? _kAccentColor : Theme.of(context).textTheme.bodyMedium!.color,
//           ),
//         ),
//         onTap: () =>  _scrollToTarget(context)
//       );
//     }
//
//     // Default Desktop/Row link style
//     return Padding(
//       padding: const EdgeInsets.only(left: 40.0),
//       child: GestureDetector(
//         onTap: () => _scrollToTarget(context),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               text,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                   //color: isActive ? _kAccentColor : _kAccentColor,
//                 color: isActive ? _kAccentColor : Theme.of(context).textTheme.bodyMedium!.color,
//               ),
//             ),
//             if (isActive)
//               Container(
//                 margin: const EdgeInsets.only(top: 5),
//                 height: 2,
//                 width: 30,
//                 color: _kAccentColor,
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }

class NavLink extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isDrawerItem;
  final GlobalKey? targetKey;
  final VoidCallback? onSectionClicked; // 👈 added callback to notify parent

  const NavLink({
    super.key,
    required this.text,
    this.isActive = false,
    this.isDrawerItem = false,
    this.targetKey,
    this.onSectionClicked,
  });

  void _scrollToTarget(BuildContext context) {
    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }

    // 👇 Notify parent which section was clicked
    onSectionClicked?.call();

    // Close drawer after navigation on mobile
    if (isDrawerItem) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? _kAccentColor
        : Theme.of(context).textTheme.bodyMedium!.color;

    if (isDrawerItem) {
      return ListTile(
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        onTap: () => _scrollToTarget(context),
      );
    }

    // Default Desktop / Row link style
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: GestureDetector(
        onTap: () => _scrollToTarget(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 2,
                width: 30,
                color: _kAccentColor,
              ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------
// 1b. Mobile Drawer Widget (Unchanged)
// -----------------------------------------------------

class MobileDrawer extends StatelessWidget {
  final Map<String, GlobalKey> sectionKeys;
  final Function(String) onSectionClicked; // Correct type

  const MobileDrawer({
    super.key,
    required this.sectionKeys,
    required this.onSectionClicked,
  });

  void _scrollToSection(BuildContext context, String sectionKey) {
    final targetKey = sectionKeys[sectionKey];
    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
    onSectionClicked(sectionKey); // Notify parent
    Navigator.pop(context); // Close drawer
  }

  // Convert keys like 'HOME' to 'Home' for display
  String _formatSectionName(String key) {
    return key[0].toUpperCase() + key.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: _kAccentColor),
            child: Text(
              'MOKSH KHODAKIYA',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Generate drawer items dynamically
          ...sectionKeys.entries.map((entry) {
            return ListTile(
              title: Text(
                _formatSectionName(entry.key),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => _scrollToSection(context, entry.key),
            );
          }).toList(),
        ],
      ),
    );
  }
}
// -----------------------------------------------------
// 2. Hero Section Widget (Unchanged)
// -----------------------------------------------------

class HeroSection extends StatelessWidget {
  final double screenWidth;
  HeroSection({super.key, required this.screenWidth});

  String linkedinurl = "www.linkedin.com/in/moksh-khodakiya-104b20289";
  String github ="https://github.com/Moksh1805";

  void _launchURL(String url) async {
    // 1. Ensure the URL has a scheme (e.g., https://) for proper launching
    String finalUrl = url.startsWith('http') || url.startsWith('mailto:') ? url : 'https://$url';

    final uri = Uri.parse(finalUrl);

    // Check if the URL can be opened
    if (await canLaunchUrl(uri)) {
      // Launch the URL (opens in new tab on web/desktop)
      await launchUrl(uri);
    } else {
      // Handle the error (e.g., print to console)
      print('Could not launch $finalUrl. Check url_launcher setup.');
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      // Optional: You can pre-fill subject or body
      query: 'subject=Hello&body=I want to connect with you',
    );

    if (!await launchUrl(emailUri)) {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a constraint for large screens to keep content centered and readable
    final contentWidth = screenWidth > 1200 ? 1200.0 : screenWidth - (_kPadding * 2);

    // Determines if the layout should be vertical (small screen) or horizontal (large screen)
    final isLargeScreen = screenWidth > 800;

    Widget profileImage = Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _kAccentColor, width: 3),
        // Placeholder for the actual image
        image: const DecorationImage(
          image: AssetImage('assets/images/moksh.png'), // Add your photo to assets folder!
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget textInfo = Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: isLargeScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'MOKSH KHODAKIYA',
            style: TextStyle(fontSize: 48, letterSpacing: 2.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Text(
          //   'MOBILE APPLICATION DEVELOPER | FLUTTER DEVELOPER | SOFTWARE DEVELOPER',
          //   style: TextStyle(fontSize: 18, color: _kAccentColor, letterSpacing: 1.5),
          // ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "I'm ",
                style: TextStyle(
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24,
                  //fontWeight: FontWeight.bold,
                  color: _kAccentColor,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 500),
                  animatedTexts: [
                    TyperAnimatedText('Mobile Application Developer'),
                    TyperAnimatedText('Flutter Developer'),
                    TyperAnimatedText('Android Developer'),
                    TyperAnimatedText('Software Developer'),
                    TyperAnimatedText('Database Analyst'),
                    TyperAnimatedText('Software Analyst'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Results-driven and highly motivated Computer Engineering student with a solid foundation in Android application development and working knowledge of Flutter and cross-platform mobile frameworks. Skilled in designing, developing, and deploying user-centric mobile applications, with a focus on performance, scalability, and clean UI/UX. Adept at troubleshooting, debugging, and solving complex technical issues using structured problem-solving techniques. Eager to contribute to fast-paced development teams through a challenging internship, while expanding hands-on experience with emerging technologies and full-stack application architecture.',
            style: TextStyle(fontSize: 18, color: _kTextColorMedium),
            textAlign: isLargeScreen ? TextAlign.start : TextAlign.center,
          ),
          const SizedBox(height: 10),

          Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => _launchURL(linkedinurl),
                      icon: Image.asset('assets/images/Footer_logo/linkedin.png',height: 25, width: 25,)
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () => _launchURL(github),
                      icon: Image.asset('assets/images/Footer_logo/github.png',height: 25, width: 25,)
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset("assets/images/Footer_logo/email.png" , height: 25, width: 25,),
                  const SizedBox(width: 10),
                  SelectableText("mokshkhodakiya@gmail.com" , style: const TextStyle(decoration: TextDecoration.underline,),)
                  //InkWell(child: Text("mokshkhodakiya@gmail.com"),onTap: () {Clipboard.setData(ClipboardData(text: 'mokshkhodakiya@gmail.com'));Clipboard.setData(ClipboardData(text: 'mokshkhodakiya@gmail.com'));},),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset("assets/images/Footer_logo/phone.png" , height: 25, width: 25,),
                  const SizedBox(width: 10),
                  SelectableText("+91 8866258760" , style: const TextStyle(decoration: TextDecoration.underline,),)
                ],
              )
            ],
          ),
          const SizedBox(height: 10),

          // OutlinedButton.icon(
          //   icon: const Icon(Icons.download, color: _kAccentColor),
          //   label: const Text('RESUME'),
          //   onPressed: () async {
          //     // *** IMPORTANT: REPLACE THIS URL WITH YOUR ACTUAL RESUME LINK (e.g., a link to a PDF stored on Google Drive or your website) ***
          //     const resumeUrl = 'https://drive.google.com/uc?export=view&id=1DwP-BZpnlPzuIZ206uxPZa5_pI7-M8_x';
          //     final uri = Uri.parse(resumeUrl);
          //
          //     if (await canLaunchUrl(uri)) {
          //       await launchUrl(uri, mode: LaunchMode.externalApplication); // Use externalApplication to open PDF in a new window/tab
          //     } else {
          //       print('Could not launch resume link: $resumeUrl');
          //       // You could add a user-facing error message here
          //     }
          //   },
          //   style: OutlinedButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          //     side: const BorderSide(color: _kAccentColor, width: 2),
          //     foregroundColor: _kAccentColor,
          //     textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          //   ),
          // ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              side: const BorderSide(color: _kAccentColor, width: 2),
              foregroundColor: _kAccentColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            icon: const Icon(Icons.download, color: _kAccentColor),
            label: const Text('RESUME'),
            onPressed: () async {
              const resumeUrl = 'https://drive.google.com/file/d/1DwP-BZpnlPzuIZ206uxPZa5_pI7-M8_x/view';
              final uri = Uri.parse(resumeUrl);

              if (kIsWeb) {
                // ✅ On Flutter Web: open in new tab
                await launchUrl(uri, webOnlyWindowName: '_blank');
              } else {
                // ✅ On mobile/desktop: open in external browser or Drive app
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unable to open resume link')),
                  );
                }
              }
            },
          )
        ],
      ),
    );

    return Center(
      child: SizedBox(
        width: contentWidth,
        child: isLargeScreen
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImage,
            const SizedBox(width: 80),
            Expanded(child: textInfo),
          ],
        )
            : Column(
          // Centered on small screens
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            profileImage,
            const SizedBox(height: 50),
            textInfo,
          ],
        ),
      ),
    );
  }
}


class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  // Use ScrollController for ListView
  final ScrollController _scrollController = ScrollController();
  late final List<SkillData> skills;
  late final Timer _timer;

  // Constants for auto-scrolling
  final Duration _scrollDuration = const Duration(seconds: 3); // Time between scroll steps
  final Duration _animationDuration = const Duration(milliseconds: 1000); // Speed of the animation
  final double _scrollIncrement = 150.0; // The distance to scroll in each step (adjust for card size)

  // Sample skills data (remains the same)
  final List<SkillData> originalSkills = [
    SkillData(name: 'Flutter', logoPath: 'assets/images/Skills_logo/flutter.png', icon: Icons.flutter_dash),
    SkillData(name: 'Dart', logoPath: 'assets/images/Skills_logo/dart.png', icon: Icons.code),
    SkillData(name: 'Android', logoPath: 'assets/images/Skills_logo/android.png', icon: Icons.phone_android),
    SkillData(name: 'Java', logoPath: 'assets/images/Skills_logo/java.png', icon: Icons.data_object),
    SkillData(name: 'Kotlin', logoPath: 'assets/images/Skills_logo/kotlin.png', icon: Icons.data_object),
    SkillData(name: 'Firebase', logoPath: 'assets/images/Skills_logo/firebase.png', icon: Icons.local_fire_department),
    SkillData(name: 'Git', logoPath: 'assets/images/Skills_logo/git.png', icon: Icons.edit_square),
    SkillData(name: 'SQL', logoPath: 'assets/images/Skills_logo/sql.png', icon: Icons.storage),
    SkillData(name: 'PostgreSQL', logoPath: 'assets/images/Skills_logo/postgresql.png', icon: Icons.storage),
    // Duplicate the list to ensure there are always items to scroll to
    SkillData(name: 'Flutter', logoPath: 'assets/images/Skills_logo/flutter.png', icon: Icons.flutter_dash),
    SkillData(name: 'Dart', logoPath: 'assets/images/Skills_logo/dart.png', icon: Icons.code),
    SkillData(name: 'Android', logoPath: 'assets/images/Skills_logo/android.png', icon: Icons.phone_android),
    SkillData(name: 'Java', logoPath: 'assets/images/Skills_logo/java.png', icon: Icons.data_object),
    SkillData(name: 'Kotlin', logoPath: 'assets/images/Skills_logo/kotlin.png', icon: Icons.data_object),
    SkillData(name: 'Firebase', logoPath: 'assets/images/Skills_logo/firebase.png', icon: Icons.local_fire_department),
    SkillData(name: 'Git', logoPath: 'assets/images/Skills_logo/git.png', icon: Icons.edit_square),
    SkillData(name: 'REST APIs', logoPath: 'assets/images/Skills_logo/sql.png', icon: Icons.storage),
    SkillData(name: 'SQL', logoPath: 'assets/images/Skills_logo/postgresql.png', icon: Icons.storage),
  ];

  @override
  void initState() {
    super.initState();
    // Use the duplicated list to easily handle looping in ListView.builder
    skills = [...originalSkills, ...originalSkills];
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(_scrollDuration, (Timer timer) {
      if (!_scrollController.hasClients) return;

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;

      // Check if we are near the end of the first set of items (halfway through the duplicated list)
      // If true, jump to the start instantly to create a seamless loop
      if (currentScroll >= (maxScroll / 2)) {
        _scrollController.jumpTo(0.0);
        currentScroll = 0.0; // Reset current scroll position after jump
      }

      double targetScroll = currentScroll + _scrollIncrement;

      _scrollController.animateTo(
        targetScroll,
        duration: _animationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'SKILLS & TECHNOLOGIES',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: isLargeScreen ? 36 : 28),
              ),
            ),
            const SizedBox(height: 50),
            // Horizontal Scroller (ListView.builder)
            SizedBox(
              height: screenWidth < 600 ? 150 : 200, // Fixed height for the scroller
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(), // Allow user interaction
                itemCount: skills.length, // Double the original length for looping
                itemBuilder: (context, index) {
                  // The cards will be sized by their content and padding,
                  // filling the space naturally.
                  return Padding(
                    padding: const EdgeInsets.only(right: 25.0), // Space between cards
                    child: SizedBox(
                      width: screenWidth < 600 ? 120 : 150, // Fixed width for the card
                      child: SkillCard(skill: skills[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class SkillData {
  final String name;
  final String? logoPath;
  final IconData? icon;
  SkillData({required this.name, this.logoPath, this.icon});
}

// Skill Card widget (remains the same)
class SkillCard extends StatelessWidget {
  final SkillData skill;
  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kDarkBgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccentColor.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: skill.logoPath != null
                  ? Image.asset(
                skill.logoPath!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(skill.icon ?? Icons.code, size: 40, color: _kAccentColor.withOpacity(0.7));
                },
              )
                  : Icon(skill.icon ?? Icons.code, size: 40, color: _kAccentColor.withOpacity(0.7)),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            skill.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE0E0E0),
            ),
          ),
        ],
      ),
    );
  }
}

// ... (Rest of the code like ProjectsSection, ProjectCard, Footer, etc., remains the same)

class ExperienceData {
  final String role;
  final String company;
  final String duration;
  final String location;
  final List<String> responsibilities;

  ExperienceData({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.responsibilities,
  });
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  // Sample Data (Replace with your actual experience)


  @override
  Widget build(BuildContext context) {
    final List<ExperienceData> experienceList = [
      ExperienceData(
        role: 'Flutter Developer',
        company: 'CreArt Solution Pvt. Ltd. , Ahmedabad',
        duration: '2 July 2025 - 16 July 2025',
        location: 'On-site',
        responsibilities: const [
          'Learn to Develop scalable cross-platform mobile applications using Flutter and Dart, with a focus on clean architecture and responsive UI/UX design.',
          'Assisting in state management and performance optimization across multiple modules.'
        ],
      ),
      ExperienceData(
        role: 'Android Development Intern',
        company: 'Route4U',
        duration: '25 Apr 2024 - 25 Oct 2024',
        location: 'Remote',
        responsibilities: const [
          'Built and optimized Android applications using Kotlin, contributing to front-end design, debugging, and performance tuning.',
          'Collaborated remotely with cross-functional teams, applying version control (Git) and agile methodologies for efficient task management.'
          'Delivered project components on time while ensuring code quality, maintainability, and adherence to industry standards.',
          'Contributed to a production-ready application currently published and available on the Google Play Store.'
        ],
      ),
      // ExperienceData(
      //   role: 'Junior Developer Intern',
      //   company: 'Tech Startup Hub',
      //   duration: 'May 2018 - Jul 2019',
      //   location: 'San Francisco, CA',
      //   responsibilities: const [
      //     'Assisted the lead team in debugging and testing new features for the flagship product.',
      //     'Wrote technical documentation for internal development processes.',
      //     'Gained foundational experience in Git version control and Agile methodology.',
      //   ],
      // ),
    ];

    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'WORK EXPERIENCE',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: isLargeScreen ? 36 : 28,
                  fontWeight: FontWeight.bold,
                  color: _kAccentColor,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Vertical Timeline Builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experienceList.length,
              itemBuilder: (context, index) {
                return TimelineItem(
                  data: experienceList[index],
                  isLast: index == experienceList.length - 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}


// ------------------------------------------------------------------
// 5b. Timeline Item (Renders a single job entry)
// ------------------------------------------------------------------

class TimelineItem extends StatelessWidget {
  final ExperienceData data;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.data,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    // Use a Row for desktop/tablet and Column for mobile
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Left Column (Duration/Role on Mobile) ---
            SizedBox(
              width: isMobile ? screenWidth * 0.4 : 200, // Fixed width on Desktop, relative on mobile
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    data.duration,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _kAccentColor, // Highlight the duration
                    ),
                  ),
                  if (isMobile) const SizedBox(height: 5),
                  if (isMobile)
                    Text(
                      data.role,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _kTextColorLight,
                      ),
                    ),
                ],
              ),
            ),

            // --- Middle Column (Timeline Connector) ---
            SizedBox(
              width: 50,
              child: Column(
                children: <Widget>[
                  // Dot
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kAccentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: _kDarkBg, width: 2),
                    ),
                  ),
                  // Line
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isLast ? Colors.transparent : _kAccentColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            // --- Right Column (Details) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Role (Desktop/Tablet)
                    if (!isMobile)
                      Text(
                        data.role,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _kTextColorLight,
                        ),
                      ),

                    const SizedBox(height: 5),

                    // Company & Location
                    Text(
                      '${data.company} • ${data.location}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kTextColorMedium,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Responsibilities (Bullet Points)
                    ...data.responsibilities.map((responsibility) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: _kAccentColor, fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                responsibility,
                                style: const TextStyle(color: _kTextColorMedium, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// -----------------------------------------------------
// 4. Projects Section Widget (Renamed and Structured - Unchanged from last iteration)
// -----------------------------------------------------

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;

    // Adjust grid count based on screen size
    int crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 900
        ? 2
        : 3;

    List<ProjectData> projects = [
      ProjectData(
        title: "Quiz Ninja",
        tech: "Flutter, Dart ",
        tag: "CROSS PLATFORM",
        description: '-  Developed a cross-platform quiz app that reduced faculty effort by 70% by automatically extracting MCQs from uploaded PDF files. \n\n-  Designed a streamlined workflow to collect quiz details (title, marks, availability window), cutting quiz setup time from ~30 mins to <5 mins. \n\n-  Implemented a feature to generate unique shareable quiz links, enabling faculty to distribute tests instantly to 100+ students simultaneously. \n\n-  Built participant-side functionality for students to take quizzes directly via links, with automatic score calculation and secure response storage, improving evaluation accuracy by 90%.',
        mockupPath: 'assets/images/Project_logo/quiz_ninja.png',
      ),
      ProjectData(
        title: 'Automatic Timetable Generator',
        tech: 'Flutter, Dart',
        tag: 'CROSS PLATFORM',
        description: '-  Developed a dynamic, user-driven timetable generator that automates scheduling based on custom inputs such as lectures, working days, and time slots. \n\n-  Implemented responsive UI, real-time data validation, and logic-based automation to ensure accuracy and flexibility. \n\n-  Integrated PDF export functionality, enabling users to directly download and save generated timetables to their system. \n\n-  Applied logical reasoning and data structure concepts to dynamically manage lecture slots, resolve conflicts, and auto-generate optimized schedules.',
        mockupPath: 'assets/images/Project_logo/Automatic_timetable_generator.png',
      ),
      ProjectData(
        title: 'Quick Fix',
        tech: 'Java, XML, PHP, MySQL',
        tag: 'ANDROID DEV',
        description: '-  Built a service-request platform that connects users with home appliance technicians through appointment scheduling and request tracking. \n\n-  Integrated PHP-based RESTful APIs and MySQL backend to manage real-time service operations and data flow. \n\n-  Designed intuitive UI/UX and ensured data security and reliability across user and technician workflows.',
        mockupPath: 'assets/images/Project_logo/quick_fix.png',
      ),
      ProjectData(
        title: 'Tuition Management System',
        tech: 'HTML, CSS, JavaScript, PHP, MySQL',
        tag: 'WEB APP',
        mockupPath: 'assets/images/Project_logo/Tution_management_system.png',
        description: '-  Developed a centralized portal for managing students, tutors, attendance, and fee records. \n\n-  Implemented admin controls for data entry, report generation, and performance tracking. \n\n-  Ensured secure database operations and seamless frontend-backend synchronization.\n\n-  Designed a responsive interface using standard web technologies for smooth accessibility.',
      ),
      // ProjectData(
      //   title: 'Quick Fix',
      //   tech: 'Java, XML, PHP, MySQL',
      //   tag: 'ANDROID DEV',
      //   mockupPath: 'assets/images/Project_logo/Automatic_timetable_generator.png',
      //   description: 'A mobile application designed to simplify the process of creating academic timetables. It uses complex constraint-solving algorithms (like backtracking) to generate clash-free schedules based on lecturer availability, subject constraints, and room capacity. Features include real-time data sync via Firebase and local database persistence.',
      // ),
      // ProjectData(
      //   title: 'Tuition Management System',
      //   tech: 'HTML, CSS, JavaScript, PHP, MySQL',
      //   tag: 'WEB APP',
      //   mockupPath: 'assets/images/Project_logo/Automatic_timetable_generator.png',
      //   description: 'A mobile application designed to simplify the process of creating academic timetables. It uses complex constraint-solving algorithms (like backtracking) to generate clash-free schedules based on lecturer availability, subject constraints, and room capacity. Features include real-time data sync via Firebase and local database persistence.',
      // ),
    ];

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'FEATURED PROJECTS',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: isLargeScreen ? 36 : 28),
              ),
            ),
            const SizedBox(height: 50),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Important for SingleChildScrollView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 40.0,
                mainAxisSpacing: 40.0,
                childAspectRatio: 0.9, // Adjust card height
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(data: projects[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectData data;
  const ProjectCard({super.key, required this.data});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;
  void _showProjectDetails(BuildContext context, ProjectData data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProjectDetailsDialog(data: data);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true), // Set state on hover
      onExit: (_) => setState(() => _isHovering = false), // Reset state on exit
      //cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: _kDarkBgLight,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.data.tag,
                style: const TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Placeholder for Project Visual/Mockup
            Expanded(
              // The visual area is now wrapped in a Stack
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // A. Base Visual Area (Original content with UNCONDITIONAL border)
                  Container(
                    //padding: EdgeInsets.all(0.2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2a2a2a),
                      borderRadius: BorderRadius.circular(8),
                      // Border applied UNCONDITIONALLY as requested in the previous step
                      border: Border.all(color: _kAccentColor.withOpacity(0.5), width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.data.mockupPath, // <<< USE IMAGE.ASSET HERE
                        //fit: BoxFit.cover,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              'Image Not Found: ${widget.data.title}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: _kTextColorMedium),
                            ),
                          );
                        },
                        //Icon(Icons.code, size: 50, color: _kTextColorMedium),
                      ),
                    ),
                  ),

                  // B. Hover Overlay (The transparent screen and button)
                  AnimatedOpacity(
                    opacity: _isHovering ? 1.0 : 0.0, // Fades based on hover state
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7), // The transparent screen effect
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ElevatedButton.icon(
                          // On press, show the details dialog
                          onPressed: () => _showProjectDetails(context, widget.data),
                          icon: const Icon(Icons.info_outline, color: Color(0xFF121212)),
                          label: const Text(
                            'VIEW DETAILS',
                            style: TextStyle(color: Color(0xFF121212), fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kAccentColor,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.data.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              'Technologies: ${widget.data.tech}',
              style: const TextStyle(fontSize: 14, color: _kTextColorMedium),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProjectCard extends StatefulWidget {
//   final ProjectData data;
//   const ProjectCard({super.key, required this.data});
//
//   @override
//   State<ProjectCard> createState() => _ProjectCardState();
// }
//
// class _ProjectCardState extends State<ProjectCard> {
//   bool _isHovering = false;
//
//   // UPDATED: This function now defines a simple dialog structure
//   // that incorporates both the description AND the technology stack (data.tech).
//   void _showProjectDetails(BuildContext context, ProjectData data) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: _kDarkBgLight,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//             side: const BorderSide(color: _kAccentColor, width: 2),
//           ),
//           content: Container(
//             constraints: const BoxConstraints(maxWidth: 600),
//             padding: const EdgeInsets.all(10),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     data.title,
//                     style: const TextStyle(fontSize: 24, color: _kAccentColor, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//
//                   // NEW LOCATION FOR TECHNOLOGY STACK
//                   Text(
//                     'Tech Stack: ${data.tech}',
//                     style: const TextStyle(fontSize: 16, color: _kTextColorMedium, fontStyle: FontStyle.italic),
//                   ),
//
//                   const Divider(color: _kTextColorMedium, height: 30),
//
//                   // PROJECT DESCRIPTION
//                   Text(
//                     data.description,
//                     style: const TextStyle(fontSize: 16, color: _kTextColorLight),
//                   ),
//                   const SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text('CLOSE', style: TextStyle(color: _kAccentColor, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _isHovering = true),
//       onExit: (_) => setState(() => _isHovering = false),
//       child: Container(
//         decoration: BoxDecoration(
//           color: _kDarkBgLight,
//           borderRadius: BorderRadius.circular(12),
//           // Subtle shadow added for better hover effect
//           boxShadow: [
//             if (_isHovering)
//               BoxShadow(
//                 color: _kAccentColor.withOpacity(0.4),
//                 blurRadius: 12,
//                 spreadRadius: 3,
//               )
//             else
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 6,
//               ),
//           ],
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // 1. TAG (Fixed height by content)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: _kAccentColor,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 widget.data.tag,
//                 style: const TextStyle(
//                   color: Color(0xFF121212),
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//
//             // 2. PROJECT VISUAL/MOCKUP AREA (FIXED HEIGHT)
//             SizedBox(
//               height: 180, // <<< REDUCED FROM 200 TO 180 TO FIX OVERFLOW
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // A. Base Visual Area (The actual image)
//                   Container(
//                     decoration: BoxDecoration(
//                       color: _kDarkBgLight, // Use light background for image container
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: _kAccentColor.withOpacity(0.5), width: 1),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.asset(
//                         widget.data.mockupPath,
//                         fit: BoxFit.contain, // Ensures the whole image is visible
//                         errorBuilder: (context, error, stackTrace) {
//                           return Center(
//                             child: Text(
//                               'Image Not Found: ${widget.data.title}',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(color: _kTextColorMedium),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//
//                   // B. Hover Overlay (The transparent screen and button)
//                   AnimatedOpacity(
//                     opacity: _isHovering ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 200),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.75),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: ElevatedButton.icon(
//                           onPressed: () => _showProjectDetails(context, widget.data),
//                           icon: const Icon(Icons.info_outline, color: Color(0xFF121212)),
//                           label: const Text(
//                             'VIEW DETAILS',
//                             style: TextStyle(color: Color(0xFF121212), fontWeight: FontWeight.bold),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: _kAccentColor,
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             // 3. TITLE (Fixed height by font size/TextStyle)
//             Text(
//               widget.data.title,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: _kTextColorLight),
//               maxLines: 1, // Ensures only one line is used for the title
//               overflow: TextOverflow.ellipsis,
//             ),
//
//             // The Technologies Text widget has been permanently removed from the card layout.
//
//           ],
//         ),
//       ),
//     );
//   }
// }


class ProjectData {
  final String title;
  final String tech;
  final String tag;
  final String description; // <<< ADDED FIELD
  final String mockupPath;

  ProjectData({
    required this.title,
    required this.tech,
    required this.tag,
    required this.description, // <<< REQUIRED IN CONSTRUCTOR
    required this.mockupPath,
  });
}



// class ProjectData {
//   final String title;
//   final String tech;
//   final String tag;
//   ProjectData({required this.title, required this.tech, required this.tag});
// }

class ProjectDetailsDialog extends StatelessWidget {
  final ProjectData data;
  const ProjectDetailsDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 600;

    // NOTE: Use your defined colors (_kAccentColor, etc.)
    const Color _kAccentColor = Color(0xFF00FF99);
    const Color _kTextColorMedium = Color(0xFFA0A0A0);

    return AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A), // Dark surface for the dialog
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: _kAccentColor, width: 2),
      ),
      contentPadding: EdgeInsets.zero,
      // Constrain the width for desktop view
      content: Container(
        width: isDesktop ? 600 : screenWidth * 0.9,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title and Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 28, color: _kAccentColor),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: _kTextColorMedium),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(color: _kTextColorMedium, thickness: 0.5, height: 20),

              // Project Details
              // ... (Other detail texts like Tag and Technologies)

              const SizedBox(height: 20),

              Text(
                'Description:',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
              ),
              const SizedBox(height: 5),
              Text(
                data.description, // <<< DISPLAY THE DESCRIPTION
                style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFE0E0E0)),
              ),

              const SizedBox(height: 30),

              // ... (Optional action buttons like View Code)
            ],
          ),
        ),
      ),
    );
  }
}

class EducationData {
  final String degree;
  final String institution;
  final String duration;
  final String location;
  final String? gradeOrPercentage;
  // Removed: final List<String> highlights;

  const EducationData({
    required this.degree,
    required this.institution,
    required this.duration,
    required this.location,
    this.gradeOrPercentage,
  });
}

class EducationItem extends StatelessWidget {
  final EducationData data;
  final bool isLast;

  const EducationItem({
    super.key,
    required this.data,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Left Column (Duration/Degree on Mobile) ---
            SizedBox(
              width: isMobile ? screenWidth * 0.4 : 200,
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Text(
                    data.duration,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _kAccentColor,
                    ),
                  ),
                  if (data.gradeOrPercentage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        data.gradeOrPercentage!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: _kTextColorMedium, // Subtle color for the grade
                        ),
                      ),
                    ),
                  if (isMobile) const SizedBox(height: 5),
                  if (isMobile)
                    Text(
                      data.degree,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _kTextColorLight,
                      ),
                    ),
                ],
              ),
            ),

            // --- Middle Column (Timeline Connector) ---
            SizedBox(
              width: 50,
              child: Column(
                children: <Widget>[
                  // Dot
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _kAccentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: _kDarkBg, width: 2),
                    ),
                  ),
                  // Line
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isLast ? Colors.transparent : _kAccentColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),

            // --- Right Column (Details) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Degree (Desktop/Tablet)
                    if (!isMobile)
                      Text(
                        data.degree,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _kTextColorLight,
                        ),
                      ),

                    const SizedBox(height: 5),

                    // Institution & Location
                    Text(
                      '${data.institution} • ${data.location}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kTextColorMedium,
                      ),
                    ),

                    // Removed Highlights section to simplify the layout.
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  final List<EducationData> educationList = const [
    // EducationData(
    //   degree: 'Master of Science in Computer Science',
    //   institution: 'Georgia Institute of Technology (Georgia Tech)',
    //   duration: 'Aug 2024 - May 2026',
    //   location: 'Atlanta, GA',
    // ),
    EducationData(
      degree: 'Bachelor of Technology in Computer Engineering',
      institution: 'SAL Institute of Technology and Engineering Research (GTU)',
      duration: 'Aug 2023 - Present',
      location: 'Ahmedabad, Gujarat, India',
      gradeOrPercentage: '7.33/10 CGPA',
    ),
    // Added a third university entry to the data
    EducationData(
      degree: 'Post Graduate Diploma in Computer Engineering',
      institution: 'C.U. Shah Government Polytechnic (GTU)',
      duration: 'Aug 2020 - Aug 2023',
      gradeOrPercentage: '8.89/10 CGPA',
      location: 'Surendranagar, Gujarat, India',
    ),
    EducationData(
      degree: 'SSC 10th',
      institution: 'Shri S.N. Vidhyalaya (GSEB)',
      duration: 'April 2019 - May 2020',
      gradeOrPercentage: '71.66 %',
      location: 'Surendranagar, Gujarat, India',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'EDUCATION',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: isLargeScreen ? 36 : 28,
                  fontWeight: FontWeight.bold,
                  color: _kAccentColor,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Vertical Timeline Builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: educationList.length,
              itemBuilder: (context, index) {
                return EducationItem(
                  data: educationList[index],
                  isLast: index == educationList.length - 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CertificationData {
  final String name;
  final String authority;
  final String date;
  final List<String> skills;
  final String verificationLink; // Optional: for link to the certificate

  const CertificationData({
    required this.name,
    required this.authority,
    required this.date,
    required this.skills,
    this.verificationLink = '#',
  });
}

class CertificateCard extends StatefulWidget {
  final CertificationData data;
  const CertificateCard({super.key, required this.data});

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          // Implement URL launching logic here using a package like url_launcher
          // launchUrl(Uri.parse(widget.data.verificationLink));
          print('Navigating to verification link: ${widget.data.verificationLink}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: _kDarkBgLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovering ? _kAccentColor : _kAccentColor.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: _isHovering
                ? [
              BoxShadow(
                color: _kAccentColor.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]
                : [],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Certificate Icon & Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.verified_user, color: _kAccentColor, size: 30),
                  Text(
                    widget.data.date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _kTextColorMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // 2. Certificate Name
              Text(
                widget.data.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _kTextColorLight,
                ),
              ),
              const SizedBox(height: 5),

              // 3. Authority
              Text(
                'Issued by ${widget.data.authority}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _kAccentColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 15),

              // 4. Skills Learned
              const Text(
                'Key Skills:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kTextColorLight,
                ),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: Wrap(
                  spacing: 8.0, // Gap between chips
                  runSpacing: 8.0, // Gap between lines of chips
                  children: widget.data.skills.map((skill) {
                    return Chip(
                      label: Text(
                        skill,
                        style: const TextStyle(fontSize: 12, color: _kDarkBgLight),
                      ),
                      backgroundColor: _kAccentColor.withOpacity(0.9),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ------------------------------------------------------------------
// 3. Certifications Section Widget
// ------------------------------------------------------------------

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  final List<CertificationData> certifications = const [
    CertificationData(
      name: 'Flutter Development Course',
      authority: 'Simplilearn',
      date: 'Jul 2025',
      skills: ['Flutter', 'Dart', 'State Management (Provider)', 'OOP' ,'UI Design'],
      verificationLink: 'https://www.udemy.com/certificate/123456789/',
    ),
    CertificationData(
      name: 'Software Engineering Virtual Experience',
      authority: 'Accenture (Forage, India)',
      date: 'Jun 2025',
      skills: ['SDLC' , 'Debugging' , 'Agile Development' , 'Software Analysis'],
    ),
    CertificationData(
      name: 'Technology Job Simulation ',
      authority: 'Deloitte (Forage)',
      date: 'Jun 2025',
      skills: ['Data Structures', 'Project Management', 'Critical Thinking', 'Communication','Dynamic Programming'],
    ),
    CertificationData(
      name: 'Cybersecurity Analyst Job Simulation ',
      authority: 'Deloitte (Forage)',
      date: 'Jun 2025',
      skills: ['Cyber Security' ,'Web Security','Threat Analysis' , 'Risk Assessment'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;

    // Adjust grid count based on screen size
    int crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 1000
        ? 2
        : 3;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: _getResponsivePadding(screenWidth, vertical: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'CERTIFICATIONS & COURSES',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: isLargeScreen ? 36 : 28,
                  fontWeight: FontWeight.bold,
                  color: _kAccentColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Important for SingleChildScrollView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
                childAspectRatio: 1.1, // Adjusted for a rectangular card with enough space for skills
              ),
              itemCount: certifications.length,
              itemBuilder: (context, index) {
                return CertificateCard(data: certifications[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}



// -----------------------------------------------------
// 5. Footer Widget (Unchanged)
// -----------------------------------------------------


// -----------------------------------------------------
// FooterLink Widget (UPDATED)
// -----------------------------------------------------

class FooterLink extends StatelessWidget {
  final String text;
  final String url;
  final Widget icon; // Passed as a Widget (Image.asset)

  const FooterLink({super.key, required this.text, required this.url, required this.icon});

  // Function to handle URL launching
  void _launchURL(String url) async {
    // 1. Ensure the URL has a scheme (e.g., https://) for proper launching
    String finalUrl = url.startsWith('http') || url.startsWith('mailto:') ? url : 'https://$url';

    final uri = Uri.parse(finalUrl);

    // Check if the URL can be opened
    if (await canLaunchUrl(uri)) {
      // Launch the URL (opens in new tab on web/desktop)
      await launchUrl(uri);
    } else {
      // Handle the error (e.g., print to console)
      print('Could not launch $finalUrl. Check url_launcher setup.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () => _launchURL(url), // Calling the launch function
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(10.0),
          foregroundColor: _kAccentColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon, // The logo widget
            const SizedBox(height: 4),
            Text(
              text,
              style: const TextStyle(
                color: _kTextColorMedium,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------
// Footer Widget (UPDATED with correct URLs and Images)
// -----------------------------------------------------

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      decoration: const BoxDecoration(
        color: _kDarkBgLight,
        border: Border(top: BorderSide(color: Color(0xFF2a2a2a), width: 1)),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: _getResponsivePadding(screenWidth).copyWith(top: 0, bottom: 0),
          child: Column(
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: <Widget>[
                  // LinkedIn Link
                  FooterLink(
                    text: 'LinkedIn',
                    url: 'www.linkedin.com/in/moksh-khodakiya-104b20289',
                    icon: Image.asset('assets/images/Footer_logo/linkedin.png', height: 28 , width: 28,),
                  ),
                  // GitHub Link
                  FooterLink(
                    text: 'GitHub',
                    url: 'https://github.com/Moksh1805',
                    icon: Image.asset('assets/images/Footer_logo/github.png', height: 28 , width: 28,),
                  ),
                  // Email Link
                  // FooterLink(
                  //   text: 'Email',
                  //   url: 'mailto:mokshkhodakiya@gmail.com',
                  //   icon: Image.asset('assets/images/Footer_logo/email.png' , height: 28 , width: 28,),
                  // ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                '© 2024 MOKSH KHODAKIYA. ALL RIGHTS RESERVED.',
                style: TextStyle(fontSize: 14, color: _kTextColorMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
