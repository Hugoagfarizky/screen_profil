# Naskah Video: Aplikasi Profil Flutter

Durasi sekitar 7 menit (batas 10 menit).
Layar: VS Code di kiri, emulator di kanan.
Tulisan dalam tanda kutip = yang diucapkan. Tulisan miring = yang dilakukan.

Cara tiap widget: **tunjuk di emulator → buka file dan baris kodenya → ucapkan penjelasan singkat.**

---

## PEMBUKA

> "Halo, saya Muh Nugraha Yubi Agfarizky, NRP 5051241034, jurusan Inovasi Digital ITS.
> Ini aplikasi profil saya yang berjalan di Android Emulator. Saya akan jelaskan widget yang dipakai satu per satu: ada di mana di layar, kodenya yang mana, dan fungsinya apa."

---

## WIDGET PER WIDGET

### 1. Scaffold
- **Di layar:** seluruh halaman
- **File:** `screens/profile_screen.dart`, baris 109
```dart
Scaffold(
  body: ...
```
> "Scaffold adalah kerangka dasar satu halaman. Isi halamannya ditaruh di body."

### 2. SafeArea
- **Di layar:** area di bawah jam dan baterai HP
- **File:** `screens/profile_screen.dart`, baris 110
```dart
body: SafeArea(
  bottom: false,
```
> "SafeArea menjaga isi supaya tidak tertutup jam dan baterai di atas layar."

### 3. SingleChildScrollView
- **Di layar:** seluruh halaman. *Gulir layar ke bawah.*
- **File:** `screens/profile_screen.dart`, baris 112
```dart
child: SingleChildScrollView(
  child: Column(
```
> "SingleChildScrollView membuat isinya bisa digulir ke bawah."

### 4. Column
- **Di layar:** susunan semua bagian dari atas ke bawah
- **File:** `screens/profile_screen.dart`, baris 113–115 dan seterusnya
```dart
Column(
  children: [ NavPill(...), HeroSection(...), MarqueeBand(...), AboutList(...), PhotoSection() ],
```
> "Column menyusun widget dari atas ke bawah. Urutannya sama dengan yang terlihat di layar."

### 5. Container
- **Di layar:** pil hitam di paling atas
- **File:** `widgets/nav_pill.dart`, baris 24–29
```dart
Container(
  height: 56,
  decoration: BoxDecoration(
    color: p.gelap,
    borderRadius: BorderRadius.circular(28),
```
> "Container adalah kotak yang bisa diatur warna dan bentuknya. color untuk warna, borderRadius 28 untuk sudut yang melengkung seperti pil."

### 6. Row
- **Di layar:** isi pil hitam (logo H, tulisan Hugo, tombol bulan, tombol Tentang)
- **File:** `widgets/nav_pill.dart`, baris 38
```dart
child: Row(
  children: [ logo, tulisan Hugo, tombol bulan, tombol Tentang ],
```
> "Row menyusun widget ke samping, dari kiri ke kanan."

### 7. Text
- **Di layar:** tulisan "Hugo." di kartu profil
- **File:** `widgets/hero_section.dart`, baris 209–226
```dart
Text.rich(
  TextSpan(children: [
    TextSpan(text: ProfilData.panggilan),
    TextSpan(text: '.', style: TextStyle(color: p.aksen)),
  ]),
  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
```
> "Text menampilkan tulisan. TextStyle mengatur ukuran dan ketebalan huruf. Titik di belakang Hugo dibuat oranye lewat TextSpan terpisah."

### 8. Stack dan Positioned
- **Di layar:** kartu profil. Foto sampul, bookmark, dan foto bulat bertumpuk.
- **File:** `widgets/hero_section.dart`, baris 53–65
```dart
Stack(
  children: [
    Positioned.fill(child: _Sampul(...)),
    Positioned(top: 14, right: 14, child: _TombolTandai()),
    Positioned(left: 20, bottom: 0, child: ... _Avatar(...)),
```
> "Stack menumpuk widget di satu tempat. Positioned mengatur letaknya. top 14 dan right 14 artinya bookmark ada di pojok kanan atas."

### 9. Image.asset
- **Di layar:** foto sampul di kartu profil
- **File:** `widgets/hero_section.dart`, baris 134–137
```dart
Image.asset(
  'assets/images/foto.jpg',
  fit: BoxFit.cover,
```
> "Image.asset menampilkan gambar dari folder assets. BoxFit.cover membuat gambar memenuhi kotaknya."

### 10. ClipOval
- **Di layar:** foto profil yang bulat
- **File:** `widgets/hero_section.dart`, baris 175–177
```dart
ClipOval(
  child: Image.asset('assets/images/avatar.jpg', fit: BoxFit.cover),
```
> "ClipOval memotong gambar di dalamnya jadi bulat."

### 11. IconButton dan SnackBar
- **Di layar:** tombol bookmark di pojok kanan atas kartu
- **File:** `widgets/hero_section.dart`, baris 427–431 dan 441–442
```dart
IconButton(
  onPressed: _ganti,
  ...
showSnackBar(
  SnackBar(content: Text('Profil ditandai')),
```
> "IconButton adalah tombol berbentuk ikon. onPressed berisi apa yang terjadi saat ditekan. Di sini hasilnya SnackBar, yaitu pesan kecil di bawah layar."

*Tekan tombol bookmark.*

### 12. Wrap
- **Di layar:** tulisan "NRP 5051241034" dan "ITS Surabaya"
- **File:** `widgets/hero_section.dart`, baris 240–246
```dart
Wrap(
  spacing: 16,
  children: [
    info(Icons.badge_outlined, 'NRP ${ProfilData.nrp}'),
    info(Icons.location_on_outlined, 'ITS Surabaya'),
```
> "Wrap menjajarkan widget. Kalau tidak muat, widget otomatis turun ke baris berikutnya. spacing 16 adalah jarak antarwidget."

### 13. SingleChildScrollView (horizontal)
- **Di layar:** pita oranye yang berjalan
- **File:** `widgets/marquee_band.dart`, baris 84–88
```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  physics: const NeverScrollableScrollPhysics(),
  child: Row(...),
```
> "Pita ini memakai SingleChildScrollView juga. Axis.horizontal artinya arahnya ke samping. NeverScrollableScrollPhysics artinya tidak bisa digeser dengan jari, karena digeser otomatis oleh kode."

### 14. InkWell
- **Di layar:** baris-baris "Kenalan Lebih Dekat". *Tekan tombol Kenalan yuk, lalu ketuk satu baris.*
- **File:** `widgets/about_list.dart`, baris 109–110
```dart
InkWell(
  onTap: onTap,
```
> "InkWell membuat sebuah baris bisa diketuk. onTap berisi apa yang terjadi saat diketuk, yaitu membuka atau menutup baris."

### 15. AnimatedContainer
- **Di layar:** warna baris yang berubah saat dibuka
- **File:** `widgets/about_list.dart`, baris 86 dan 93–97
```dart
final latar = terbuka ? p.gelap : p.kartu;
AnimatedContainer(
  duration: durasi,
  decoration: ShapeDecoration(color: latar, ...),
```
> "Kalau terbuka warnanya gelap, kalau tertutup terang. AnimatedContainer membuat perubahan itu berjalan halus sesuai duration, tidak langsung berganti."

### 16. AnimatedRotation
- **Di layar:** panah oranye di kanan baris
- **File:** `widgets/about_list.dart`, baris 142–143
```dart
AnimatedRotation(
  turns: terbuka ? 0.125 : 0,
```
> "AnimatedRotation memutar panah dengan halus. turns 0,125 artinya seperdelapan putaran, atau 45 derajat."

### 17. ListTile
- **Di layar:** daftar kontak di bagian hitam paling bawah
- **File:** `widgets/photo_section.dart`, baris 126–155
```dart
ListTile(
  leading: ... Icon(kontak.ikon),
  title: Text(kontak.platform),
  subtitle: Text(kontak.nilai),
  trailing: Icon(Icons.copy_rounded),
  onTap: () { Clipboard.setData(...) },
```
> "ListTile adalah baris daftar siap pakai. leading ikon di kiri, title nama platform, subtitle username, dan trailing ikon salin di kanan. Saat onTap, tulisan kontak disalin."

*Ketuk satu kontak.*

---

## PENUTUP

*Kembali ke emulator.*

> "Jadi aplikasi profil saya menampilkan nama, NRP, dan foto saya, dengan widget seperti Container, Row, Column, Stack, Text, Image, dan ListTile. Sekian, terima kasih."
