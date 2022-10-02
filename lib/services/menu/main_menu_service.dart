import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Informs whenever the menu is being expanded or collapsed.
///
/// Note: the menu should ever be expanded in desktop size.
final menuExpansionProvider = StateProvider<bool>((ref) {
  return false;
});
