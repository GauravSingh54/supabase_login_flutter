import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_login_flutter/main.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.imageUrl, required this.onUpload});

  final String? imageUrl;
  final void Function(String imageUrl) onUpload;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey,
                  child: Text('No Image'),
                ),
        ),
        SizedBox(
          height: 12,
        ),
        ElevatedButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image == null) {
              return;
            }
            final imageBytes = await image.readAsBytes();
            final userId = supabase.auth.currentUser!.id;
            final imagePath = '/$userId/profile';
            await supabase.storage
                .from('profiles')
                .uploadBinary(imagePath, imageBytes);
            final imageUrl =
                supabase.storage.from('profiles').getPublicUrl(imagePath);
            onUpload(imageUrl);
          },
          child: Text('Upload'),
        )
      ],
    );
  }
}
