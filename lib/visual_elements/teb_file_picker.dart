import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class TebFilePickerWeb extends StatefulWidget {
  final String buttonLabel;
  final FaIcon? icon;
  final void Function(String status)? getStatus;
  final FileType fileType;
  final List<String>? allowedExtensions;
  final void Function(MemoryImage) onPicked;

  const TebFilePickerWeb({
    super.key,
    required this.buttonLabel,
    this.getStatus,
    this.fileType = FileType.image,
    this.allowedExtensions,
    required this.onPicked,
    this.icon,
  });

  @override
  State<TebFilePickerWeb> createState() => _TebFilePickerWebState();
}

class _TebFilePickerWebState extends State<TebFilePickerWeb> {
  List<PlatformFile>? _paths;

  Future<String> _uploadFile(List<int> file, String fileName) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      )
    });
    var response = await Dio().post(
      "https://v2.convertapi.com/upload",
      data: formData,
    );
    return response.data['FileId'];
  }

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: widget.fileType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) {
          if (widget.getStatus != null) widget.getStatus!(status.toString());
        },
        allowedExtensions: widget.allowedExtensions,
      ))
          ?.files;
    } on PlatformException catch (e) {
      //setState(() => _status = e.toString());
      if (widget.getStatus != null) widget.getStatus!(e.toString());
    } catch (e) {
      //setState(() => _status = e.toString());
      if (widget.getStatus != null) widget.getStatus!(e.toString());
    }

    setState(() {
      if (_paths != null) {
        //passing file bytes and file name for API call
        _uploadFile(_paths!.first.bytes!, _paths!.first.name);

        widget.onPicked(MemoryImage(_paths!.first.bytes!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.icon != null) {
      return ElevatedButton.icon(onPressed: () => pickFiles(), icon: widget.icon!, label: Text(widget.buttonLabel));
    } else {
      return ElevatedButton(onPressed: () => pickFiles(), child: Text(widget.buttonLabel));
    }
  }
}
