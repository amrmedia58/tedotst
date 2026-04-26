// lib/screens/home/home_screen.dart
// Owner: Sara
// Branch: feature/home-screen
//
// *** DO NOT EDIT if you are not Sara ***
// If you need to change shared widgets, edit lib/widgets/todo_card.dart
// and message the team first.

import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../../../widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ─── App colour (used throughout) ────────────────────────────────────────
  static const Color kPrimary = Color(0xFF6C63FF);
  static const Color kBackground = Color(0xFFF5F5F7);

  // ─── Current filter ──────────────────────────────────────────────────────
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Todo', 'In progress', 'Done'];

  // ─── Add-task dialog controllers ─────────────────────────────────────────
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  TaskCategory _newCategory = TaskCategory.work;

  // ─── Sample task data (replace with a real service later) ─────────────────
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Set up GitHub repository',
      description: 'Init repo, push main branch',
      status: TaskStatus.done,
      category: TaskCategory.work,
      assignedTo: 'Ali',
    ),
    Task(
      id: '2',
      title: 'Design home screen UI',
      description: 'Todo list with filter chips',
      status: TaskStatus.inProgress,
      category: TaskCategory.work,
      assignedTo: 'Sara',
    ),
    Task(
      id: '3',
      title: 'Write commit messages',
      description: 'Use conventional commits format',
      status: TaskStatus.todo,
      category: TaskCategory.study,
      assignedTo: 'Sara',
    ),
    Task(
      id: '4',
      title: 'Open pull request',
      description: 'Target: develop branch',
      status: TaskStatus.todo,
      category: TaskCategory.work,
      assignedTo: 'Sara',
    ),
    Task(
      id: '5',
      title: 'Review team screens',
      description: 'Omar & Layla PR review',
      status: TaskStatus.todo,
      category: TaskCategory.personal,
      assignedTo: 'Sara',
    ),
    Task(
      id: '6',
      title: 'Fix merge conflict',
      description: 'Resolve conflict in home_screen.dart',
      status: TaskStatus.urgent.index < 0 ? TaskStatus.todo : TaskStatus.todo,
      category: TaskCategory.urgent,
      assignedTo: 'Sara',
    ),
  ];

  // ─── Computed getters ─────────────────────────────────────────────────────
  List<Task> get _filteredTasks {
    switch (_selectedFilter) {
      case 'Todo':
        return _tasks.where((t) => t.status == TaskStatus.todo).toList();
      case 'In progress':
        return _tasks.where((t) => t.status == TaskStatus.inProgress).toList();
      case 'Done':
        return _tasks.where((t) => t.status == TaskStatus.done).toList();
      default:
        return _tasks;
    }
  }

  int get _doneCount => _tasks.where((t) => t.isDone).length;
  int get _totalCount => _tasks.length;
  double get _progress => _totalCount == 0 ? 0 : _doneCount / _totalCount;

  // ─── Handlers ─────────────────────────────────────────────────────────────
  void _toggleTask(Task task) {
    setState(() => task.toggleDone());
  }

  void _deleteTask(Task task) {
    setState(() => _tasks.remove(task));
  }

  void _addTask() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description:
        _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        category: _newCategory,
        assignedTo: 'Sara',
      ));
    });

    _titleController.clear();
    _descController.clear();
    _newCategory = TaskCategory.work;
    Navigator.of(context).pop();
  }

  // ─── Add-task bottom sheet ─────────────────────────────────────────────────
  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3D1C7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'New task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title field
                  TextField(
                    controller: _titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Task title',
                      hintStyle: const TextStyle(color: Color(0xFFB4B2A9)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Description field
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: 'Description (optional)',
                      hintStyle: const TextStyle(color: Color(0xFFB4B2A9)),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category selector
                  const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5F5E5A)),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: TaskCategory.values.map((cat) {
                      final labels = {
                        TaskCategory.work: 'work',
                        TaskCategory.study: 'study',
                        TaskCategory.personal: 'personal',
                        TaskCategory.urgent: 'urgent',
                      };
                      final colors = {
                        TaskCategory.work: kPrimary,
                        TaskCategory.study: const Color(0xFF1D9E75),
                        TaskCategory.personal: const Color(0xFFD4537E),
                        TaskCategory.urgent: const Color(0xFFE24B4A),
                      };
                      final selected = _newCategory == cat;
                      final color = colors[cat]!;
                      return GestureDetector(
                        onTap: () => setSheetState(() => _newCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: selected
                                ? color
                                : color.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            labels[cat]!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: selected ? Colors.white : color,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Add button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Add task',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildProgressCard(),
            _buildFilterChips(),
            Expanded(child: _buildTaskList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        backgroundColor: kPrimary,
        elevation: 2,
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF888780),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'My Tasks',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C2C2A),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'S',
                style: TextStyle(
                  color: kPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Progress card ────────────────────────────────────────────────────────
  Widget _buildProgressCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$_doneCount / $_totalCount tasks',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _progress == 1.0
                ? 'All done! Great work.'
                : '${((_progress) * 100).toInt()}% complete — keep going!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Filter chips ─────────────────────────────────────────────────────────
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 0, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) {
            final bool selected = _selectedFilter == filter;
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(right: 8),
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? kPrimary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? kPrimary : const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? Colors.white : const Color(0xFF5F5E5A),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ─── Task list ────────────────────────────────────────────────────────────
  Widget _buildTaskList() {
    final tasks = _filteredTasks;

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline,
                size: 56, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              _selectedFilter == 'All'
                  ? 'No tasks yet. Tap + to add one!'
                  : 'No tasks in "$_selectedFilter"',
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFFB4B2A9)),
            ),
          ],
        ),
      );
    }

    // Section: pending first, then done
    final pending = tasks.where((t) => !t.isDone).toList();
    final done = tasks.where((t) => t.isDone).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
      children: [
        if (pending.isNotEmpty) ...[
          _sectionLabel('Pending (${pending.length})'),
          ...pending.map((task) => TodoCard(
            key: ValueKey(task.id),
            task: task,
            onToggle: () => _toggleTask(task),
            onDelete: () => _deleteTask(task),
          )),
        ],
        if (done.isNotEmpty) ...[
          const SizedBox(height: 8),
          _sectionLabel('Completed (${done.length})'),
          ...done.map((task) => TodoCard(
            key: ValueKey(task.id),
            task: task,
            onToggle: () => _toggleTask(task),
            onDelete: () => _deleteTask(task),
          )),
        ],
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF888780),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────
  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning, Sara';
    if (hour < 17) return 'Good afternoon, Sara';
    return 'Good evening, Sara';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}