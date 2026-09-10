import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme.dart';
import '../controllers/user_controller.dart';
import 'todolist_screen.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final UserController controller = Get.put(UserController());

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaModu,
            builder: (context, currentMode, child) {
              return IconButton(
                icon: Icon(
                  currentMode == ThemeMode.dark
                      ? Icons.nightlight_round
                      : Icons.sunny,
                ),
                color: Colors.teal,
                onPressed: toggleTheme,
              );
            },
          ),
        ],
      ),
      body: Obx((){
        if(controller.isLoading.value){
          return const Center(child: CircularProgressIndicator()
         );
        }
        if(controller.error.value.isNotEmpty){
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.error.value, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchUsers,
                  child: const Text('Tekrar Dene')),
              ],
            ),
          );
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kullanıcılar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.initials)),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () => Get.to(() => TodoListScreen(user: user)),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
