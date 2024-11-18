
import 'truemetrics_platform_interface.dart';

class Truemetrics {


  Future<String> initialize(String apiKey){
    return TruemetricsPlatform.instance.initialize(apiKey);
  }
  Future<bool> startRecording()async{
   return TruemetricsPlatform.instance.startRecording();
  }


  String startListening( ) {
    return TruemetricsPlatform.instance.startListening();
  }

  void stopRecording() async{
    TruemetricsPlatform.instance.stopRecording();
  }

  void deinit(){
    TruemetricsPlatform.instance.deinit();
  }

  void logMetaData(Map<String, String> data){
    TruemetricsPlatform.instance.logMetaData(data);
  }

}
