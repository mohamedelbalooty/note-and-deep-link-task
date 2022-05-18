abstract class NoteDeepLinkServiceRepository{
  void initializeDynamicLink();
  Future<void> generateDynamicLink({required String note, required String id});
}