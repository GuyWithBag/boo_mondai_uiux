import { useSettings } from '../contexts/useSettings';

export default function Settings() {
  const { showNotchMargin, setShowNotchMargin } = useSettings();

  return (
    <div className="p-6 max-w-2xl mx-auto">
      <h1 className="text-3xl font-extrabold text-gray-900 mb-8">Settings</h1>
      
      <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
        <div className="p-6 border-b border-gray-100">
          <h2 className="text-xl font-bold text-gray-800">Appearance</h2>
          <p className="text-gray-500 text-sm mt-1">Customize how BooMondai looks for you.</p>
        </div>
        
        <div className="p-6 space-y-6">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-bold text-gray-800">Screenshot Mode (Notch Margin)</h3>
              <p className="text-sm text-gray-500 max-w-md">
                Adds a margin at the top of the app to simulate or make room for device notches. 
                Useful for taking clean screenshots.
              </p>
            </div>
            <button 
              onClick={() => setShowNotchMargin(!showNotchMargin)}
              className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 ${
                showNotchMargin ? 'bg-indigo-600' : 'bg-gray-200'
              }`}
            >
              <span
                className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                  showNotchMargin ? 'translate-x-6' : 'translate-x-1'
                }`}
              />
            </button>
          </div>
          <div className="flex items-center justify-between pt-4 border-t border-gray-100">
            <div>
              <h3 className="font-bold text-gray-800">Assets</h3>
              <p className="text-sm text-gray-500">Download the app icon assets.</p>
            </div>
            <a
              href="/icons.svg"
              download="boo-mondai-icons.svg"
              className="flex items-center gap-2 px-4 py-2 bg-white border-2 border-gray-200 rounded-xl font-bold text-gray-700 hover:border-indigo-500 hover:text-indigo-600 transition-colors"
            >
              <i className="fa-solid fa-download text-sm"></i>
              Download Icons
            </a>
          </div>
        </div>
      </div>
      
      <div className="mt-8 p-4 bg-indigo-50 rounded-xl border border-indigo-100">
        <div className="flex gap-3">
          <i className="fa-solid fa-circle-info text-indigo-500 mt-1"></i>
          <p className="text-sm text-indigo-700">
            <strong>Pro Tip:</strong> When enabled, a 40px margin is added to the top of the entire application.
          </p>
        </div>
      </div>
    </div>
  );
}
