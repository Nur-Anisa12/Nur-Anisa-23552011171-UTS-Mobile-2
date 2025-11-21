enum StatusMahasiswa { aktif, cuti, lulus }

class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final List<String> hobi;
  final List<Skill> skill;
  final StatusMahasiswa status;
  final String foto;
  final String angkatan;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.hobi,
    required this.skill,
    required this.status,
    required this.foto,
    required this.angkatan,
  });

  String getStatusText() {
    switch (status) {
      case StatusMahasiswa.aktif:
        return 'Aktif';
      case StatusMahasiswa.cuti:
        return 'Cuti';
      case StatusMahasiswa.lulus:
        return 'Lulus';
    }
  }

  int getJumlahHobi() {
    return hobi.length;
  }

  int getJumlahSkill() {
    return skill.length;
  }

  List<Skill> getSkillByLevel(int minLevel) {
    return skill.where((s) => s.level >= minLevel).toList();
  }
}

class Skill {
  final String nama;
  final int level; // 1-5
  final String icon;

  Skill({required this.nama, required this.level, required this.icon});

  String getLevelText() {
    if (level == 1) return 'Pemula';
    if (level == 2) return 'Menengah';
    if (level == 3) return 'Mahir';
    if (level == 4) return 'Expert';
    return 'Master';
  }
}
