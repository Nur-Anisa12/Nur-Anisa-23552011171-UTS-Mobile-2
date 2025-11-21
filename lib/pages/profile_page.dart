import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/profile.dart';
import '../widgets/info_card.dart';
import '../widgets/skill_item.dart';
import '../widgets/hobby_item.dart';

class ProfilPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ProfilPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Data Profile
  final Profile myProfile = Profile(
    nama: 'Nur Anisa',
    nim: '23552011171',
    jurusan: 'Teknik Informatika',
    email: 'anur6253@gmail.com',
    telepon: '+62 896-5774-2962',
    angkatan: '2023',
    foto: 'assets/images/Pas-Foto.png',
    status: StatusMahasiswa.aktif,
    hobi: ['Menonton Film', 'Membaca Buku', 'Gaming', 'Musik'],
    skill: [
      Skill(nama: 'Flutter', level: 1, icon: '📱'),
      Skill(nama: 'Dart', level: 1, icon: '🎯'),
      Skill(nama: 'Git', level: 1, icon: '🔀'),
      Skill(nama: 'UI/UX', level: 2, icon: '🎨'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildAppBar(),
            _buildProfileHeader(),
            _buildInfoSection(),
            _buildSkillSection(),
            _buildHobbySection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ==========================
  // APP BAR (CURVED HEADER) - RESPONSIVE SCROLL
  // ==========================
  Widget _buildAppBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Hitung progress scroll (0.0 - 1.0)
    final double maxScroll = 200.0;
    final double scrollProgress = (_scrollOffset / maxScroll).clamp(0.0, 1.0);

    // Animasi tinggi header saat scroll
    final double minHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;
    final double maxHeight = screenHeight * 0.25;
    final double currentHeight =
        maxHeight - ((maxHeight - minHeight) * scrollProgress);

    return Container(
      width: screenWidth,
      height: currentHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDarkMode
              ? [const Color(0xFF5B4FE8), const Color(0xFF8B5FBF)]
              : [const Color(0xFF5B6FFF), const Color(0xFFB76FD8)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30 * (1 - scrollProgress)),
          bottomRight: Radius.circular(30 * (1 - scrollProgress)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1 + (0.1 * scrollProgress)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles - fade out saat scroll
          Opacity(
            opacity: 1 - scrollProgress,
            child: Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 1 - scrollProgress,
            child: Positioned(
              left: screenWidth * 0.6,
              top: screenHeight * 0.08,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 1 - scrollProgress,
            child: Positioned(
              left: screenWidth * 0.1,
              bottom: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48), // Balance for theme button
                      Expanded(
                        child: Center(
                          child: Text(
                            'Profile App',
                            style: GoogleFonts.poppins(
                              fontSize:
                                  (screenWidth * 0.07) *
                                  (1 -
                                      scrollProgress *
                                          0.3), // Mengecil saat scroll
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Theme Toggle Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            widget.isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.white,
                          ),
                          onPressed: widget.toggleTheme,
                          tooltip: 'Toggle Theme',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================
  // PROFILE HEADER
  // ==========================
  Widget _buildProfileHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.15; // Responsif 15% dari lebar layar

    return Transform.translate(
      offset: const Offset(0, -40), // Overlap dengan header
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: avatarRadius - 4,
                      backgroundImage: myProfile.foto.startsWith('assets/')
                          ? AssetImage(myProfile.foto) as ImageProvider
                          : NetworkImage(myProfile.foto),
                    ),
                  ),
                ),
                Positioned(bottom: 0, right: 0, child: _buildStatusBadge()),
              ],
            ),

            const SizedBox(height: 16),

            // Nama
            Text(
              myProfile.nama,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.06, // Responsif
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // NIM
            Text(
              myProfile.nim,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // Responsif
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            // Status
            _buildStatusText(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final bool isActive = myProfile.status == StatusMahasiswa.aktif;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.orange,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 3,
        ),
      ),
      child: const Icon(Icons.check, color: Colors.white, size: 16),
    );
  }

  Widget _buildStatusText() {
    final bool isActive = myProfile.status == StatusMahasiswa.aktif;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.green : Colors.orange),
      ),
      child: Text(
        myProfile.getStatusText(),
        style: TextStyle(
          color: isActive ? Colors.green[700] : Colors.orange[700],
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.035, // Responsif
        ),
      ),
    );
  }

  // ==========================
  // INFORMASI PRIBADI
  // ==========================
  Widget _buildInfoSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final infoList = [
      {
        'icon': FontAwesomeIcons.graduationCap,
        'title': 'Jurusan',
        'value': myProfile.jurusan,
        'color': Colors.blue,
      },
      {
        'icon': FontAwesomeIcons.calendar,
        'title': 'Angkatan',
        'value': myProfile.angkatan,
        'color': Colors.green,
      },
      {
        'icon': FontAwesomeIcons.envelope,
        'title': 'Email',
        'value': myProfile.email,
        'color': Colors.red,
      },
      {
        'icon': FontAwesomeIcons.phone,
        'title': 'Telepon',
        'value': myProfile.telepon,
        'color': Colors.purple,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pribadi',
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.05, // Responsif
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...infoList.map(
            (info) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InfoCard(
                icon: info['icon'] as IconData,
                title: info['title'] as String,
                value: info['value'] as String,
                iconColor: info['color'] as Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================
  // SKILLS
  // ==========================
  Widget _buildSkillSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    // Responsif: 2 kolom untuk layar kecil, 3 untuk tablet, 4 untuk desktop
    int crossAxisCount = screenWidth < 600 ? 2 : (screenWidth < 900 ? 3 : 4);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skills',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05, // Responsif
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildSkillBadge(),
            ],
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: myProfile.skill.length,
            itemBuilder: (context, index) {
              return SkillItem(skill: myProfile.skill[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBadge() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${myProfile.getJumlahSkill()} Skills',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.03, // Responsif
        ),
      ),
    );
  }

  // ==========================
  // HOBBY
  // ==========================
  Widget _buildHobbySection() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hobi & Minat',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05, // Responsif
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildHobbyBadge(),
            ],
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
              myProfile.hobi.length,
              (index) => HobbyItem(hobby: myProfile.hobi[index], index: index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbyBadge() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${myProfile.getJumlahHobi()} Hobi',
        style: TextStyle(
          color: Colors.orange[700],
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.03, // Responsif
        ),
      ),
    );
  }
}
