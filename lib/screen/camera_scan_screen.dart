import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:medscan_flutter/services/api_service.dart';

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

  void _showSafetyDialog(
    BuildContext context,
    String msgEn,
    String msgSi,
    String msgTa,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.amber,
          size: 48,
        ),
        title: const Text('Safety Block (<85% Confidence)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(msgEn, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(msgSi, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 4),
            Text(msgTa, style: const TextStyle(color: Colors.black87)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showResultBottomSheet(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Scan Verified',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'Medication: ${data['pill_name']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Dosage: ${data['dosage']}'),
            Text('Frequency: ${data['frequency']}'),
            const SizedBox(height: 12),
            Text('Instructions (Sinhala): ${data['instructions_sinhala']}'),
            const SizedBox(height: 8),
            Text('Local Dietary Advice: ${data['lifestyle_guidance']}'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
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

      // Call Member 4's HTTP service
      final response = await ApiService.scanPrescription(photo.path);

      if (!mounted) return;

      // Handle 85% Safety Block response
      if (response['status'] == 'safety_block') {
        _showSafetyDialog(
          context,
          response['message'] ?? 'Low AI confidence score.',
          response['message_sinhala'] ?? '',
          response['message_tamil'] ?? '',
        );
      } else if (response['status'] == 'success') {
        // Display parsed output payload
        _showResultBottomSheet(context, response['prescription']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? 'Error processing scan'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Processing error: $e')));
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
