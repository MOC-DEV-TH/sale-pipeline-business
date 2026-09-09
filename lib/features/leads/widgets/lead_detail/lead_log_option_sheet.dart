import 'package:flutter/material.dart';

Future<void> showLeadLogOptionSheet({
  required BuildContext context,
  required String title,
  required String editText,
  required String removeText,
  required VoidCallback onEdit,
  required Future<bool> Function() onRemove,
  String removeSuccessMessage = 'Removed successfully',
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    builder: (sheetContext) {
      bool isRemoving = false;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF104B2A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 90,
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),

                  _divider(),

                  InkWell(
                    onTap: isRemoving
                        ? null
                        : () {
                            Navigator.of(sheetContext).pop();

                            Future.microtask(onEdit);
                          },
                    child: SizedBox(
                      width: double.infinity,
                      height: 82,
                      child: Center(
                        child: Text(
                          editText,
                          style: TextStyle(
                            color: isRemoving ? Colors.white38 : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  _divider(),

                  InkWell(
                    onTap: isRemoving
                        ? null
                        : () async {
                            setModalState(() {
                              isRemoving = true;
                            });

                            final success = await onRemove();

                            if (!sheetContext.mounted) {
                              return;
                            }

                            if (!success) {
                              setModalState(() {
                                isRemoving = false;
                              });

                              return;
                            }

                            Navigator.of(sheetContext).pop();

                            if (!context.mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF00A84F),
                                  content: Text(
                                    removeSuccessMessage,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                          },
                    child: SizedBox(
                      width: double.infinity,
                      height: 82,
                      child: Center(
                        child: isRemoving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                removeText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
}

Widget _divider() {
  return Container(
    width: double.infinity,
    height: 1,
    color: const Color(0xFF16753F),
  );
}
