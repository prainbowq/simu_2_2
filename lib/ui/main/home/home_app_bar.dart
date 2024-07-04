import 'package:flutter/material.dart';
import 'package:igo/main.dart';

AppBar homeAppBar({
  required final String category,
  required final ValueChanged<String> onCategoryChanged,
  required final bool descending,
  required final ValueChanged<bool> onDescendingChanged,
  required final bool grid,
  required final ValueChanged<bool> onGridChanged,
}) =>
    AppBar(
      leading: Image.asset('$imagesPrefix/iGO _Logo.jpg'),
      title: TextField(
        decoration: InputDecoration(
          hintText: '輸入您想找的商品',
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const ImageIcon(AssetImage('$imagesPrefix/loupe.png')),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const ImageIcon(AssetImage('$imagesPrefix/document.png')),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Row(
          children: [
            ...categories
                .map((item) => TextButton(
                      onPressed: () => onCategoryChanged(item),
                      child: Text(
                        item,
                        style: category == item
                            ? const TextStyle(
                                decoration: TextDecoration.underline,
                              )
                            : null,
                      ),
                    ))
                .toList(),
            const Spacer(),
            TextButton.icon(
              onPressed: () => onDescendingChanged(!descending),
              icon: ImageIcon(
                AssetImage(
                  '$imagesPrefix/${descending ? 'de' : 'a'}scending-sort.png',
                ),
              ),
              label: const Text('價格'),
            ),
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(AssetImage('$imagesPrefix/filter.png')),
            ),
            IconButton(
              onPressed: () => onGridChanged(!grid),
              icon: const ImageIcon(AssetImage('$imagesPrefix/list.png')),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow[50],
      foregroundColor: Colors.black,
    );
