import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_user_listing_demo/features/user_listing/display/providers/user_provider.dart';
import 'package:provider/provider.dart';


class UserListing extends StatefulWidget {
  const UserListing({Key? key}) : super(key: key);
  @override
  _UserListingState createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {

  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
        {
          Provider.of<UserProvider>(context, listen: false).fetchUsers();
        }
    });

    Provider.of<UserProvider>(context, listen: false).fetchUsers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(

        builder: (context, data, child){

          return data.uiState == UIState.loading?
              const Center(
                child: CircularProgressIndicator(),
              ):
              data.uiState == UIState.error?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.error!.errorMessage!),
                        IconButton(onPressed: (){
                          Provider.of<UserProvider>(context, listen: false).fetchUsers();
                        }, icon: const Icon(Icons.refresh))
                      ],
                    ),
                  ):
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                      controller: scrollController,
                      itemCount:  data.users.length,
                      itemBuilder: (context, index){
                      var user = data.users[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2), // Border width
                                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(40), // Image radius
                                      child: CachedNetworkImage(
                                        imageUrl: user.avatar,
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Text(user.name, style:const TextStyle(
                                    fontSize: 12
                                  ),),
                                )
                              ],
                            ),
                        Checkbox(
                        value: user.isSelected,
                        onChanged:(value){
                        if(value == true)
                          {
                            user.isSelected = value!;
                            data.saveUser(user);
                          }
                        else
                          {
                            data.deleteUser(user);
                            data.changeCheckboxState(user);
                          }
                        }
                        ),
                          ],
                        ),
                      ),
                    );

                  });

        },

      ),
    );
  }
}
