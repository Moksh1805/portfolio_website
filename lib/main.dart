import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moksh Khodakiya - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6C63FF),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          //headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
      home: PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  PortfolioHome({super.key});

  // --- Resume data extracted from your PDF ---
  final String name = 'Moksh Khodakiya';
  final String title = 'Mobile Application Developer';
  final String email = 'mokshkhodakiya@gmail.com';
  final String phone = '+91 8866258760';
  final String location = 'Ahmedabad';
  final String linkedIn = 'https://www.linkedin.com/in/moksh-khodakiya';

  final List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Android (Java/Kotlin)',
    'PHP',
    'MySQL',
    'SQLite',
    'Firebase',
    'REST APIs',
    'Git'
  ];

  final List<Project> projects = [
    Project(
      title: 'Automatic Timetable Generator',
      short:
      'Dynamic timetable generator (Android/Web) with export to PDF and scheduling logic.',
      tech: 'Flutter, Dart',
      asset: 'assets/project1.png',
    ),
    Project(
      title: 'Quick Fix',
      short:
      'Service-request platform connecting users with appliance technicians; MySQL + PHP backend.',
      tech: 'Java, PHP, MySQL',
      asset: 'assets/project2.png',
    ),
    Project(
      title: 'Tuition Management System',
      short:
      'Web portal for student/tutor management, attendance and fee tracking.',
      tech: 'HTML, CSS, JS, PHP, MySQL',
      asset: 'assets/project3.png',
    ),
  ];

  final List<ExperienceItem> experiences = [
    ExperienceItem(
      company: 'Creart Pvt. Ltd.',
      role: 'Flutter Developer',
      duration: 'July 2025',
      details:
      'Working on scalable cross-platform applications, clean architecture & responsive UI.',
    ),
    ExperienceItem(
      company: 'Route4u (Remote)',
      role: 'Android Developer Intern',
      duration: 'April 2024 – October 2024',
      details:
      'Built and optimized Android apps, collaborated with cross-functional teams; published app on Play Store.',
    ),
  ];

  final List<EducationItem> education = [
    EducationItem(
      institution: 'Sal Institute of Tech. & Eng. Research (GTU)',
      degree: 'B.Tech. in Computer Engineering',
      duration: 'Aug 2023 – June 2026 (Ongoing)',
      extra: '',
    ),
    EducationItem(
      institution: 'C.U. Shah Government Polytechnic (GTU)',
      degree: 'Diploma in Computer Engineering',
      duration: 'Aug 2020 – June 2023',
      extra: 'CGPA: 8.89',
    ),
    EducationItem(
      institution: 'Shri S.N. Vidyalaya (GSEB)',
      degree: 'Secondary School Certificate (SSC)',
      duration: 'May 2020',
      extra: 'Percentage: 71.66',
    ),
  ];

  final List<String> certificates = [
    'Flutter Development Course – Simplilearn | July 2025',
    'Software Engineering Virtual Experience – Accenture (Forage) | June 2025',
    'Technology Job Simulation – Deloitte (Forage) | June 2025',
    'Cybersecurity Analyst Job Simulation – Deloitte (Forage) | July 2025',
  ];

  // --- helper to open urls / mailto ---
  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // ignore errors for now
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(name, style: const TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              // scroll to projects in a more advanced app; for now no-op
            },
            child: const Text('Projects', style: TextStyle(color: Color(0xFF1F2937))),
          ),
          TextButton(
            onPressed: () {
              // open resume download placeholder
            },
            child: const Text('Download Resume', style: TextStyle(color: Color(0xFF6C63FF))),
          ),
          const SizedBox(width: 16)
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HERO
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, I\'m $name 👋',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: const Color(0xFF111827),
                                )),
                            const SizedBox(height: 8),
                            Text('A Passionate Flutter & Full-stack Developer',
                                style: TextStyle(fontSize: 22, color: const Color(0xFF374151))),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 520,
                              child: Text(
                                'Building clean apps, solving problems, and designing creative solutions.',
                                style: TextStyle(fontSize: 16, color: const Color(0xFF6B7280)),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => _launch('mailto:$email'),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                                    backgroundColor: MaterialStateProperty.all(const Color(0xFF6C63FF)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                  ),
                                  child: const Text('Hire Me'),
                                ),
                                const SizedBox(width: 12),
                                OutlinedButton(
                                  onPressed: () {
                                    // Scroll to projects, not implemented in this simplified sample
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 18, vertical: 14)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                  ),
                                  child: const Text('View Projects'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: const AssetImage('assets/profile.jpg'),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 36),

                  // ABOUT + SKILLS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('About Me', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                            const SizedBox(height: 8),
                            const SizedBox(height: 6),
                            Text(
                              'I\'m a results-driven Computer Engineering student with a solid foundation in Android application development and working knowledge of Flutter and cross-platform mobile frameworks. Skilled in designing, developing, and deploying user-centric mobile applications, with a focus on performance, scalability, and clean UI/UX.',
                              style: TextStyle(color: const Color(0xFF6B7280)),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'I enjoy solving complex problems, troubleshooting, and contributing to fast-paced development teams. I have hands-on experience with REST APIs, databases and production-ready app deployment.',
                              style: TextStyle(color: const Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: skills.map((s) {
                                    return Chip(
                                      label: Text(s),
                                      backgroundColor: const Color(0xFFF3F4F6),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Projects + Experience
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Featured Projects', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Column(
                              children: projects.map((p) => ProjectCard(project: p)).toList(),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Experience', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Column(
                              children: experiences.map((e) {
                                return ExperienceTile(exp: e);
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Education + Certificates
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Education', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Column(
                              children: education.map((ed) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(ed.institution, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text('${ed.degree} • ${ed.duration}\n${ed.extra}'),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Certificates', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: certificates.map((c) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text('• $c', style: const TextStyle(color: Color(0xFF374151))),
                              )).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Testimonials placeholder and Contact
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Testimonials', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Text(
                                  'Moksh is a highly skilled developer who consistently delivers quality work. Attention to detail and ability to collaborate effectively.',
                                  style: TextStyle(color: const Color(0xFF374151)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Contact', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('Email\n$e', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('Phone\n$phone', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _launch('mailto:$email'),
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
                              child: const Text('Email Me'),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () => _launch(linkedIn),
                              child: const Text('LinkedIn'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Footer
                  const Center(child: Text('© 2025 Moksh Khodakiya', style: TextStyle(color: Color(0xFF9CA3AF)))),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String get e => email;
}

class Project {
  final String title;
  final String short;
  final String tech;
  final String asset;
  Project({required this.title, required this.short, required this.tech, required this.asset});
}

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 120,
                height: 200,
                child: Image.asset(
                  project.asset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF3F4F6),
                    child: const Icon(Icons.image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(project.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(project.short, style: const TextStyle(color: Color(0xFF6B7280))),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(project.tech)),
                    ElevatedButton(
                      onPressed: () {
                        // placeholder for "View Case Study"
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)),
                      child: const Text('View Case Study'),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class ExperienceItem {
  final String company, role, duration, details;
  ExperienceItem({required this.company, required this.role, required this.duration, required this.details});
}

class ExperienceTile extends StatelessWidget {
  final ExperienceItem exp;
  const ExperienceTile({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(radius: 16, backgroundColor: const Color(0xFFEEF2FF), child: const Icon(Icons.work, color: Color(0xFF6C63FF), size: 18)),
      title: Text(exp.company, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${exp.role} • ${exp.duration}'),
          const SizedBox(height: 6),
          Text(exp.details, style: const TextStyle(color: Color(0xFF6B7280))),
        ],
      ),
      trailing: TextButton(onPressed: () {}, child: const Text('View Case Study')),
    );
  }
}

class EducationItem {
  final String institution, degree, duration, extra;
  EducationItem({required this.institution, required this.degree, required this.duration, required this.extra});
}
