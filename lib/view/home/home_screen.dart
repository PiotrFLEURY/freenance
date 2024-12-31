import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/envelope/envelope_screen.dart';
import 'package:freenance/view/home/widgets/budget_edition_dialog.dart';
import 'package:freenance/view/home/widgets/drawer.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:freenance/view/home/widgets/bottom_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  // PageView controller
  final PageController _pageController = PageController();
  final HomeBottomSheetController _bottomSheetController =
      HomeBottomSheetController();
  bool _showFloatingActionButton = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _bottomSheetController.close();
    });
    ref.read(colorNotifierProvider.notifier).refreshColorTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(budgetListProvider).when(
          data: (budgetList) => _content(context, ref, budgetList),
          error: _errorScreen,
          loading: _loadingScreen,
        );
  }

  Scaffold _errorScreen(Object error, StackTrace stackTrace) {
    debugPrint('An error occurred: $error\n\n $stackTrace');
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Center(
          child: Text(
            'An error occurred: $error\n\n $stackTrace',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Scaffold _content(
    BuildContext context,
    WidgetRef ref,
    List<Budget> budgetList,
  ) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;

    return Scaffold(
      backgroundColor: mainColor,
      drawer: Drawer(
        child: FreenanceDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Freenance',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      floatingActionButton: _showFloatingActionButton
          ? FloatingActionButton(
              onPressed: () {
                final budget = budgetList[_pageController.page?.round() ?? 0];
                _addEnvelope(budget);
              },
              backgroundColor: mainColor,
              foregroundColor: Colors.white,
              child: const Icon(
                Icons.add,
              ),
            )
          : null,
      body: PageView.builder(
        controller: _pageController,
        itemCount: budgetList.length,
        itemBuilder: (context, index) {
          final currentBudget = budgetList[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              // Budget label
              InkWell(
                onLongPress: index > 0
                    ? () => _deleteBudget(context, currentBudget)
                    : null,
                onTap: () => _editBudget(context, ref, currentBudget),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    currentBudget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Spacer(),
              // Budget value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: index > 0 ? _previousPage : null,
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: index > 0 ? Colors.white : Colors.grey,
                      size: 32,
                    ),
                  ),
                  InkWell(
                    onLongPress: index > 0
                        ? () => _deleteBudget(context, currentBudget)
                        : null,
                    onTap: () => _editBudget(context, ref, currentBudget),
                    child: Text(
                      '${currentBudget.amount} €',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: index < budgetList.length - 1
                        ? _nextPage
                        : _createBudget,
                    icon: Icon(
                      index < budgetList.length - 1
                          ? Icons.arrow_circle_right_outlined
                          : Icons.add_circle_outline_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Bottom sheet
              HomeBottomSheet(
                currentBudget: currentBudget,
                onAddEnvelope: () => _addEnvelope(currentBudget),
                onEditEnvelope: (envelope) => _editEnvelope(envelope),
                onDeleteEnvelope: (envelope) => _deleteEnvelope(
                  context,
                  currentBudget,
                  envelope,
                ),
                onSizeChanged: _expansionListener,
                controller: _bottomSheetController,
              ),
            ],
          );
        },
      ),
    );
  }

  Scaffold _loadingScreen() {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  // Callback functions

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _createBudget() {
    ref.read(budgetRepositoryProvider).createNewBudget();
    ref.invalidate(budgetListProvider);
    _nextPage();
  }

  Future<void> _editBudget(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
  ) async {
    final editedBudget = await showDialog(
      context: context,
      builder: (context) => BudgetEditionDialog(
        budget: budget,
      ),
    );
    if (editedBudget != null) {
      ref.read(budgetRepositoryProvider).saveBudget(editedBudget);
      ref.invalidate(budgetListProvider);
    }
  }

  Future<void> _deleteBudget(BuildContext context, Budget budget) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Supprimer le budget ?'),
          content: Text('Voulez-vous vraiment supprimer ce budget ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
    if (confirm) {
      ref.read(budgetRepositoryProvider).deleteBudget(budget);
      ref.invalidate(budgetListProvider);
    }
  }

  void _addEnvelope(Budget budget) {
    ref.read(budgetRepositoryProvider).addEnvelope(budget);
    ref.invalidate(budgetListProvider);
  }

  void _editEnvelope(Envelope envelope) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EnvelopeScreen(
          envelopeId: envelope.id,
        ),
      ),
    );
  }

  void _deleteEnvelope(
    BuildContext context,
    Budget budget,
    Envelope envelope,
  ) {
    // First remove the envelope from the budget in order to
    // avoid dissmisible error
    budget.envelopes.remove(envelope);
    ref.read(budgetRepositoryProvider).deleteEnvelope(envelope);
    ref.invalidate(budgetListProvider);
  }

  void _expansionListener(bool isExpanded) {
    setState(() {
      _showFloatingActionButton = isExpanded;
    });
  }
}
