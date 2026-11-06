import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

html.AudioElement? _current;

Future<void> playBytes(Uint8List bytes) async {
  _current?.pause();

  final blob = html.Blob([bytes], 'audio/mpeg');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final audio = html.AudioElement(url);
  _current = audio;

  final done = Completer<void>();
  audio.onEnded.listen((_) {
    html.Url.revokeObjectUrl(url);
    if (!done.isCompleted) done.complete();
  });
  audio.onError.listen((_) {
    html.Url.revokeObjectUrl(url);
    if (!done.isCompleted) done.complete();
  });

  try {
    await audio.play();
  } catch (_) {
    html.Url.revokeObjectUrl(url);
    if (!done.isCompleted) done.complete();
    return;
  }

  await done.future;
}

Future<void> stopPlayback() async {
  _current?.pause();
  _current = null;
}
