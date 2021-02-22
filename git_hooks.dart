import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:git_hooks/git_hooks.dart';

void main(List<String> arguments) {
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  change(arguments, params);
}

Future<bool> commitMsg() async {
  Directory rootDir = Directory.current;
  File myFile = new File(rootDir.path + "/.git/COMMIT_EDITMSG");
  var commitMsg = myFile.readAsStringSync();

  if (commitMsg.startsWith('feat:')) {
    return true;
  }

  if (commitMsg.startsWith('fix:')) {
    return true;
  }

  if (commitMsg.startsWith('docs:')) {
    return true;
  }

  if (commitMsg.startsWith('style:')) {
    return true;
  }

  if (commitMsg.startsWith('refactor:')) {
    return true;
  }

  if (commitMsg.startsWith('test:')) {
    return true;
  }

  if (commitMsg.startsWith('chore:')) {
    return true;
  }

  print(
      "ERROR: Please input start with feat:, fix:, docs:, style:, refactor:, text:, chore: commit message!");

  return false;
}

Future<bool> preCommit() async {
  print('this is pre-commit');
  return true;
}
