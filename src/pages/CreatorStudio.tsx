import { useState } from "react";
import { useNavigate } from "react-router-dom";

type FormatType = "normal" | "mcq" | "blanks" | "match";
type DirectionType = "normal" | "reverse" | "both";

export default function CreatorStudio() {
  const navigate = useNavigate();

  const [format, setFormat] = useState<FormatType>("normal");
  const [direction, setDirection] = useState<DirectionType>("normal");

  const getDirectionHint = () => {
    switch (direction) {
      case "both":
        return "Generates 2 Notes: Front→Back and Back→Front.";
      case "reverse":
        return "Generates 1 Note: Back→Front.";
      default:
        return "Generates 1 Note: Front→Back.";
    }
  };

  return (
    <div className="bg-background-page text-gray-900 font-sans h-screen w-full flex flex-col overflow-hidden antialiased selection:bg-primary selection:text-white">
      {/* Header - Aligned with the spatial navigation philosophy */}
      <header className="bg-background-surface border-b-2 border-border-neutral-subtle px-6 py-4 flex items-center justify-between z-20 shrink-0">
        <div className="flex items-center gap-6">
          <button
            onClick={() => navigate(-1)}
            className="w-12 h-12 rounded-2xl bg-white border-2 border-border-neutral-subtle text-gray-500 flex items-center justify-center btn-tactile shadow-tactile-secondary hover:border-gray-300"
          >
            <i className="fa-solid fa-arrow-left text-xl"></i>
          </button>
          <div className="flex flex-col">
            <div className="flex items-center gap-2 mb-1">
              <span className="bg-indigo-50 text-primary text-[10px] font-black px-2 py-0.5 rounded uppercase tracking-[0.1em] border-2 border-primary-light">
                Draft Deck
              </span>
              <span className="text-xs text-gray-400 font-bold">
                <i className="fa-solid fa-lock text-[10px] mr-1"></i> Private
              </span>
            </div>
            <input
              type="text"
              defaultValue="JLPT N5 Grammar"
              className="text-2xl font-black tracking-tight text-gray-900 bg-transparent border-none outline-none focus:ring-0 p-0 placeholder-gray-300 w-64"
              placeholder="Deck Title..."
            />
          </div>
        </div>

        <div className="flex items-center gap-4">
          <button className="text-gray-400 hover:text-gray-600 px-4 py-3 rounded-2xl font-bold text-sm transition-colors flex items-center gap-2">
            <i className="fa-solid fa-gear"></i> Settings
          </button>
          <button className="btn-tactile bg-primary text-white px-8 py-3 rounded-2xl font-bold text-lg shadow-tactile-primary-lg hover:bg-indigo-600">
            Save & Close
          </button>
        </div>
      </header>

      <div className="flex flex-1 overflow-hidden">
        {/* Sidebar - Chunked for low cognitive load */}
        <aside className="w-72 bg-background-surface border-r-2 border-border-neutral-subtle flex flex-col shrink-0">
          <div className="p-6 border-b-2 border-border-neutral-subtle flex justify-between items-center bg-gray-50">
            <h3 className="font-black text-gray-900 text-lg">Cards (3)</h3>
            <button className="w-10 h-10 rounded-2xl bg-white border-2 border-border-neutral-subtle text-gray-600 flex items-center justify-center btn-tactile shadow-tactile-secondary">
              <i className="fa-solid fa-plus"></i>
            </button>
          </div>
          <div className="flex-1 overflow-y-auto p-4 space-y-3">
            <div className="p-4 rounded-2xl bg-indigo-50 border-2 border-primary-light cursor-pointer flex gap-3 items-center btn-tactile shadow-tactile-ghost">
              <div className="text-primary text-xl">
                <i className="fa-regular fa-square-caret-right"></i>
              </div>
              <div className="flex-1 truncate text-sm font-bold text-primary">
                勉強 (benkyou)
              </div>
            </div>
            <div className="p-4 rounded-2xl bg-white border-2 border-transparent hover:border-border-neutral-subtle cursor-pointer flex gap-3 items-center text-gray-500 transition-colors">
              <div className="text-xl">
                <i className="fa-solid fa-list-ul"></i>
              </div>
              <div className="flex-1 truncate text-sm font-bold">
                Which particle is...
              </div>
            </div>
          </div>
        </aside>

        {/* Main Editor */}
        <main className="flex-1 overflow-y-auto bg-background-page p-8 md:p-12">
          <div className="max-w-4xl mx-auto space-y-12">
            {/* Format Selection */}
            <section>
              <h2 className="text-xs font-black uppercase tracking-[0.2em] text-gray-400 mb-6 border-b-2 border-border-neutral-subtle pb-2">
                01. Question Format
              </h2>
              <div className="flex gap-4 overflow-x-auto no-scrollbar pb-4">
                {[
                  {
                    id: "normal",
                    icon: "fa-regular fa-square-caret-right",
                    label: "Flashcard",
                  },
                  {
                    id: "mcq",
                    icon: "fa-solid fa-list-ul",
                    label: "Multiple Choice",
                  },
                  {
                    id: "blanks",
                    icon: "fa-solid fa-pen-ruler",
                    label: "Fill in Blanks",
                  },
                  {
                    id: "match",
                    icon: "fa-solid fa-shuffle",
                    label: "Match Madness",
                  },
                ].map((fmt) => (
                  <button
                    key={fmt.id}
                    onClick={() => setFormat(fmt.id as FormatType)}
                    className={`btn-tactile flex-none px-6 py-4 rounded-2xl border-2 font-bold flex items-center gap-3 text-lg ${
                      format === fmt.id
                        ? "bg-indigo-50 border-primary-light text-primary shadow-tactile-ghost"
                        : "bg-white border-border-neutral-subtle text-gray-500 shadow-tactile-secondary hover:border-gray-300"
                    }`}
                  >
                    <i className={fmt.icon}></i> {fmt.label}
                  </button>
                ))}
              </div>
            </section>

            {/* Study Direction */}
            {format === "normal" && (
              <section className="bg-white p-6 rounded-[40px] border-2 border-border-neutral-subtle flex items-center justify-between shadow-sm animate-fade-in">
                <div className="px-2">
                  <h3 className="font-bold text-gray-900 text-lg">
                    Study Direction
                  </h3>
                  <p className="text-sm text-gray-500 font-medium mt-1">
                    {getDirectionHint()}
                  </p>
                </div>
                <div className="flex bg-gray-100 p-2 rounded-3xl gap-2">
                  {[
                    { id: "normal", label: "Normal" },
                    { id: "reverse", label: "Reversed" },
                    { id: "both", label: "Both Ways" },
                  ].map((dir) => (
                    <button
                      key={dir.id}
                      onClick={() => setDirection(dir.id as DirectionType)}
                      className={`px-6 py-3 rounded-2xl text-sm font-bold transition-all ${
                        direction === dir.id
                          ? "bg-white text-gray-900 shadow-sm border-2 border-gray-200 btn-tactile"
                          : "text-gray-500 hover:text-gray-900 border-2 border-transparent"
                      }`}
                    >
                      {dir.label}
                    </button>
                  ))}
                </div>
              </section>
            )}

            {/* Editor Container */}
            <section className="space-y-8">
              {/* Grid Layouts for Flashcard and MCQ */}
              {(format === "normal" || format === "mcq") && (
                <div
                  className="grid grid-cols-1 md:grid-cols-2 gap-8 animate-fade-in"
                  key={`grid-${format}`}
                >
                  {/* Front Panel */}
                  <div className="bg-white rounded-[40px] p-8 border-2 border-border-neutral-subtle relative group focus-within:border-primary focus-within:shadow-tactile-ghost transition-all flex flex-col h-full min-h-[350px]">
                    <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-6">
                      Front (Prompt)
                    </h4>
                    <textarea
                      className="flex-1 w-full text-3xl font-extrabold text-gray-900 bg-transparent border-none outline-none resize-none placeholder-gray-300 leading-tight"
                      placeholder="Type a word..."
                    />
                    <div className="flex gap-3 border-t-2 border-border-neutral-subtle pt-6 mt-4">
                      <button className="w-12 h-12 rounded-2xl bg-gray-50 border-2 border-border-neutral-subtle text-gray-500 hover:text-primary flex items-center justify-center btn-tactile shadow-tactile-secondary">
                        <i className="fa-regular fa-image text-xl"></i>
                      </button>
                      <button className="w-12 h-12 rounded-2xl bg-gray-50 border-2 border-border-neutral-subtle text-gray-500 hover:text-primary flex items-center justify-center btn-tactile shadow-tactile-secondary">
                        <i className="fa-solid fa-microphone text-xl"></i>
                      </button>
                    </div>
                  </div>

                  {/* Back Panel (Normal) */}
                  {format === "normal" && (
                    <div className="bg-white rounded-[40px] p-8 border-2 border-border-neutral-subtle relative group focus-within:border-primary focus-within:shadow-tactile-ghost transition-all flex flex-col h-full min-h-[350px]">
                      <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-6">
                        Back (Answer)
                      </h4>
                      <textarea
                        className="flex-1 w-full text-3xl font-extrabold text-gray-900 bg-transparent border-none outline-none resize-none placeholder-gray-300 leading-tight"
                        placeholder="Type the translation..."
                      />
                      <div className="flex gap-3 border-t-2 border-border-neutral-subtle pt-6 mt-4">
                        <button className="w-12 h-12 rounded-2xl bg-gray-50 border-2 border-border-neutral-subtle text-gray-500 hover:text-primary flex items-center justify-center btn-tactile shadow-tactile-secondary">
                          <i className="fa-regular fa-image text-xl"></i>
                        </button>
                        <button className="w-12 h-12 rounded-2xl bg-gray-50 border-2 border-border-neutral-subtle text-gray-500 hover:text-primary flex items-center justify-center btn-tactile shadow-tactile-secondary">
                          <i className="fa-solid fa-microphone text-xl"></i>
                        </button>
                      </div>
                    </div>
                  )}

                  {/* MCQ Options Panel */}
                  {format === "mcq" && (
                    <div className="bg-white rounded-[40px] p-8 border-2 border-border-neutral-subtle flex flex-col h-full min-h-[350px]">
                      <div className="flex justify-between items-center mb-6 border-b-2 border-border-neutral-subtle pb-4">
                        <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest">
                          Answer Options
                        </h4>
                        <span className="text-[10px] font-bold text-primary bg-indigo-50 px-3 py-1 rounded-lg border border-primary-light">
                          Select correct
                        </span>
                      </div>

                      <div className="space-y-4 flex-1 overflow-y-auto pr-2 no-scrollbar">
                        {/* Correct Option */}
                        <div className="flex items-center gap-4 p-3 rounded-2xl bg-green-50 border-2 border-action-success btn-tactile shadow-tactile-success">
                          <input
                            type="radio"
                            name="mcq-correct"
                            defaultChecked
                            className="w-6 h-6 ml-2 accent-action-success cursor-pointer"
                          />
                          <input
                            type="text"
                            defaultValue="To study"
                            className="flex-1 bg-transparent border-none outline-none font-bold text-gray-900 text-xl px-2"
                          />
                          <button className="text-gray-400 hover:text-action-error px-3 text-lg">
                            <i className="fa-solid fa-trash"></i>
                          </button>
                        </div>
                        {/* Wrong Option */}
                        <div className="flex items-center gap-4 p-3 rounded-2xl bg-white border-2 border-border-neutral-subtle btn-tactile shadow-tactile-secondary">
                          <input
                            type="radio"
                            name="mcq-correct"
                            className="w-6 h-6 ml-2 accent-action-success cursor-pointer"
                          />
                          <input
                            type="text"
                            defaultValue="To eat"
                            className="flex-1 bg-transparent border-none outline-none font-bold text-gray-900 text-xl px-2"
                          />
                          <button className="text-gray-400 hover:text-action-error px-3 text-lg">
                            <i className="fa-solid fa-trash"></i>
                          </button>
                        </div>
                      </div>

                      <button className="btn-tactile w-full mt-6 py-4 rounded-2xl bg-gray-50 border-2 border-dashed border-gray-300 text-gray-500 font-bold text-lg hover:border-primary hover:text-primary hover:bg-indigo-50 transition-colors flex justify-center items-center gap-2">
                        <i className="fa-solid fa-plus"></i> Add Option
                      </button>
                    </div>
                  )}
                </div>
              )}

              {/* Full Width Layouts for Blanks and Match */}
              {(format === "blanks" || format === "match") && (
                <div className="animate-fade-in" key={`full-${format}`}>
                  {/* Blanks Panel */}
                  {format === "blanks" && (
                    <div className="bg-white rounded-[40px] p-10 border-2 border-border-neutral-subtle shadow-sm">
                      <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-4">
                        Sentence Builder
                      </h4>
                      <p className="text-lg text-gray-500 font-medium mb-8 max-w-2xl">
                        Type your full sentence below. Highlight the word(s) you
                        want the user to guess, and click "Create Blank".
                      </p>

                      <div className="relative bg-background-page rounded-3xl p-6 border-2 border-border-neutral-subtle focus-within:border-primary focus-within:shadow-tactile-ghost transition-all">
                        <div className="text-4xl font-extrabold text-gray-900 leading-relaxed mb-6">
                          私は毎日
                          <span className="bg-primary text-white px-3 py-1 rounded-xl mx-2 btn-tactile shadow-tactile-primary-sm cursor-pointer">
                            図書館
                          </span>
                          で勉強します。
                        </div>
                        <div className="flex justify-end border-t-2 border-border-neutral-subtle pt-4">
                          <button className="btn-tactile bg-white text-gray-700 border-2 border-border-neutral-subtle px-6 py-3 rounded-2xl font-bold shadow-tactile-secondary text-base hover:bg-gray-50">
                            <i className="fa-solid fa-eraser mr-2"></i> Create
                            Blank
                          </button>
                        </div>
                      </div>

                      <div className="mt-10">
                        <h5 className="text-sm font-black text-gray-700 uppercase tracking-widest mb-4">
                          Hidden Segments
                        </h5>
                        <div className="flex items-center gap-6 p-4 rounded-3xl bg-gray-50 border-2 border-border-neutral-subtle">
                          <div className="w-12 h-12 bg-white rounded-2xl flex items-center justify-center font-black text-xl text-primary border-2 border-primary-light shadow-tactile-ghost">
                            1
                          </div>
                          <div className="flex-1">
                            <div className="text-xs font-black text-gray-400 uppercase tracking-wider mb-1">
                              Correct Answer
                            </div>
                            <div className="font-extrabold text-2xl text-gray-900">
                              図書館 (Library)
                            </div>
                          </div>
                          <button className="w-12 h-12 flex items-center justify-center rounded-2xl text-gray-400 hover:text-action-error hover:bg-red-50 transition-colors text-xl">
                            <i className="fa-solid fa-trash"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  )}

                  {/* Match Panel */}
                  {format === "match" && (
                    <div className="bg-white rounded-[40px] p-10 border-2 border-border-neutral-subtle shadow-sm">
                      <h4 className="text-[10px] font-black text-gray-400 uppercase tracking-widest mb-6">
                        Matching Pairs
                      </h4>

                      <div className="grid grid-cols-2 gap-6 mb-4 px-4">
                        <div className="text-xs font-black text-gray-400 uppercase tracking-widest">
                          Term
                        </div>
                        <div className="text-xs font-black text-gray-400 uppercase tracking-widest">
                          Match
                        </div>
                      </div>

                      <div className="space-y-4">
                        <div className="flex items-center gap-4">
                          <div className="w-8 text-gray-400 text-center cursor-move hover:text-primary text-xl">
                            <i className="fa-solid fa-grip-vertical"></i>
                          </div>
                          <input
                            type="text"
                            defaultValue="犬"
                            className="flex-1 bg-background-page border-2 border-border-neutral-subtle rounded-2xl p-4 font-extrabold text-2xl outline-none focus:border-primary focus:bg-white transition-colors"
                          />
                          <div className="text-gray-300 text-xl px-2">
                            <i className="fa-solid fa-arrow-right-arrow-left"></i>
                          </div>
                          <input
                            type="text"
                            defaultValue="Dog"
                            className="flex-1 bg-background-page border-2 border-border-neutral-subtle rounded-2xl p-4 font-extrabold text-2xl outline-none focus:border-primary focus:bg-white transition-colors"
                          />
                          <button className="text-gray-400 hover:text-action-error px-4 text-xl">
                            <i className="fa-solid fa-trash"></i>
                          </button>
                        </div>
                        <div className="flex items-center gap-4">
                          <div className="w-8 text-gray-400 text-center cursor-move hover:text-primary text-xl">
                            <i className="fa-solid fa-grip-vertical"></i>
                          </div>
                          <input
                            type="text"
                            defaultValue="猫"
                            className="flex-1 bg-background-page border-2 border-border-neutral-subtle rounded-2xl p-4 font-extrabold text-2xl outline-none focus:border-primary focus:bg-white transition-colors"
                          />
                          <div className="text-gray-300 text-xl px-2">
                            <i className="fa-solid fa-arrow-right-arrow-left"></i>
                          </div>
                          <input
                            type="text"
                            defaultValue="Cat"
                            className="flex-1 bg-background-page border-2 border-border-neutral-subtle rounded-2xl p-4 font-extrabold text-2xl outline-none focus:border-primary focus:bg-white transition-colors"
                          />
                          <button className="text-gray-400 hover:text-action-error px-4 text-xl">
                            <i className="fa-solid fa-trash"></i>
                          </button>
                        </div>
                      </div>

                      <button className="btn-tactile w-full mt-8 py-5 rounded-3xl bg-gray-50 border-2 border-dashed border-gray-300 text-gray-500 font-bold text-lg hover:border-primary hover:text-primary hover:bg-indigo-50 transition-colors flex justify-center items-center gap-2">
                        <i className="fa-solid fa-plus"></i> Add Pair
                      </button>
                    </div>
                  )}
                </div>
              )}
            </section>
          </div>
        </main>
      </div>
    </div>
  );
}
