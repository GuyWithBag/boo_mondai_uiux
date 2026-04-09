import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { useSettings } from "../contexts/useSettings";

// --- Types ---
type QuestionFormat = "normal" | "mcq" | "blanks" | "match";
type StudyDirection = "normal" | "reversed" | "both";

// Removed the { onClose: () => void } prop requirement!
export default function CreatorStudio() {
  const navigate = useNavigate();
  const { showNotchMargin } = useSettings(); // Use hook

  const [format, setFormat] = useState<QuestionFormat>("normal");
  const [direction, setDirection] = useState<StudyDirection>("normal");

  // Helper function to handle closing
  const handleClose = () => {
    navigate("/decks"); // Route back to the decks page
  };

  return (
    <div className={`absolute inset-0 z-50 bg-[#F8F9FA] flex flex-col w-full h-full animate-[fadeIn_0.3s_ease-out] ${showNotchMargin ? 'pt-10' : 'pt-0'}`}>
      {/* Top Bar */}
      <header className="bg-white border-b border-gray-200 px-4 py-3 md:px-6 md:py-4 flex flex-wrap items-center justify-between gap-4 z-20 shadow-sm shrink-0">
        <div className="flex items-center gap-3 md:gap-4 flex-1">
          {/* Replaced onClose with handleClose */}
          <button
            onClick={handleClose}
            className="w-10 h-10 rounded-xl bg-gray-100 text-gray-500 hover:bg-gray-200 flex items-center justify-center transition-colors"
          >
            <i className="fa-solid fa-arrow-left"></i>
          </button>
          <div className="flex flex-col min-w-0">
            <div className="flex items-center gap-2">
              <span className="bg-indigo-50 text-indigo-500 text-[10px] font-bold px-2 py-0.5 rounded uppercase tracking-wider border border-indigo-100">
                Draft
              </span>
              <button className="hidden sm:block text-xs text-gray-400 font-medium transition-colors">
                <i className="fa-solid fa-lock text-[10px]"></i> Private
              </button>
            </div>
            <input
              type="text"
              defaultValue="New Untitled Deck"
              className="text-lg md:text-xl font-extrabold text-gray-900 bg-transparent border-none outline-none focus:ring-0 p-0 placeholder-gray-300 min-w-[120px] max-w-[200px] md:w-64"
            />
          </div>
        </div>
        {/* Replaced onClose with handleClose */}
        <button
          onClick={handleClose}
          className="active:translate-y-1 active:shadow-none transition-all bg-indigo-500 text-white px-4 py-2 md:px-6 md:py-2 rounded-xl font-bold shadow-[0_4px_0_0_#3F498A] hover:bg-indigo-600 text-sm md:text-base"
        >
          Save & Close
        </button>
      </header>

      <div className="flex flex-1 overflow-hidden">
        {/* Left Sidebar (Cards) */}
        <aside className="hidden md:flex w-64 bg-white border-r border-gray-200 flex-col shrink-0">
          <div className="p-4 border-b border-gray-200 flex justify-between items-center bg-gray-50">
            <h3 className="font-bold text-gray-700">Cards (1)</h3>
            <button className="active:translate-y-1 active:shadow-none transition-all w-8 h-8 rounded-lg bg-gray-200 text-gray-600 hover:bg-gray-300 flex items-center justify-center shadow-[0_2px_0_0_#D1D5DB]">
              <i className="fa-solid fa-plus"></i>
            </button>
          </div>
          <div className="flex-1 overflow-y-auto p-2 space-y-1">
            <div className="p-3 rounded-xl bg-indigo-50 border border-indigo-500 cursor-pointer flex gap-3 items-center">
              <div className="text-indigo-500">
                <i className="fa-regular fa-square-caret-right"></i>
              </div>
              <div className="flex-1 truncate text-sm font-bold text-indigo-500">
                New Card
              </div>
            </div>
          </div>
        </aside>

        {/* Main Editor */}
        <main className="flex-1 overflow-y-auto p-6 md:p-8">
          <div className="max-w-5xl mx-auto space-y-8">
            {/* Format Selection */}
            <section>
              <div className="flex justify-between items-end mb-3">
                <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest">
                  1. Question Format
                </h2>
              </div>
              <div className="flex gap-2 overflow-x-auto no-scrollbar pb-2">
                <FormatButton
                  active={format === "normal"}
                  icon="fa-square-caret-right"
                  label="Flashcard"
                  onClick={() => setFormat("normal")}
                />
                <FormatButton
                  active={format === "mcq"}
                  icon="fa-list-ul"
                  label="Multiple Choice"
                  onClick={() => setFormat("mcq")}
                />
                <FormatButton
                  active={format === "blanks"}
                  icon="fa-pen-ruler"
                  label="Fill in Blanks"
                  onClick={() => setFormat("blanks")}
                />
                <FormatButton
                  active={format === "match"}
                  icon="fa-shuffle"
                  label="Match Madness"
                  onClick={() => setFormat("match")}
                />
              </div>
            </section>

            {/* Conditionally Rendered Study Direction */}
            {format === "normal" && (
              <section className="bg-white p-4 rounded-2xl border border-gray-200 flex flex-col md:flex-row md:items-center justify-between gap-4 shadow-sm animate-[fadeIn_0.3s_ease-out]">
                <div>
                  <h3 className="font-bold text-gray-900">Study Direction</h3>
                  <p className="text-xs text-gray-500 font-medium mt-1">
                    {direction === "both"
                      ? "Generates 2 Notes: Front→Back and Back→Front."
                      : direction === "reversed"
                        ? "Generates 1 Note: Back→Front."
                        : "Generates 1 Note: Front→Back."}
                  </p>
                </div>
                <div className="flex bg-gray-100 p-1 rounded-xl w-full md:w-auto">
                  <DirectionButton
                    active={direction === "normal"}
                    label="Normal"
                    onClick={() => setDirection("normal")}
                  />
                  <DirectionButton
                    active={direction === "reversed"}
                    label="Reversed"
                    onClick={() => setDirection("reversed")}
                  />
                  <DirectionButton
                    active={direction === "both"}
                    label="Both Ways"
                    onClick={() => setDirection("both")}
                  />
                </div>
              </section>
            )}

            {/* Dynamic Content Panels based on Format */}
            <section
              className="space-y-6 animate-[fadeIn_0.3s_ease-out]"
              key={format}
            >
              {/* Grid Layouts for Normal and MCQ */}
              {(format === "normal" || format === "mcq") && (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {/* Front Panel (Shared) */}
                  <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm flex flex-col h-full min-h-[200px] md:min-h-[300px]">
                    <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-widest mb-4">
                      Front (Prompt)
                    </h4>
                    <textarea
                      className="flex-1 w-full text-2xl font-bold text-gray-900 bg-transparent border-none outline-none resize-none"
                      placeholder="Type a word or sentence..."
                    ></textarea>
                  </div>

                  {/* Back Panel (Only for Flashcard) */}
                  {format === "normal" && (
                    <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm flex flex-col h-full min-h-[200px] md:min-h-[300px]">
                      <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-widest mb-4">
                        Back (Answer)
                      </h4>
                      <textarea
                        className="flex-1 w-full text-2xl font-bold text-gray-900 bg-transparent border-none outline-none resize-none"
                        placeholder="Type the translation..."
                      ></textarea>
                    </div>
                  )}

                  {/* MCQ Panel */}
                  {format === "mcq" && (
                    <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm flex flex-col h-full min-h-[250px] md:min-h-[300px]">
                      <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-widest mb-4 border-b border-gray-200 pb-4">
                        Answer Options
                      </h4>
                      <div className="space-y-3 flex-1 overflow-y-auto">
                        <div className="flex items-center gap-3 p-2 rounded-xl bg-green-50 border-2 border-[#4CAF50]">
                          <input
                            type="radio"
                            name="mcq"
                            defaultChecked
                            className="w-4 h-4 md:w-6 md:h-6 ml-1 md:ml-2 accent-[#4CAF50]"
                          />
                          <input
                            type="text"
                            defaultValue="Option 1"
                            className="flex-1 bg-transparent border-none outline-none font-bold text-base md:text-lg px-2"
                          />
                        </div>
                        <div className="flex items-center gap-3 p-2 rounded-xl border-2 border-gray-200">
                          <input
                            type="radio"
                            name="mcq"
                            className="w-4 h-4 md:w-6 md:h-6 ml-1 md:ml-2 accent-[#4CAF50]"
                          />
                          <input
                            type="text"
                            placeholder="Option 2..."
                            className="flex-1 bg-transparent border-none outline-none font-bold text-base md:text-lg px-2"
                          />
                        </div>
                      </div>
                      <button className="w-full mt-4 py-3 rounded-xl border-2 border-dashed border-gray-300 text-gray-500 font-bold hover:border-indigo-500 hover:text-indigo-500 transition-colors">
                        <i className="fa-solid fa-plus mr-2"></i> Add Option
                      </button>
                    </div>
                  )}
                </div>
              )}

              {/* Full Width Panels for Blanks and Match Madness */}
              {format === "blanks" && (
                <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm">
                  <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-widest mb-4">
                    Sentence Builder
                  </h4>
                  <div className="relative bg-[#F8F9FA] rounded-xl p-4 border border-gray-200">
                    <div
                      className="text-xl md:text-2xl font-bold text-gray-900 mb-4 outline-none"
                      contentEditable
                      suppressContentEditableWarning
                    >
                      Highlight text here and click create blank.
                    </div>
                    <div className="flex justify-end border-t border-gray-200 pt-3">
                      <button className="active:translate-y-1 active:shadow-none transition-all bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-bold shadow-[0_3px_0_0_#D1D5DB] text-sm">
                        <i className="fa-solid fa-eraser mr-1"></i> Create Blank
                      </button>
                    </div>
                  </div>
                </div>
              )}

              {format === "match" && (
                <div className="bg-white rounded-3xl p-6 border-2 border-gray-200 shadow-sm">
                  <h4 className="text-xs font-extrabold text-gray-400 uppercase tracking-widest mb-4">
                    Matching Pairs
                  </h4>
                  <div className="space-y-3">
                    <div className="flex flex-col md:flex-row items-center gap-3">
                      <input
                        type="text"
                        placeholder="Term..."
                        className="w-full md:flex-1 bg-[#F8F9FA] border border-gray-200 rounded-xl p-3 font-bold text-base md:text-lg outline-none focus:border-indigo-500"
                      />
                      <div className="text-gray-300 rotate-90 md:rotate-0">
                        <i className="fa-solid fa-arrow-right-arrow-left"></i>
                      </div>
                      <input
                        type="text"
                        placeholder="Match..."
                        className="w-full md:flex-1 bg-[#F8F9FA] border border-gray-200 rounded-xl p-3 font-bold text-base md:text-lg outline-none focus:border-indigo-500"
                      />
                    </div>
                  </div>
                  <button className="w-full mt-6 py-3 rounded-xl border-2 border-dashed border-gray-300 text-gray-500 font-bold hover:border-indigo-500 hover:text-indigo-500 transition-colors">
                    <i className="fa-solid fa-plus mr-2"></i> Add Pair
                  </button>
                </div>
              )}
            </section>
          </div>
        </main>
      </div>
    </div>
  );
}

// --- HELPER UI COMPONENTS ---
function FormatButton({
  active,
  icon,
  label,
  onClick,
}: {
  active: boolean;
  icon: string;
  label: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`flex-none px-4 py-3 rounded-xl font-bold flex items-center gap-2 transition-colors border-2 ${active ? "border-indigo-500 bg-indigo-50 text-indigo-500" : "border-gray-200 bg-white text-gray-500 hover:border-gray-300"}`}
    >
      <i className={`fa-solid ${icon}`}></i> {label}
    </button>
  );
}

function DirectionButton({
  active,
  label,
  onClick,
}: {
  active: boolean;
  label: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`px-4 py-2 rounded-lg text-sm font-bold transition-all ${active ? "bg-white text-gray-900 shadow-sm border border-gray-200" : "text-gray-500 hover:text-gray-900 border border-transparent"}`}
    >
      {label}
    </button>
  );
}
