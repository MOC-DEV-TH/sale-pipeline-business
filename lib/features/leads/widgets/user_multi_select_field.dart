import 'package:flutter/material.dart';

import '../model/participants_response.dart';

class UserMultiSelectField extends StatelessWidget {
  const UserMultiSelectField({
    super.key,
    required this.label,
    required this.users,
    required this.selectedUsers,
    required this.onChanged,
    this.required = false,
  });

  final String label;
  final List<ParticipantVO> users;
  final List<ParticipantVO> selectedUsers;
  final ValueChanged<List<ParticipantVO>> onChanged;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            children: [
              TextSpan(text: label),
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            _showUserSelector(context);
          },
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 68),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0B341F),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF56846A)),
            ),
            child: selectedUsers.isEmpty
                ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose user',
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedUsers.map((user) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8FFE6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              user.name ?? '-',
                              style: const TextStyle(
                                color: Color(0xFF00A84F),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 7),
                            InkWell(
                              onTap: () {
                                final updated = List<ParticipantVO>.from(
                                  selectedUsers,
                                );

                                updated.removeWhere(
                                  (item) => item.id == user.id,
                                );

                                onChanged(updated);
                              },
                              child: const Icon(
                                Icons.close,
                                size: 17,
                                color: Color(0xFF00A84F),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _showUserSelector(BuildContext context) async {
    final tempSelected = List<ParticipantVO>.from(selectedUsers);

    final result = await showModalBottomSheet<List<ParticipantVO>>(
      context: context,
      backgroundColor: const Color(0xFF0B341F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 45,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Choose $label',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 380),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];

                          final selected = tempSelected.any(
                            (item) => item.id == user.id,
                          );

                          return CheckboxListTile(
                            value: selected,
                            activeColor: const Color(0xFF00C65A),
                            checkColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              user.name ?? '-',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: user.email == null
                                ? null
                                : Text(
                                    user.email!,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true) {
                                  tempSelected.add(user);
                                } else {
                                  tempSelected.removeWhere(
                                    (item) => item.id == user.id,
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C65A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, tempSelected);
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      onChanged(result);
    }
  }
}
