import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/cubits/send_picture/send_picture_state.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/item_detect_response.dart';
import 'package:recipe_app/models/recipe_details.dart';

class SendPictureCubit extends Cubit<SendPicture> {
  SendPictureCubit() : super(SendPictureInitial());
  late int srno;
  Future<void> sendPicture(XFile pictureFile) async {
    try {
      List<int> imageBytes = await pictureFile.readAsBytes();
      final Uri apiUrl =
          Uri.parse('http://127.0.0.1:8000/img_object_detection_to_recipe');
      var request = http.MultipartRequest('POST', apiUrl);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
      ));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(responseData);
      emit(SendPictureSuccess(RecipeResponse.fromJson(responseJson)));
    } catch (e) {
      emit(SendPictureError(e.toString()));
    }
  }

  // Future<void> getRecipe({required srno}) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('http://127.0.0.1:8000/recipe/$srno'),
  //     );
  //     if (response.statusCode == 200) {
  //       final recipeDetailsJson = json.decode(response.body);
  //       final recipeDetails = RecipeDetails.fromJson(recipeDetailsJson);
  //       emit(GetRecipeSuccess(recipeDetails));
  //     } else {
  //       throw Exception('Failed to load recipe details');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     emit(SendPictureError(e.toString()));
  //   }
  // }
}
