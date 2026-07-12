import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScanScreen extends StatefulWidget {
  const CameraScanScreen({super.key});

  @override
  State<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends State<CameraScanScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitializing = true;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
    }
    if (mounted) {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureAndScan() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final XFile photo = await _controller!.takePicture();

      // Temporary feedback before connecting to Member 4's HTTP Service
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo Captured: ${photo.path}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error taking picture: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan Prescription / Pill'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _isInitializing
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Camera Preview Stream
                Positioned.fill(child: CameraPreview(_controller!)),

                // Framing Box Overlay
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF00A86B),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Position medication inside box',
                          style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Capture Action Button
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _isProcessing
                        ? const CircularProgressIndicator(color: Colors.white)
                        : FloatingActionButton.large(
                            onPressed: _captureAndScan,
                            backgroundColor: const Color(0xFF0066CC),
                            child: const Icon(
                              Icons.camera,
                              size: 36,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
