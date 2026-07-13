import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String fullName;
  final String mobileNumber;
  final String weight;
  final String height;
  final List<String> chronicConditions;

  const ProfileScreen({
    super.key,
    required this.fullName,
    required this.mobileNumber,
    required this.weight,
    required this.height,
    required this.chronicConditions,
  });

  static const Color primaryColor = Color(0xFF009688);
  static const Color darkColor = Color(0xFF1E293B);
  static const Color backgroundColor = Color(0xFFF1F6FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildHealthSummary(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Personal Information'),
                    const SizedBox(height: 12),
                    _buildInformationCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Health Information'),
                    const SizedBox(height: 12),
                    _buildMeasurementsCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Chronic Conditions'),
                    const SizedBox(height: 12),
                    _buildConditionsCard(),
                    const SizedBox(height: 30),
                    _buildContinueButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF20B5A5),
            Color(0xFF008F83),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const Expanded(
                child: Text(
                  'My Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add profile editing navigation here.
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: const Color(0xFFE0F5F2),
                  child: Text(
                    _getInitials(fullName),
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // When you have a profile image, replace child with:
                  // backgroundImage: const AssetImage(
                  //   'assets/images/profile.jpg',
                  // ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: -2,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),
          Text(
            fullName.isEmpty ? 'MedScan User' : fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'MedScan AI Member',
            style: TextStyle(
              color: Color(0xFFE4FFFC),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              icon: Icons.monitor_weight_outlined,
              value: weight.isEmpty ? '--' : '$weight kg',
              label: 'Weight',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildSummaryItem(
              icon: Icons.height_rounded,
              value: height.isEmpty ? '--' : '$height cm',
              label: 'Height',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildSummaryItem(
              icon: Icons.favorite_outline_rounded,
              value: chronicConditions.length.toString(),
              label: 'Conditions',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F5F2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 23,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: darkColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8A94A6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 65,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFFE4E9EF),
    );
  }

  Widget _buildInformationCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.person_outline_rounded,
            title: 'Full Name',
            value: fullName.isEmpty ? 'Not provided' : fullName,
          ),
          const Divider(
            height: 28,
            color: Color(0xFFE8EDF2),
          ),
          _buildDetailRow(
            icon: Icons.phone_android_rounded,
            title: 'Mobile Number',
            value: mobileNumber.isEmpty
                ? 'Not provided'
                : mobileNumber,
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.monitor_weight_outlined,
            title: 'Weight',
            value: weight.isEmpty ? 'Not provided' : '$weight kg',
          ),
          const Divider(
            height: 28,
            color: Color(0xFFE8EDF2),
          ),
          _buildDetailRow(
            icon: Icons.height_rounded,
            title: 'Height',
            value: height.isEmpty ? 'Not provided' : '$height cm',
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: chronicConditions.isEmpty
          ? const Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: primaryColor,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No chronic conditions selected',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )
          : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: chronicConditions.map((condition) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F5F2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFB4E7E1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.medical_information_outlined,
                        color: primaryColor,
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        condition,
                        style: const TextStyle(
                          color: darkColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F5F2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 23,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF8A94A6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: darkColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF171D28),
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF25B7A7),
              Color(0xFF008D81),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: 0.25),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to your home screen here.
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            'Continue to MedScan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1E293B).withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 7),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final cleanedName = name.trim();

    if (cleanedName.isEmpty) {
      return 'MU';
    }

    final words = cleanedName
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.length == 1) {
      return words.first[0].toUpperCase();
    }

    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }
}