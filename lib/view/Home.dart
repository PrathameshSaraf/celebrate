
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:sticker_view/draggable_resizable.dart';
import 'package:sticker_view/stickerview.dart';
import '../viewmodel/homeview_model.dart';

String? selectedAssetId;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          resizeToAvoidBottomInset:false,
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RepaintBoundary(
                key: stickGlobalKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  height: 390.h,
                  width: 500.w,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: GestureDetector(
                          key: const Key('stickersView_background_gestureDetector'),
                          onTap: () {},
                        ),
                      ),
                      for (final sticker in viewmodel.generateStickers())
                        DraggableResizable(
                          key: Key('stickerPage_${sticker.id}_draggableResizable_asset'),
                          canTransform: selectedAssetId == sticker.id ? true : false,
                          onUpdate: (update) {},
                          onLayerTapped: () {
                            viewmodel.onlayeredTap(sticker);
                          },
                          onEdit: () {
                            viewmodel.titleController.text=(sticker.child as Text).data!;
                            viewmodel.showPopup(context,"update");
                          },
                          onDelete: () async {
                            viewmodel.ondelete(sticker);
                          },
                          size: Size( viewmodel.fontSize* 2, viewmodel.fontSize*2),
                          constraints: BoxConstraints.tight(
                            Size(
                              viewmodel.fontSize * 1,
                              viewmodel.fontSize * 1,
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              selectedAssetId = sticker.id;
                              viewmodel.state();
                            },
                            child: SizedBox(
                              child: FittedBox(
                                child: sticker,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 19,),
              Container(
                height: 350.h,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Color selection
                    Text(
                      'Choose Color:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 10,
                        children: viewmodel.buildColorOptions(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Font size adjustment
                    Text(
                      'Adjust Font Size:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, size: 30),
                            onPressed: viewmodel.decreaseFontSize,
                          ),
                          Text(
                            'Font Size: ${viewmodel.fontSize}',
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, size: 30),
                            onPressed: viewmodel.increaseFontSize,
                          ),
                        ],
                      ),
                    ),

                    // Add Text button

                  ],
                ),
              ),
              SizedBox(height: 18.5),
              ElevatedButton(
                onPressed: () {
                  viewmodel.showPopup(context, 'edit');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text("Add Text", style: TextStyle(fontSize: 20)),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
