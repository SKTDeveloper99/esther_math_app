import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esther_math_app/classes/users.dart';
import 'package:esther_math_app/firebase/auth/auth.dart';
import 'package:esther_math_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math' as math;

/// Displayed as a profile image if the user doesn't have one.
const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/en/thumb/7/70/Bob_at_Easel.jpg/220px-Bob_at_Easel.jpg';

/// Profile page shows after sign in or registerationg
class ProfilePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const ProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  late TextEditingController controller;
  final phoneController = TextEditingController();
  late final DocumentReference<Users> userRef;

  String? photoURL;

  bool showSaveButton = false;
  bool isLoading = false;

  @override
  void initState(){
    user = auth.currentUser!;
    userRef = cloudFirestore.collection("user").doc(user.uid).withConverter(
      fromFirestore: Users.fromFirestore,
      toFirestore: (Users user, _) => user.toFirestore(),
    );
    controller = TextEditingController(text: user.displayName);
    controller.addListener(_onNameChanged);


    auth.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onNameChanged);
    super.dispose();
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _onNameChanged() {
    setState(() {
      if (controller.text == user.displayName || controller.text.isEmpty) {
        showSaveButton = false;
      } else {
        showSaveButton = true;
      }
    });
  }

  /// Map User provider data into a list of Provider Ids.
  List get userProviders => user.providerData.map((e) => e.providerId).toList();

  Future updateDisplayName() async {
    await user.updateDisplayName(controller.text);

    setState(() {
      showSaveButton = false;
    });

    // ignore: use_build_context_synchronously
    ScaffoldSnackbar.of(context).show('Name updated');
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                maxRadius: 90,
                                backgroundImage: NetworkImage(
                                  user.photoURL ?? placeholderImage,
                                ),
                              ),
                              Positioned.directional(
                                textDirection: Directionality.of(context),
                                end: 0,
                                bottom: 0,
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(40),
                                  child: InkWell(
                                    onTap: () async {
                                      final photoURL = await getPhotoURLFromUser();

                                      if (photoURL != null) {
                                        await user.updatePhotoURL(photoURL);
                                      }
                                    },
                                    radius: 50,
                                    child: const SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            style: const TextStyle(
                              fontSize: 40,
                            ),
                            textAlign: TextAlign.center,
                            controller: controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              alignLabelWithHint: true,
                              label: Center(
                                child: SizedBox(
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    'Click to add a display name',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            user.email ?? user.phoneNumber ?? 'User',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (userProviders.contains('phone'))
                                const Icon(Icons.phone),
                              if (userProviders.contains('password'))
                                const Icon(
                                  Icons.mail,
                                  size: 35,
                                ),
                              if (userProviders.contains('google.com'))
                                SizedBox(
                                  width: 24,
                                  child: Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png',
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          Text(
                            "Gender: ${data.data()!.gender}",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Age: ${data.data()!.age}",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Date Of Birth: ${data.data()!.dob}",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "Motto: ${data.data()!.motto}",
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height/8,
                            child: data.data()!.favMathematicians!.isEmpty ? Center(child: Text('Empty')):ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.data()!.favMathematicians!.length,
                              prototypeItem: Card(
                                  child: Row(
                                    children: [
                                      Text(data.data()!.favMathematicians!.first),
                                    ],
                                  ),
                              ),
                              itemBuilder: (context,index) {
                                String mathDude = data.data()!.favMathematicians![index];
                                return Card(
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(mathDude)),
                                      ],
                                    )
                                );
                              }
                            ),
                          ),
                          const Divider(),
                          const Text(
                              "Favorite Problems: "
                          ),
                          const Divider(),
                          TextButton(
                            onPressed: _signOut,
                            child: const Text(
                              'Sign out',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 40,
                  top: 40,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: !showSaveButton
                        ? SizedBox(key: UniqueKey())
                        : TextButton(
                      onPressed: isLoading ? null : updateDisplayName,
                      child: const Text('Save changes'),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Future<String?> getPhotoURLFromUser() async {
    String? photoURL;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('New image Url:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            OutlinedButton(
              onPressed: () {
                photoURL = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                photoURL = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return photoURL;
  }

  /// Example code for sign out.
  Future<void> _signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton.extended(
            onPressed: _toggle,
            label: const Text("Create Health Log"),
            // child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      //shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: ElevatedButton(
        onPressed: onPressed,
        // style: const ButtonStyle(
        //   backgroundColor: MaterialStatePropertyAll<Color>(Colors.yellow),
        // ),
        child: text,
        // icon: icon,
        // color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
