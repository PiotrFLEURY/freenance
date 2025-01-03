import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/home/widgets/bottom_bar.dart';
import 'package:freenance/view/home/widgets/drawer.dart';
import 'package:freenance/view/router/voyager.dart';
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

  @override
  void initState() {
    super.initState();
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
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: budgetList.length,
        itemBuilder: (context, index) {
          final currentBudget = budgetList[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  index > 0
                      ? IconButton(
                          onPressed: index > 0 ? _previousPage : null,
                          icon: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        )
                      : SizedBox(width: 48),
                  InkWell(
                    onLongPress: index > 0
                        ? () => _deleteBudget(context, currentBudget)
                        : null,
                    onTap: () => _editBudget(context, ref, currentBudget),
                    child: Text(
                      '${currentBudget.amount} €',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
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
                      size: 24,
                    ),
                  ),
                ],
              ),
              // Budget label
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  currentBudget.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (currentBudget.envelopesAmountTooHigh)
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                  ),
                  child: Text(
                    'Budget dépassé de ${currentBudget.envelopesAmountExcedent.toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[400]!,
                      Colors.grey[200]!,
                    ],
                  ),
                ),
              ),
              // Bottom sheet
              Expanded(
                child: HomeBottomSheet(
                  currentBudget: currentBudget,
                  onAddEnvelope: () => _addEnvelope(currentBudget),
                  onEditEnvelope: (envelope) => _editEnvelope(envelope),
                  onDeleteEnvelope: (envelope) => _deleteEnvelope(
                    context,
                    currentBudget,
                    envelope,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomBar(
        onAddEnvelope: () {
          final budget = budgetList[_pageController.page?.round() ?? 0];
          _addEnvelope(budget);
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

  Future<void> _createBudget() async {
    final values = await Voyager.pushEdition(
      context,
      'Créer un budget',
      'Nouveau Budget',
      0,
    );
    if (values == null) {
      return;
    }
    ref.read(budgetRepositoryProvider).createNewBudget(
          values.$1,
          values.$2,
        );
    ref.invalidate(budgetListProvider);
    _nextPage();
  }

  Future<void> _editBudget(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
  ) async {
    final values = await Voyager.pushEdition(
      context,
      'Modifier le budget',
      budget.label,
      budget.amount,
    );

    if (values != null) {
      final editedBudget = budget.copyWith(
        label: values.$1,
        amount: values.$2,
      );
      ref.read(budgetRepositoryProvider).saveBudget(editedBudget);
      ref.invalidate(budgetListProvider);
    }
  }

  Future<void> _deleteBudget(BuildContext context, Budget budget) async {
    final confirm = await Voyager.confirm(
      context,
      'Supprimer le budget ?',
      'Êtes-vous sûr de vouloir supprimer le budget "${budget.label}" ?\n\nCette action est irréversible.\nToutes les enveloppes et les opérations liées seront définitivement supprimées.',
    );
    if (confirm) {
      ref.read(budgetRepositoryProvider).deleteBudget(budget);
      ref.invalidate(budgetListProvider);
    }
  }

  Future<void> _addEnvelope(Budget budget) async {
    (String, double)? values = await Voyager.pushEdition(
      context,
      'Ajouter une enveloppe',
      'Nouvelle enveloppe',
      0,
    );
    if (values == null) {
      return;
    }
    ref.read(budgetRepositoryProvider).addEnvelope(
          budget,
          values.$1,
          values.$2,
        );
    ref.invalidate(budgetListProvider);
  }

  void _editEnvelope(Envelope envelope) {
    Voyager.pushEnvelope(context, envelope);
  }

  Future<void> _deleteEnvelope(
    BuildContext context,
    Budget budget,
    Envelope envelope,
  ) async {
    final confirm = await Voyager.confirm(
      context,
      'Supprimer l\'enveloppe ?',
      'Etes-vous sûr de vouloir supprimer l\'enveloppe "${envelope.label}" ?\n\nCette action est irréversible.\nToutes les opérations liées seront définitivement supprimées.',
    );
    if (!confirm) {
      return;
    }
    // First remove the envelope from the budget in order to
    // avoid dissmisible error
    budget.envelopes.remove(envelope);
    ref.read(budgetRepositoryProvider).deleteEnvelope(envelope);
    ref.invalidate(budgetListProvider);
  }
}
