import React from "react";
import { useNavigate } from "react-router-dom";

// --- Design System Components ---
const Section = ({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) => (
  <section className="mb-12">
    <h2 className="text-xs font-black uppercase tracking-[0.2em] text-gray-400 mb-6 border-b border-gray-100 pb-2">
      {title}
    </h2>
    {children}
  </section>
);

const ColorBubble = ({
  color,
  hex,
  label,
}: {
  color: string;
  hex: string;
  label: string;
}) => (
  <div className="flex flex-col gap-2">
    <div
      className={`w-full h-24 rounded-3xl ${color} border-2 border-gray-200/50 shadow-sm flex items-end p-3`}
    >
      <span className="text-[10px] font-bold uppercase tracking-wider mix-blend-difference text-white opacity-50">
        {hex}
      </span>
    </div>
    <div className="px-1">
      <p className="font-bold text-sm text-gray-900">{label}</p>
      <p className="text-[10px] text-gray-400 font-medium uppercase tracking-tighter">
        {hex}
      </p>
    </div>
  </div>
);

// Changed: Removed onClose prop, using useNavigate instead
export default function DesignSystem() {
  const navigate = useNavigate();

  return (
    <div className="bg-[#F8F9FA] h-full overflow-y-auto p-8 md:p-16 max-w-7xl mx-auto font-sans antialiased relative">
      {/* Close Button routing back to the previous page */}
      <button
        onClick={() => navigate(-1)}
        className="fixed top-8 right-8 z-50 w-12 h-12 rounded-2xl bg-white border-2 border-gray-200 text-gray-500 hover:bg-gray-50 flex items-center justify-center shadow-sm transition-all active:translate-y-1 active:shadow-none"
      >
        <i className="fa-solid fa-xmark text-xl"></i>
      </button>

      {/* Header */}
      <header className="mb-20">
        <div className="flex items-center gap-4 mb-4">
          <div className="w-12 h-12 rounded-2xl bg-indigo-500 shadow-[0_4px_0_0_#3F498A] flex items-center justify-center text-white text-2xl">
            <i className="fa-solid fa-ghost"></i>
          </div>
          <h1 className="text-4xl font-black tracking-tight text-gray-900">
            BooMondai <span className="text-indigo-500">Design System</span>
          </h1>
        </div>
        <p className="text-xl text-gray-500 font-medium max-w-2xl leading-relaxed">
          A tactile, low-cognitive-load framework designed for neurodivergent
          learners. Focusing on{" "}
          <span className="text-indigo-500 font-bold">immediate feedback</span>,
          <span className="text-indigo-500 font-bold">spatial consistency</span>
          , and
          <span className="text-indigo-500 font-bold">sensory delight</span>.
        </p>
      </header>

      {/* 1. Philosophy */}
      <Section title="01. Experience Philosophy">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="bg-white p-8 rounded-[40px] border-2 border-gray-200 shadow-sm">
            <div className="w-12 h-12 rounded-full bg-indigo-50 text-indigo-500 flex items-center justify-center mb-6 text-xl">
              <i className="fa-solid fa-brain"></i>
            </div>
            <h3 className="text-xl font-bold mb-3">Reduced Cognitive Load</h3>
            <p className="text-gray-500 leading-relaxed text-sm font-medium">
              We use "Chunking" to prevent overwhelm. Every screen has ONE
              primary action. Minimalistic sidebars and clear headers provide
              constant spatial orientation.
            </p>
          </div>
          <div className="bg-white p-8 rounded-[40px] border-2 border-gray-200 shadow-sm">
            <div className="w-12 h-12 rounded-full bg-orange-50 text-orange-500 flex items-center justify-center mb-6 text-xl">
              <i className="fa-solid fa-fingerprint"></i>
            </div>
            <h3 className="text-xl font-bold mb-3">Tactile Feedback</h3>
            <p className="text-gray-500 leading-relaxed text-sm font-medium">
              Buttons have physical depth (3D shadows). When pressed, they move
              4px down, mimicking real-world haptics. This provides a satisfying
              sensory loop for ADHD/Autistic users.
            </p>
          </div>
          <div className="bg-white p-8 rounded-[40px] border-2 border-gray-200 shadow-sm">
            <div className="w-12 h-12 rounded-full bg-green-50 text-green-500 flex items-center justify-center mb-6 text-xl">
              <i className="fa-solid fa-clock-rotate-left"></i>
            </div>
            <h3 className="text-xl font-bold mb-3">Memory Retrieval</h3>
            <p className="text-gray-500 leading-relaxed text-sm font-medium">
              Color-coded FSRS ratings (Again/Easy) help map abstract memory
              states to concrete visual cues, accelerating the spaced repetition
              learning process.
            </p>
          </div>
        </div>
      </Section>

      {/* 2. Colors */}
      <Section title="02. Color Palette">
        <div className="grid grid-cols-2 md:grid-cols-5 gap-6">
          <ColorBubble
            color="bg-indigo-500"
            hex="#6366F1"
            label="Primary (Ghost)"
          />
          <ColorBubble
            color="bg-orange-500"
            hex="#F97316"
            label="Streak (Fire)"
          />
          <ColorBubble
            color="bg-[#F8F9FA]"
            hex="#F8F9FA"
            label="Soft Background"
          />
          <ColorBubble
            color="bg-green-500"
            hex="#22C55E"
            label="Mastery/Success"
          />
          <ColorBubble color="bg-red-500" hex="#EF4444" label="Review/Error" />
        </div>
      </Section>

      {/* 3. Typography */}
      <Section title="03. Typography">
        <div className="space-y-8 bg-white p-10 rounded-[40px] border-2 border-gray-200">
          <div>
            <p className="text-[10px] font-black text-gray-400 uppercase mb-2">
              Display 01 / Black
            </p>
            <h1 className="text-6xl font-black tracking-tighter text-gray-900">
              Learning Made Tactile
            </h1>
          </div>
          <div>
            <p className="text-[10px] font-black text-gray-400 uppercase mb-2">
              Header 02 / ExtraBold
            </p>
            <h2 className="text-3xl font-extrabold text-gray-900">
              Ready for your review?
            </h2>
          </div>
          <div>
            <p className="text-[10px] font-black text-gray-400 uppercase mb-2">
              Body / Medium
            </p>
            <p className="text-xl text-gray-500 font-medium leading-relaxed">
              The quick brown ghost jumps over the lazy flashcard. We prioritize
              readability with high line-height and generous letter spacing.
            </p>
          </div>
        </div>
      </Section>

      {/* 4. Interactive Components */}
      <Section title="04. The Button Lab">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
          <div className="space-y-6">
            <h3 className="font-bold text-gray-400 text-xs uppercase tracking-widest">
              Action Variants
            </h3>
            <div className="flex flex-wrap gap-4">
              <button className="active:translate-y-1 active:shadow-none transition-all bg-indigo-500 text-white px-8 py-4 rounded-2xl font-bold text-lg shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600">
                Primary Action
              </button>
              <button className="active:translate-y-1 active:shadow-none transition-all bg-white border-2 border-gray-200 text-gray-700 px-8 py-4 rounded-2xl font-bold text-lg shadow-[0_6px_0_0_#E5E7EB] hover:border-gray-300">
                Secondary
              </button>
            </div>
            <div className="flex flex-wrap gap-4">
              <button className="active:translate-y-1 active:shadow-none transition-all bg-indigo-50 text-indigo-500 border-2 border-indigo-200 px-6 py-3 rounded-xl font-bold shadow-[0_4px_0_0_#C7D2FE]">
                Ghost Variant
              </button>
              <button className="text-indigo-500 font-bold hover:underline px-4">
                Text Link
              </button>
            </div>
          </div>

          <div className="space-y-6">
            <h3 className="font-bold text-gray-400 text-xs uppercase tracking-widest">
              Memory Rating (Tactile)
            </h3>
            <div className="grid grid-cols-2 gap-4">
              <button className="active:translate-y-1 active:shadow-none transition-all bg-red-50 text-red-600 border-2 border-red-200 rounded-2xl p-4 flex flex-col items-center shadow-[0_4px_0_0_#FECACA]">
                <span className="font-black text-lg uppercase">Again</span>
                <span className="text-[10px] font-bold opacity-60">1M</span>
              </button>
              <button className="active:translate-y-1 active:shadow-none transition-all bg-green-50 text-green-600 border-2 border-green-200 rounded-2xl p-4 flex flex-col items-center shadow-[0_4px_0_0_#BBF7D0]">
                <span className="font-black text-lg uppercase">Good</span>
                <span className="text-[10px] font-bold opacity-60">10M</span>
              </button>
            </div>
          </div>
        </div>
      </Section>

      {/* 5. Progress Pathways */}
      <Section title="05. Progress Pathways (Replacing Progress Bars)">
        <div className="bg-white p-10 rounded-[40px] border-2 border-gray-200 shadow-sm flex flex-col items-center justify-center space-y-8">
          <p className="text-gray-500 font-medium text-center max-w-2xl">
            Abstract percentage bars are difficult for neurodivergent brains to
            contextualize. By transforming progress into a physical "Pathway,"
            learning becomes a tangible journey.
          </p>
          <div className="relative w-full max-w-3xl flex justify-between items-center py-8">
            <div className="absolute top-1/2 left-0 w-full h-3 bg-gray-100 -translate-y-1/2 rounded-full z-0"></div>
            <div className="absolute top-1/2 left-0 w-1/2 h-3 bg-indigo-500 -translate-y-1/2 rounded-full z-0 transition-all duration-1000"></div>
            <div className="w-14 h-14 rounded-full bg-indigo-500 text-white z-10 flex items-center justify-center shadow-[0_4px_0_0_#3F498A] font-bold border-4 border-white">
              <i className="fa-solid fa-check"></i>
            </div>
            <div className="w-14 h-14 rounded-full bg-indigo-500 text-white z-10 flex items-center justify-center shadow-[0_4px_0_0_#3F498A] font-bold border-4 border-white">
              <i className="fa-solid fa-check"></i>
            </div>
            <div className="relative z-10">
              <div className="absolute -top-10 left-1/2 -translate-x-1/2 bg-gray-900 text-white text-[10px] font-bold px-3 py-1 rounded-full animate-pulse whitespace-nowrap">
                You are here
              </div>
              <div className="w-20 h-20 rounded-full bg-orange-500 text-white flex items-center justify-center shadow-[0_6px_0_0_#C2410C] font-bold border-4 border-white text-2xl">
                <i className="fa-solid fa-fire"></i>
              </div>
            </div>
            <div className="w-14 h-14 rounded-full bg-gray-200 text-gray-400 z-10 flex items-center justify-center shadow-sm font-bold border-4 border-white">
              <i className="fa-solid fa-lock text-sm"></i>
            </div>
            <div className="w-14 h-14 rounded-full bg-gray-200 text-gray-400 z-10 flex items-center justify-center shadow-sm font-bold border-4 border-white">
              <i className="fa-solid fa-lock text-sm"></i>
            </div>
          </div>
        </div>
      </Section>

      {/* 6. Hero Transitions */}
      <Section title="06. Spatial Navigation (Hero Transitions)">
        <div className="bg-white p-10 rounded-[40px] border-2 border-gray-200 shadow-sm flex flex-col items-center justify-center space-y-10">
          <p className="text-gray-500 font-medium text-center max-w-2xl">
            Sudden screen cuts cause cognitive fatigue. "Hero" animations anchor
            the user's spatial awareness by physically morphing the clicked
            element into the next screen's header.
          </p>
          <div className="flex flex-col md:flex-row items-center gap-8 w-full max-w-4xl justify-center">
            <div className="bg-gray-50 p-6 rounded-3xl border-2 border-gray-200 w-full md:w-1/3">
              <div className="text-xs font-black text-gray-400 uppercase tracking-widest mb-4">
                State 1: Deck List
              </div>
              <div className="w-full h-32 bg-indigo-100 rounded-2xl mb-4 border-2 border-indigo-500 border-dashed flex flex-col items-center justify-center p-4">
                <span className="font-bold text-indigo-500">JLPT N5 Core</span>
                <span className="text-xs text-indigo-400 mt-1">
                  Tap to open
                </span>
              </div>
              <div className="h-4 bg-gray-200 rounded-full w-3/4 mb-2"></div>
              <div className="h-4 bg-gray-200 rounded-full w-1/2"></div>
            </div>
            <div className="flex flex-col items-center text-indigo-300">
              <i className="fa-solid fa-arrow-right-long text-4xl hidden md:block"></i>
              <i className="fa-solid fa-arrow-down-long text-4xl md:hidden"></i>
              <span className="text-[10px] font-bold uppercase mt-2">
                Morphs into
              </span>
            </div>
            <div className="bg-white p-6 rounded-3xl border-2 border-indigo-500 shadow-[0_8px_30px_rgba(99,102,241,0.15)] w-full md:w-1/2">
              <div className="text-xs font-black text-gray-400 uppercase tracking-widest mb-4">
                State 2: Study Session
              </div>
              <div className="w-full h-40 bg-indigo-500 rounded-2xl mb-6 flex flex-col items-center justify-center text-white shadow-inner">
                <span className="font-black text-xl">JLPT N5 Core</span>
                <span className="text-sm font-medium opacity-80 mt-1">
                  Study Session Active
                </span>
              </div>
              <div className="h-24 bg-gray-50 rounded-2xl border-2 border-gray-100 w-full flex items-center justify-center text-gray-400 font-bold text-sm">
                Flashcard Content
              </div>
            </div>
          </div>
        </div>
      </Section>

      {/* 7. Additional Suggestions */}
      <Section title="07. Accessibility & Flutter Roadmap">
        <div className="bg-indigo-900 text-indigo-100 p-10 rounded-[40px] space-y-6 shadow-xl">
          <h3 className="text-2xl font-black text-white">
            Device Level Integrations
          </h3>
          <ul className="space-y-4 font-medium list-disc list-inside opacity-90">
            <li>
              <span className="text-white font-bold">Haptic Engine:</span> Every
              "3D button" should trigger a different vibration pattern natively
              in Flutter (Heavy rumble for "Again", Light tap for "Easy").
            </li>
            <li>
              <span className="text-white font-bold">Sensory Safety:</span> Add
              a "Soft Mode" toggle that reduces contrast, mutes harsh colors,
              and disables all motion animations for users experiencing
              overstimulation.
            </li>
            <li>
              <span className="text-white font-bold">Dyslexia Support:</span>{" "}
              Include a toggle to switch the global font to OpenDyslexic or
              another bottom-heavy typeface.
            </li>
          </ul>
        </div>
      </Section>
    </div>
  );
}
