import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:naemansan/screens/screen_index.dart';
import 'package:naemansan/services/login_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  late Future<Map<String, dynamic>?> user;

  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';

  // Fetch user info
  Future<Map<String, dynamic>?> fetchUserInfo() async {
    ApiService apiService = ApiService();
    return await apiService.getUserInfo();
  }

  @override
  void initState() {
    super.initState();
    user = fetchUserInfo();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }

// 로그인 화면으로 이동 시키기
  goLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<void> logout() async {
    await deleteTokens();
    await storage.delete(key: 'login');
    goLoginScreen();
  }

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    if (userInfo == null) {
      print('로그인 페이지로 이동');
      Navigator.pushNamedAndRemoveUntil(context, '/index', (route) => false);
    } else {
      print('로그인 중');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 20),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const IndexScreen(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '마이페이지',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Expanded(child: SizedBox(width: 30)), // 여백 추가
            IconButton(
              padding: const EdgeInsets.only(left: 25),
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 100), // Adjust the top padding value as needed
          child: FutureBuilder<Map<String, dynamic>?>(
            future: user,
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.hasData) {
                  Map<String, dynamic>? userData = snapshot.data;
                  String imageFileName =
                      userData?['image_path'] ?? '0_default_image.png';
                  String imageUrl =
                      'https://ossp.dcs-hyungjoon.com/image?uuid=$imageFileName';

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 50, backgroundImage: NetworkImage(
                              // 'imageUrl',
                              //랜덤 이미지
                              imageUrl)
                          // "https://picsum.photos/200/300"),
                          ),
                      const SizedBox(height: 16),
                      Text(
                        userData?['name'] ?? 'No Name',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData?['introduction'] ?? 'No Introduction',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '팔로워',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                userData?['follower_cnt'].toString() ?? '0',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '팔로잉',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                userData?['following_cnt'].toString() ?? '0',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '좋아요한 산책로',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${userData?['like_cnt'] ?? 0}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '작성한 후기',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${userData?['comment_cnt'] ?? 0}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '획득한 뱃지',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${userData?['badge_cnt'] ?? 0}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text('No user data available.');
                }
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Delete tokens on logout
  Future<void> deleteTokens() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', false);
  }
}
