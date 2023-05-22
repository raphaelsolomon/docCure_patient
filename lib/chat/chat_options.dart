import 'dart:io';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:doccure_patient/constant/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatOptionSheet extends StatefulWidget {
  final String receipient;
  const ChatOptionSheet(this.receipient, {Key? key}) : super(key: key);

  @override
  State<ChatOptionSheet> createState() => _ChatOptionSheetState();
}

class _ChatOptionSheetState extends State<ChatOptionSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void imageMessage(targetId, File imageFile) {
    ChatMessage msg = ChatMessage.createImageSendMessage(
      targetId: targetId,
      filePath: imageFile.path,
      displayName: 'IMG_${DateTime.now().millisecondsSinceEpoch}',
      fileSize: imageFile.lengthSync(),
    );
    ChatClient.getInstance.chatManager.sendMessage(msg).then((value) => Navigator.pop(context));
  }

  void fileMessage(targetId, File customFile) {
    ChatMessage fileMsg = ChatMessage.createFileSendMessage(
      targetId: targetId,
      filePath: customFile.path,
      displayName: 'FILE_${DateTime.now().millisecondsSinceEpoch}',
      fileSize: customFile.lengthSync(),
    );
    ChatClient.getInstance.chatManager.sendMessage(fileMsg).then((value) => Navigator.pop(context));
  }

  void videoMessage(targetId, File videoFile) {
    ChatMessage msg = ChatMessage.createVideoSendMessage(
      targetId: targetId,
      filePath: videoFile.path,
      fileSize: videoFile.lengthSync(),
      displayName: 'VIDEO_${DateTime.now().millisecondsSinceEpoch}',
    );
    ChatClient.getInstance.chatManager.sendMessage(msg).then((value) => Navigator.pop(context));
  }

  void voiceMessage(targetId, File voiceFile) {
    ChatMessage msg = ChatMessage.createVoiceSendMessage(
      targetId: targetId,
      filePath: voiceFile.path,
      fileSize: voiceFile.lengthSync(),
      displayName: 'AUDIO_${DateTime.now().millisecondsSinceEpoch}',
    );
    ChatClient.getInstance.chatManager.sendMessage(msg).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.26,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    const SizedBox(height: 7.0),
                    _item(callback: () async {
                      final result = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (result != null) imageMessage(widget.receipient, File(result.path));
                    }),
                    Divider(),
                    _item(
                        icons: Icons.photo_outlined,
                        text: 'Photo & Video Library',
                        callback: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: false,
                            allowedExtensions: ['mp4', 'jpeg', 'jpg', 'png', 'gif'],
                          );
                          if (result != null) {
                            if (result.files.single.path!.endsWith('mp4'))
                              videoMessage(widget.receipient, File(result.files.single.path!));
                            else
                              imageMessage(widget.receipient, File(result.files.single.path!));
                          }
                        }),
                    Divider(),
                    _item(
                        icons: Icons.file_copy_outlined,
                        text: 'Documents',
                        callback: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: false,
                            allowedExtensions: ['xlxs', 'pdf', 'doc', 'docx', 'txt', 'zip', 'rar', 'ppt'],
                          );
                          if (result != null) fileMessage(widget.receipient, File(result.files.single.path!));
                        }),
                    Divider(),
                    _item(
                        icons: Icons.audio_file_outlined,
                        text: 'Audio',
                        callback: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.audio,
                            allowMultiple: false,
                          );
                          if (result != null) voiceMessage(widget.receipient, File(result.files.single.path!));
                        }),
                  ],
                ))),
        const SizedBox(
          height: 10.0,
        ),
        getButton(context, () => Navigator.pop(context), text: 'Cancel'),
        const SizedBox(
          height: 0.0,
        ),
      ]),
    );
  }

  Widget _item({icons = Icons.camera_alt_outlined, text = "Camera", callback = null}) {
    return InkWell(
      onTap: () => callback(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          children: [
            const SizedBox(width: 5.0),
            Icon(
              icons,
              color: BLUECOLOR,
              size: 35.0,
            ),
            const SizedBox(width: 20.0),
            Flexible(child: Text('$text', style: getCustomFont(size: 14.0, color: Colors.black54, letterSpacing: 1.0, weight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }

  Widget getButton(context, callBack, {text = 'Continue'}) => GestureDetector(
        onTap: () => callBack(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          decoration: BoxDecoration(color: BLUECOLOR, borderRadius: BorderRadius.circular(15.0)),
          child: Center(
            child: Text(
              '$text',
              style: getCustomFont(size: 13.0, color: Colors.white, weight: FontWeight.normal, letterSpacing: 1.2),
            ),
          ),
        ),
      );
}
