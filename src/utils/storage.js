const STORAGE_KEY = 'personal-todo-tasks';

export function loadTasks() {
  try {
    const data = localStorage.getItem(STORAGE_KEY);
    return data ? JSON.parse(data) : [];
  } catch {
    return [];
  }
}

export function saveTasks(tasks) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(tasks));
}

export function createTask({ title, description = '', priority = 'medium' }) {
  return {
    id: crypto.randomUUID(),
    title,
    description,
    priority,
    status: 'todo',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };
}

export const STATUSES = [
  { key: 'todo', label: 'To Do', color: 'slate' },
  { key: 'in_progress', label: 'In Progress', color: 'blue' },
  { key: 'blocked', label: 'Blocked', color: 'red' },
  { key: 'done', label: 'Done', color: 'green' },
];

export const PRIORITIES = ['low', 'medium', 'high'];
