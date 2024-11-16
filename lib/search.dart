import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/models/intra_user_short.dart';
import 'package:swifty_companion/providers/intra_api_provider.dart';

class SearchPage extends StatefulWidget {
  // final Function() clearError;
  // final Function(String) setError;

  const SearchPage({
    super.key,
    // required this.clearError, required this.setError
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IntraApiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search 42 users'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TypeAheadField(
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  hintText: 'Search for a user',
                  border: OutlineInputBorder(),
                ),
                onTapOutside: (event) => focusNode.unfocus(),
                // onTap: () => widget.clearError(),
              );
            },
            onSelected: (IntraUserShort? value) {
              if (value?.id != null) {
                  provider.setSelectedUser(value!.id);
              }
            },
            itemBuilder: (BuildContext context, IntraUserShort value) {
              return ListTile(
                leading: value.imageUrl != null
                    ? ClipOval(
                        child: Image.network(
                          value.imageUrl!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.person, size: 48,),
                title: Text(value.displayName),
                subtitle: Text(value.login),
              );
            },
            suggestionsCallback: (String search) {
              return provider.searchUsers(search);
            },
          ),
        ],
      ),
    );
  }
}
