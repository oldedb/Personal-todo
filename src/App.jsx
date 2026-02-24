import { useState } from 'react';
import { useTasks } from './hooks/useTasks';
import { useTheme } from './hooks/useTheme';
import Board from './components/Board';
import SearchBar from './components/SearchBar';
import TaskForm from './components/TaskForm';
import StatsPanel from './components/StatsPanel';
import ThemeToggle from './components/ThemeToggle';

export default function App() {
  const {
    tasks,
    stats,
    addTask,
    updateTask,
    deleteTask,
    moveTask,
    searchQuery,
    setSearchQuery,
    filterStatus,
    setFilterStatus,
    filterPriority,
    setFilterPriority,
  } = useTasks();

  const { dark, toggle: toggleTheme } = useTheme();
  const [showForm, setShowForm] = useState(false);
  const [showStats, setShowStats] = useState(false);

  return (
    <div className="min-h-screen bg-gray-100 dark:bg-gray-900 transition-colors">
      {/* Header */}
      <header className="bg-white dark:bg-gray-800 shadow-sm border-b border-gray-200 dark:border-gray-700">
        <div className="max-w-7xl mx-auto px-4 py-3 flex items-center justify-between">
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">Personal Todo</h1>
          <div className="flex items-center gap-2">
            <button
              onClick={() => setShowStats(true)}
              className="p-2 rounded-lg text-gray-500 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-700 transition-colors"
              title="Stats"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
            </button>
            <ThemeToggle dark={dark} onToggle={toggleTheme} />
            <button
              onClick={() => setShowForm(true)}
              className="flex items-center gap-1.5 px-3 py-1.5 text-sm font-medium rounded-lg bg-blue-600 text-white hover:bg-blue-700 transition-colors"
            >
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
              Add Task
            </button>
          </div>
        </div>
      </header>

      {/* Main content */}
      <main className="max-w-7xl mx-auto px-4 py-6 space-y-4">
        <SearchBar
          searchQuery={searchQuery}
          onSearchChange={setSearchQuery}
          filterStatus={filterStatus}
          onStatusChange={setFilterStatus}
          filterPriority={filterPriority}
          onPriorityChange={setFilterPriority}
        />
        <Board tasks={tasks} onMove={moveTask} onUpdate={updateTask} onDelete={deleteTask} />
      </main>

      {/* Modals */}
      {showForm && <TaskForm onAdd={addTask} onClose={() => setShowForm(false)} />}
      {showStats && <StatsPanel stats={stats} onClose={() => setShowStats(false)} />}
    </div>
  );
}
