import 'package:flutter/material.dart';

class MaterialForm extends StatefulWidget {
  const MaterialForm(
      {super.key,
      required this.title,
      required this.data,
      required this.note,
      this.textEditingController,
      required this.view});
  final bool note;
  final bool view;
  final String title;
  final String data;
  final TextEditingController? textEditingController;

  @override
  State<MaterialForm> createState() => _MaterialFormState();
}

class _MaterialFormState extends State<MaterialForm> {
  bool viewMode = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    viewMode = widget.view;
    if (viewMode) {
      textEditingController.text = widget.data;
    } else {
      textEditingController = widget.textEditingController!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        Container(
            height: !widget.note ? mq.height * 0.06 : mq.height * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextField(
                    readOnly: viewMode,
                    controller: textEditingController,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
