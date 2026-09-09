import 'package:flutter/material.dart';

class LeadLogCard extends StatelessWidget {
  const LeadLogCard({
    super.key,
    this.title,
    this.type,
    required this.description,
    required this.participants,
    required this.creatorName,
    required this.dateTime,
    required this.onMoreTap,
    this.showReminderIcon = false,
  });

  final String? title;
  final String? type;

  final String description;
  final String participants;
  final String creatorName;
  final String dateTime;

  final VoidCallback onMoreTap;

  final bool showReminderIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        16,
        18,
        14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0B341F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.40),
          width: 1,
        ),
      ),
      child: showReminderIcon
          ? _buildReminderLayout()
          : _buildActivityLayout(),
    );
  }

  Widget _buildActivityLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title + More
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title ?? '-',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 10),

            _MoreButton(
              onTap: onMoreTap,
            ),
          ],
        ),

        if (type != null &&
            type!.trim().isNotEmpty) ...[
          const SizedBox(height: 5),

          _TypeBadge(
            text: type!,
          ),
        ],

        const SizedBox(height: 20),

        /// Description
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 3,
              constraints: const BoxConstraints(
                minHeight: 45,
              ),
              color: const Color(0xFFB9FFD1),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  color: Color(0xFFD4DDD7),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          participants,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 13),

        Container(
          height: 1,
          color: const Color(0xFF087337),
        ),

        const SizedBox(height: 13),

        _BottomInfo(
          creatorName: creatorName,
          dateTime: dateTime,
        ),
      ],
    );
  }

  Widget _buildReminderLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Reminder icon
            Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: Color(0xFF0D9446),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.alarm_outlined,
                color: Colors.white,
                size: 31,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFFE1E8E3),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    participants,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            _MoreButton(
              onTap: onMoreTap,
            ),
          ],
        ),

        const SizedBox(height: 13),

        Container(
          height: 1,
          color: const Color(0xFF087337),
        ),

        const SizedBox(height: 13),

        _BottomInfo(
          creatorName: creatorName,
          dateTime: dateTime,
        ),
      ],
    );
  }
}

class _BottomInfo extends StatelessWidget {
  const _BottomInfo({
    required this.creatorName,
    required this.dateTime,
  });

  final String creatorName;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            creatorName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Text(
          dateTime,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({
    required this.text,
  });

  final String text;

  String _capitalize(String value) {
    if (value.isEmpty) return value;

    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF9CCBB0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _capitalize(text),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF116A38),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: const SizedBox(
          width: 34,
          height: 34,
          child: Icon(
            Icons.more_horiz_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}