import { STATUSES } from '../utils/storage';
import TaskCard from './TaskCard';

const COLUMN_STYLES = {
  todo: {
    header: 'bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-200',
    dot: 'bg-slate-400',
  },
  in_progress: {
    header: 'bg-blue-100 text-blue-700 dark:bg-blue-900 dark:text-blue-200',
    dot: 'bg-blue-500',
  },
  blocked: {
    header: 'bg-red-100 text-red-700 dark:bg-red-900 dark:text-red-200',
    dot: 'bg-red-500',
  },
  done: {
    header: 'bg-green-100 text-green-700 dark:bg-green-900 dark:text-green-200',
    dot: 'bg-green-500',
  },
};

export default function Board({ tasks, onMove, onUpdate, onDelete }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      {STATUSES.map((status) => {
        const columnTasks = tasks.filter((t) => t.status === status.key);
        const style = COLUMN_STYLES[status.key];
        return (
          <div key={status.key} className="flex flex-col min-h-[200px]">
            <div className={`flex items-center gap-2 px-3 py-2 rounded-t-lg ${style.header}`}>
              <span className={`w-2.5 h-2.5 rounded-full ${style.dot}`} />
              <h2 className="text-sm font-semibold">{status.label}</h2>
              <span className="ml-auto text-xs font-medium opacity-70">{columnTasks.length}</span>
            </div>
            <div className="flex-1 bg-gray-50 dark:bg-gray-800/50 rounded-b-lg p-2 space-y-2 border border-t-0 border-gray-200 dark:border-gray-700">
              {columnTasks.length === 0 ? (
                <p className="text-xs text-gray-400 dark:text-gray-500 text-center py-8">No tasks</p>
              ) : (
                columnTasks.map((task) => (
                  <TaskCard
                    key={task.id}
                    task={task}
                    onMove={onMove}
                    onUpdate={onUpdate}
                    onDelete={onDelete}
                  />
                ))
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
}
