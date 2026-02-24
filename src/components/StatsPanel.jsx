import { STATUSES } from '../utils/storage';

const STATUS_BAR_COLORS = {
  todo: 'bg-slate-400',
  in_progress: 'bg-blue-500',
  blocked: 'bg-red-500',
  done: 'bg-green-500',
};

const PRIORITY_BAR_COLORS = {
  low: 'bg-green-500',
  medium: 'bg-yellow-500',
  high: 'bg-red-500',
};

function BarChart({ label, value, max, colorClass }) {
  const pct = max > 0 ? (value / max) * 100 : 0;
  return (
    <div className="flex items-center gap-2">
      <span className="text-xs text-gray-600 dark:text-gray-400 w-20 truncate">{label}</span>
      <div className="flex-1 h-4 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">
        <div
          className={`h-full rounded-full transition-all duration-500 ${colorClass}`}
          style={{ width: `${pct}%` }}
        />
      </div>
      <span className="text-xs font-medium text-gray-700 dark:text-gray-300 w-6 text-right">{value}</span>
    </div>
  );
}

export default function StatsPanel({ stats, onClose }) {
  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white dark:bg-gray-800 rounded-xl shadow-xl w-full max-w-lg p-6 space-y-6">
        <div className="flex items-center justify-between">
          <h2 className="text-lg font-semibold text-gray-900 dark:text-white">Stats Dashboard</h2>
          <button
            onClick={onClose}
            className="p-1 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        {/* Summary cards */}
        <div className="grid grid-cols-2 gap-3">
          <div className="bg-blue-50 dark:bg-blue-900/30 rounded-lg p-3 text-center">
            <p className="text-2xl font-bold text-blue-600 dark:text-blue-400">{stats.total}</p>
            <p className="text-xs text-blue-500 dark:text-blue-300">Total Tasks</p>
          </div>
          <div className="bg-green-50 dark:bg-green-900/30 rounded-lg p-3 text-center">
            <p className="text-2xl font-bold text-green-600 dark:text-green-400">{stats.completionRate}%</p>
            <p className="text-xs text-green-500 dark:text-green-300">Completion Rate</p>
          </div>
        </div>

        {/* By Status */}
        <div>
          <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">By Status</h3>
          <div className="space-y-2">
            {STATUSES.map((s) => (
              <BarChart
                key={s.key}
                label={s.label}
                value={stats.byStatus[s.key]}
                max={stats.total}
                colorClass={STATUS_BAR_COLORS[s.key]}
              />
            ))}
          </div>
        </div>

        {/* By Priority */}
        <div>
          <h3 className="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">By Priority</h3>
          <div className="space-y-2">
            {['low', 'medium', 'high'].map((p) => (
              <BarChart
                key={p}
                label={p.charAt(0).toUpperCase() + p.slice(1)}
                value={stats.byPriority[p]}
                max={stats.total}
                colorClass={PRIORITY_BAR_COLORS[p]}
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
