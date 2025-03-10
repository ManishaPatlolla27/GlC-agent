import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../page_routing/app_routes.dart';

class CompareBothFarmlandsScreen extends StatefulWidget {
  const CompareBothFarmlandsScreen({super.key});

  @override
  FarmlandsCompareScreenState createState() => FarmlandsCompareScreenState();
}

class FarmlandsCompareScreenState extends State<CompareBothFarmlandsScreen> {
  bool _isFarmland1Visible = true;
  bool _isFarmland2Visible = true;
  FlutterSecureStorage storage = FlutterSecureStorage(); //
  String? farmid = "";
  String? code = "";
  String? area = "";
  String? cost = "";
  String? image = "";

  String? farmid1 = "";
  String? code1 = "";
  String? area1 = "";
  String? cost1 = "";
  String? image1 = "";

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future<void> loaddata() async {
    final farmidNew = await storage.read(key: "farmid");
    final codeNew = await storage.read(key: "code");
    final areaNew = await storage.read(key: "area");
    final costNew = await storage.read(key: "cost");
    final imageNew = await storage.read(key: "image");

    final farmid1New = await storage.read(key: "farmid1");
    final code1New = await storage.read(key: "code1");
    final area1New = await storage.read(key: "area1");
    final cost1New = await storage.read(key: "cost1");
    final image1New = await storage.read(key: "image1");

    setState(() {
      farmid = farmidNew;
      code = codeNew;
      area = areaNew;
      cost = costNew;
      image = imageNew;

      farmid1 = farmid1New;
      code1 = code1New;
      area1 = area1New;
      cost1 = cost1New;
      image1 = image1New;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Compare Farmlands",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isFarmland1Visible) buildSearchCard1(),
            if (!_isFarmland1Visible)
              buildAddFarmlandButton(() {
                setState(() {
                  _isFarmland1Visible = true;
                });
              }),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "VS",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            if (_isFarmland2Visible) buildSearchCard(),
            if (!_isFarmland2Visible)
              buildAddFarmlandButton(() {
                setState(() {
                  _isFarmland2Visible = true;
                });
              }),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the button
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.compare);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8280FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Compare",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  Widget buildSearchCard() {
    return buildFarmlandCard(
      image: image,
      code: code,
      area: area,
      cost: cost,
      onClose: () {
        setState(() {
          _isFarmland2Visible = false;
        });
      },
    );
  }

  Widget buildSearchCard1() {
    return buildFarmlandCard(
      image: image1,
      code: code1,
      area: area1,
      cost: cost1,
      onClose: () {
        setState(() {
          _isFarmland1Visible = false;
        });
      },
    );
  }

  Widget buildFarmlandCard({
    required String? image,
    required String? code,
    required String? area,
    required String? cost,
    required VoidCallback onClose,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // Ensures Row takes minimal space
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  (image != null &&
                          image!.isNotEmpty &&
                          Uri.tryParse(image!)?.hasAbsolutePath == true)
                      ? image!
                      : "https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png",
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png",
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                // Prevents overflow by adjusting text dynamically
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code ?? "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis, // Prevents text overflow
                      maxLines: 1, // Limits text to one line
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            area ?? "",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            overflow:
                                TextOverflow.ellipsis, // Ensures no overflow
                          ),
                        ),
                      ],
                    ),
                    Text(
                      cost ?? "",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black54),
                onPressed: onClose,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddFarmlandButton(VoidCallback onPressed) {
    return Center(
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF8280FF),
            side: const BorderSide(color: Color(0xFF8280FF)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text("+ Add Farmland"),
        ),
      ),
    );
  }
}
