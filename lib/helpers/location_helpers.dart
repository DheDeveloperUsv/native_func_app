const MAPBOX_API_KEY =
    'pk.eyJ1IjoiZGhlIiwiYSI6ImNrdnFybGw4ZzI1cWgycm91MXBpcW9oN3kifQ.fzK2_BFZrGU_vMpwTuU2Kg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    //return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14/600x600?access_token=$MAPBOX_API_KEY';
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
    //return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/[$longitude,$latitude,38.904192]/400x400?padding=50,10,20&access_token=$MAPBOX_API_KEY';
  }
}
