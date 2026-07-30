import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan Medical Document',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: isFlashOn ? Colors.yellow : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Camera View Placeholder (Mock Screen)
          Center(
            child: Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(Icons.camera_alt, size: 80, color: Colors.white24),
              ),
            ),
          ),

          // 2. Scanner Viewfinder Overlay Frame
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryPurple, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Align document/prescription\nwithin the frame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom Controls (Gallery & Shutter Button)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery Picker Button
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.photo_library, color: Colors.white),
                  onPressed: () {
                    // TODO: Pick image from gallery
                  },
                ),

                // Main Capture Button
                GestureDetector(
                  onTap: () {
                    // TODO: Capture image action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Scanning Document...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),

                // Help/Info Button
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.help_outline, color: Colors.white),
                  onPressed: () {
                    // Quick tip popup
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
