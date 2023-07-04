// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:licenta_app/videocall/pages/call.dart';
import 'dart:developer';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Tour')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/images/logo_transparent.png'),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _channelController,
                decoration: InputDecoration(
                  errorText:
                      _validateError ? 'Channel name is mandatory' : null,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: 'Channel name',
                ),
              ),
              RadioListTile(
                title: const Text(
                  'Broadcaster',
                  style: TextStyle(color: Colors.white),
                ),
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
                value: ClientRole.Broadcaster,
                groupValue: _role,
              ),
              RadioListTile(
                title: const Text(
                  'Audience',
                  style: TextStyle(color: Colors.white),
                ),
                onChanged: (ClientRole? value) {
                  setState(() {
                    _role = value;
                  });
                },
                value: ClientRole.Audience,
                groupValue: _role,
              ),
              ElevatedButton(
                onPressed: onJoin,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)),
                child: const Text('Join'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
