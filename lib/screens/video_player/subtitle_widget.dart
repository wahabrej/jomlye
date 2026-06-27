// =============================================
// FILE: lib/screens/widgets/subtitle/subtitle_overlay_widget.dart
// =============================================

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart'; // pubspec.yaml এ add করুন: collection: ^1.17.0

// --------------- SubtitleEntry ---------------
class SubtitleEntry {
  final int startMs;
  final int endMs;
  final String text;

  SubtitleEntry({
    required this.startMs,
    required this.endMs,
    required this.text,
  });
}

// --------------- SubtitleOverlay Widget ---------------
class SubtitleOverlay extends StatefulWidget {
  final String subtitleUrl;
  final FlickManager flickManager;

  const SubtitleOverlay({
    super.key,
    required this.subtitleUrl,
    required this.flickManager,
  });

  @override
  State<SubtitleOverlay> createState() => _SubtitleOverlayState();
}

class _SubtitleOverlayState extends State<SubtitleOverlay> {
  List<SubtitleEntry> _entries = [];
  String _currentText = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.subtitleUrl.isNotEmpty) {
      _loadSubtitles(widget.subtitleUrl);
    }
  }

  @override
  void didUpdateWidget(SubtitleOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subtitleUrl != widget.subtitleUrl) {
      _timer?.cancel();
      setState(() {
        _entries = [];
        _currentText = "";
      });
      if (widget.subtitleUrl.isNotEmpty) {
        _loadSubtitles(widget.subtitleUrl);
      }
    }
  }

  Future<void> _loadSubtitles(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 15),
      );
      if (response.statusCode == 200) {
        // Decode as UTF-8 from the raw bytes. `response.body` falls back to
        // Latin-1 when the server omits a charset, which turns Tamil/Chinese
        // (and any non-ASCII) text into mojibake like "à®ª à®¤".
        final content = utf8.decode(response.bodyBytes, allowMalformed: true);
        final parsed = url.toLowerCase().endsWith('.vtt')
            ? _parseVtt(content)
            : _parseSrt(content);
        if (!mounted) return;
        setState(() => _entries = parsed);
        _startTimer();
      }
    } catch (e) {
      debugPrint("Subtitle load error: $e");
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      if (!mounted) return;
      final position = widget.flickManager
          .flickVideoManager?.videoPlayerController?.value.position;
      if (position == null) return;

      final ms = position.inMilliseconds;
      final entry = _entries.firstWhereOrNull(
            (e) => ms >= e.startMs && ms <= e.endMs,
      );
      final newText = entry?.text ?? "";
      if (newText != _currentText) {
        setState(() => _currentText = newText);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // --------- VTT Parser ---------
  List<SubtitleEntry> _parseVtt(String content) {
    final entries = <SubtitleEntry>[];
    final lines = content.split(RegExp(r'\r?\n'));
    int i = 0;
    while (i < lines.length) {
      final line = lines[i].trim();
      if (line.contains('-->')) {
        final arrowIndex = line.indexOf('-->');
        final startStr = line.substring(0, arrowIndex).trim();
        String endStr = line.substring(arrowIndex + 3).trim();
        // remove positioning cues like "align:start position:0%"
        if (endStr.contains(' ')) {
          endStr = endStr.split(' ')[0];
        }
        final start = _parseTimeMs(startStr);
        final end = _parseTimeMs(endStr);
        i++;
        final textLines = <String>[];
        while (i < lines.length && lines[i].trim().isNotEmpty) {
          // strip HTML tags like <c>, <b>, <i>
          textLines.add(lines[i].trim().replaceAll(RegExp(r'<[^>]+>'), ''));
          i++;
        }
        if (textLines.isNotEmpty) {
          entries.add(SubtitleEntry(
            startMs: start,
            endMs: end,
            text: textLines.join('\n'),
          ));
        }
      }
      i++;
    }
    return entries;
  }

  // --------- SRT Parser ---------
  List<SubtitleEntry> _parseSrt(String content) {
    final entries = <SubtitleEntry>[];
    final blocks = content.trim().split(RegExp(r'\r?\n\r?\n'));
    for (final block in blocks) {
      final lines = block.trim().split(RegExp(r'\r?\n'));
      if (lines.length >= 3) {
        final timeLine = lines[1];
        if (timeLine.contains('-->')) {
          final parts = timeLine.split('-->');
          final start = _parseTimeMs(parts[0].trim());
          final end = _parseTimeMs(parts[1].trim());
          final text = lines
              .sublist(2)
              .map((l) => l.replaceAll(RegExp(r'<[^>]+>'), ''))
              .join('\n');
          if (text.isNotEmpty) {
            entries.add(SubtitleEntry(
              startMs: start,
              endMs: end,
              text: text,
            ));
          }
        }
      }
    }
    return entries;
  }

  // --------- Time Parser ---------
  // Handles: HH:MM:SS.mmm  |  HH:MM:SS,mmm  |  MM:SS.mmm
  int _parseTimeMs(String t) {
    t = t.trim().replaceAll(',', '.');
    try {
      final colonParts = t.split(':');
      int h = 0, m = 0, s = 0, ms = 0;
      if (colonParts.length == 3) {
        h = int.parse(colonParts[0]);
        m = int.parse(colonParts[1]);
        final sParts = colonParts[2].split('.');
        s = int.parse(sParts[0]);
        if (sParts.length > 1) {
          ms = int.parse(sParts[1].padRight(3, '0').substring(0, 3));
        }
      } else if (colonParts.length == 2) {
        m = int.parse(colonParts[0]);
        final sParts = colonParts[1].split('.');
        s = int.parse(sParts[0]);
        if (sParts.length > 1) {
          ms = int.parse(sParts[1].padRight(3, '0').substring(0, 3));
        }
      }
      return ((h * 3600 + m * 60 + s) * 1000) + ms;
    } catch (_) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Keep it clean like Netflix/YouTube — nothing on screen while loading or
    // between cues.
    if (_currentText.isEmpty) return const SizedBox.shrink();
    // Cap the caption width so long lines wrap (YouTube-style) instead of
    // being shrunk to unreadable text; the box hugs the text it contains.
    final maxWidth = MediaQuery.of(context).size.width * 0.85;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: IntrinsicWidth(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _currentText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                  shadows: [
                    Shadow(blurRadius: 3, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
