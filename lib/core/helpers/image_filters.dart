
import 'package:vlivemooc/core/models/content/content_model/datum.dart';
import 'package:vlivemooc/core/models/firebase/fire_datum.dart';

import '../enums/device_orientation.dart';
import '../models/content/content_model/filelist.dart';
import '../models/content/content_model/poster.dart';

double getLandscapeImageHeight(double width) {
  return width * 9 / 16;
}

 getHdPosterLandscapeBasedOnGenre(
    Datum content, {String? genre}) {

  List<Poster>? posters = content.poster;
  genre ??= content.selectedGenre;
  genre ??= content.genre;

  if (posters == null) {
    return "https://d197x60o2neqwi.cloudfront.net/POSTER/wjejdtce9z_LANDSCAPE_LOW.jpg";
  }

  Poster? landscapePoster;


  for(var i = 0; i < posters.length; i++){
    Poster poster = posters[i];
    if(genre==null){
      if(poster.postertype == "LANDSCAPE"){
        landscapePoster = poster;
        break;
      }
    }else if(poster.postertags!=null )
      {

        if(poster.postertags!.contains(genre)&&poster.postertype == "LANDSCAPE"){
          landscapePoster=poster;
          break;
        }
      }
  }

landscapePoster ??= posters.firstWhere((element) => element.postertype == "LANDSCAPE");

  List<Filelist>? filesList = landscapePoster.filelist;

  if (filesList == null) {
    return "";
  }
  Filelist? filelist = filesList.firstWhere((file) => file.quality == "HD",
      orElse: () => filesList.first);

  return filelist.filename;
}

 getPosterFromFireContent(FireDatum content,{DeviceOrientation deviceOrientation=DeviceOrientation.lANDSCAPE}) {


  List<Poster>? posters = content.poster;

  Poster? landscapePoster = posters?.firstWhere(
          (posterObj) =>
      posterObj.postertype == deviceOrientation.name ,
      orElse: () => posters.firstWhere(
              (posterObj) => posterObj.postertype == "LANDSCAPE",
          orElse: () => posters.first));

  List<Filelist>? filesList = landscapePoster?.filelist;

  if (filesList == null) {
    return "";
  }
  Filelist? filelist = filesList.firstWhere((file) => file.quality == "HD",
      orElse: () => filesList.first);

  return filelist.filename;

}
