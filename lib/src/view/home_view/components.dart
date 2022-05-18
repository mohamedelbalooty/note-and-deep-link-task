import 'package:flutter/material.dart';
import '../../../utils/theme/colors.dart';
import '../../model/note.dart';
import '../app_components.dart';

class NoteCardWidget extends StatelessWidget {
  final int index;
  final Note note;
  final VoidCallback onClick, onDelete, onEdit, onCopy;

  const NoteCardWidget({
    Key? key,
    required this.index,
    required this.note,
    required this.onClick,
    required this.onDelete,
    required this.onEdit,
    required this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.only(top: index == 0 ? 10 : 0),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: mainClr, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                note.note,
                style: const TextStyle(
                  color: blackClr,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: blackClr,
                thickness: 2,
                height: 10,
              ),
              Row(
                children: [
                  IconButtonUtil(
                    icon: Icons.edit,
                    onClick: onEdit,
                  ),
                  IconButtonUtil(
                    icon: Icons.delete,
                    onClick: onDelete,
                  ),
                  const Spacer(),
                  InkWell(
                    child: const Text(
                      'Copy link',
                      style: TextStyle(
                        color: blackClr,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: onCopy,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: onClick,
    );
  }
}
