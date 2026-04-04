import React, { useState, useEffect } from "react";

// --- Types ---
type QuestionFormat = "normal" | "mcq" | "blanks" | "match";

interface BaseCard {
  id: string;
  type: QuestionFormat;
}

interface Flashcard extends BaseCard {
  type: "normal";
  front: string;
  back: string;
}

interface MCQCard extends BaseCard {
  type: "mcq";
  prompt: string;
  options: string[];
  correctOption: string;
}

interface BlanksCard extends BaseCard {
  type: "blanks";
  prefix: string;
  blankAnswer: string;
  suffix: string;
}

interface MatchCard extends BaseCard {
  type: "match";
  pairs: { term: string; match: string }[];
}

type QuizCard = Flashcard | MCQCard | BlanksCard | MatchCard;

// --- MOCK DATA QUEUE ---
const mockQueue: QuizCard[] = [
  { id: "1", type: "normal", front: "勉強", back: "benkyou (study)" },
  {
    id: "2",
    type: "mcq",
    prompt: "Which particle indicates the topic of a sentence?",
    options: ["を (o)", "は (wa)", "が (ga)", "で (de)"],
    correctOption: "は (wa)",
  },
  {
    id: "3",
    type: "blanks",
    prefix: "私は毎日",
    blankAnswer: "図書館",
    suffix: "で勉強します。 (I study at the library every day.)",
  },
  {
    id: "4",
    type: "match",
    pairs: [
      { term: "犬", match: "Dog" },
      { term: "猫", match: "Cat" },
      { term: "鳥", match: "Bird" },
    ],
  },
];

export default function StudySession({ onClose }: { onClose: () => void }) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isRevealed, setIsRevealed] = useState(false);

  // State for specific question types
  const [selectedOption, setSelectedOption] = useState<string | null>(null);
  const [blankInput, setBlankInput] = useState("");

  // State for Match Madness
  const [selectedMatchA, setSelectedMatchA] = useState<string | null>(null);
  const [matchedPairs, setMatchedPairs] = useState<string[]>([]);

  const currentCard = mockQueue[currentIndex];
  const progress = (currentIndex / mockQueue.length) * 100;

  // Reset states when moving to a new card
  useEffect(() => {
    setIsRevealed(false);
    setSelectedOption(null);
    setBlankInput("");
    setSelectedMatchA(null);
    setMatchedPairs([]);
  }, [currentIndex]);

  // Handle advancing to the next card via rating buttons
  const handleRate = (rating: string) => {
    console.log(`Card ${currentCard.id} rated: ${rating}`);
    if (currentIndex < mockQueue.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      alert("Session Complete! You're all caught up.");
      onClose();
    }
  };

  const handleCheckAnswer = () => {
    setIsRevealed(true);
  };

  // --- RENDERERS FOR DIFFERENT CARD TYPES ---

  const renderFlashcard = (card: Flashcard) => (
    <div
      className="w-full aspect-[4/3] md:aspect-video max-h-[400px] cursor-pointer"
      style={{ perspective: "1000px" }}
      onClick={() => setIsRevealed(true)}
    >
      <div
        className="relative w-full h-full transition-transform duration-500"
        style={{
          transformStyle: "preserve-3d",
          transform: isRevealed ? "rotateY(180deg)" : "rotateY(0deg)",
        }}
      >
        <div
          className="absolute inset-0 bg-white border-2 border-gray-200 rounded-3xl flex flex-col items-center justify-center p-8"
          style={{ backfaceVisibility: "hidden" }}
        >
          <h2 className="text-6xl md:text-8xl font-extrabold text-gray-900 tracking-tight">
            {card.front}
          </h2>
          <p className="text-gray-400 font-medium mt-auto absolute bottom-8 animate-pulse">
            <i className="fa-solid fa-hand-pointer mr-2"></i> Tap to reveal
          </p>
        </div>
        <div
          className="absolute inset-0 bg-white border-2 border-indigo-500 rounded-3xl flex flex-col items-center justify-center p-8"
          style={{ backfaceVisibility: "hidden", transform: "rotateY(180deg)" }}
        >
          <h2 className="text-4xl md:text-5xl font-extrabold text-gray-900 mb-4">
            {card.front}
          </h2>
          <div className="w-16 h-1 bg-gray-200 rounded-full mb-4"></div>
          <h3 className="text-3xl font-bold text-indigo-500">{card.back}</h3>
        </div>
      </div>
    </div>
  );

  const renderMCQ = (card: MCQCard) => (
    <div className="w-full max-w-2xl mx-auto flex flex-col animate-[fadeIn_0.3s_ease-out]">
      <h2 className="text-2xl md:text-3xl font-extrabold text-gray-900 mb-8 text-center">
        {card.prompt}
      </h2>
      <div className="space-y-3">
        {card.options.map((option) => {
          const isSelected = selectedOption === option;
          const isCorrect = option === card.correctOption;

          let btnClass =
            "border-gray-200 hover:border-indigo-500 hover:bg-indigo-50 text-gray-700";

          // State logic after revealing
          if (isRevealed) {
            if (isCorrect)
              btnClass =
                "border-green-500 bg-green-50 text-green-700 shadow-[0_4px_0_0_#4CAF50]";
            else if (isSelected && !isCorrect)
              btnClass = "border-red-500 bg-red-50 text-red-700 opacity-50";
            else btnClass = "border-gray-200 opacity-50";
          } else if (isSelected) {
            btnClass =
              "border-indigo-500 bg-indigo-50 text-indigo-700 shadow-[0_4px_0_0_#5C6BC0]";
          }

          return (
            <button
              key={option}
              disabled={isRevealed}
              onClick={() => setSelectedOption(option)}
              className={`w-full p-4 rounded-2xl border-2 font-bold text-lg text-left transition-all ${btnClass}`}
            >
              {option}
            </button>
          );
        })}
      </div>
    </div>
  );

  const renderBlanks = (card: BlanksCard) => {
    const isCorrect =
      blankInput.trim().toLowerCase() === card.blankAnswer.toLowerCase();
    const inputClass = isRevealed
      ? isCorrect
        ? "bg-green-50 text-green-700 border-green-500"
        : "bg-red-50 text-red-700 border-red-500 line-through"
      : "bg-white border-gray-300 focus:border-indigo-500 text-indigo-500";

    return (
      <div className="w-full max-w-3xl mx-auto text-center animate-[fadeIn_0.3s_ease-out]">
        <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest mb-8">
          Fill in the blank
        </h2>
        <div className="text-3xl md:text-4xl font-extrabold text-gray-900 leading-relaxed flex flex-wrap items-center justify-center gap-2">
          <span>{card.prefix}</span>
          <div className="relative inline-block">
            <input
              type="text"
              disabled={isRevealed}
              value={blankInput}
              onChange={(e) => setBlankInput(e.target.value)}
              className={`w-40 text-center font-bold px-4 py-2 rounded-xl border-b-4 outline-none transition-colors ${inputClass}`}
            />
            {/* Show correct answer floating above if they got it wrong */}
            {isRevealed && !isCorrect && (
              <span className="absolute -top-8 left-1/2 -translate-x-1/2 text-sm font-bold text-green-500 bg-green-50 px-2 py-1 rounded-md">
                {card.blankAnswer}
              </span>
            )}
          </div>
          <span>{card.suffix}</span>
        </div>
      </div>
    );
  };

  const renderMatch = (card: MatchCard) => {
    // In a real app, these arrays would be shuffled
    const terms = card.pairs.map((p) => p.term);
    const matches = card.pairs.map((p) => p.match);

    const handleMatchClick = (item: string, isTerm: boolean) => {
      if (isRevealed) return;
      if (!selectedMatchA) {
        setSelectedMatchA(item);
      } else {
        // Logic check: find if selectedMatchA and item are a valid pair
        const isPair = card.pairs.some(
          (p) =>
            (p.term === selectedMatchA && p.match === item) ||
            (p.match === selectedMatchA && p.term === item),
        );

        if (isPair) {
          const newMatched = [...matchedPairs, selectedMatchA, item];
          setMatchedPairs(newMatched);
          if (newMatched.length === card.pairs.length * 2) {
            setIsRevealed(true); // Auto-reveal when all matched
          }
        }
        setSelectedMatchA(null);
      }
    };

    return (
      <div className="w-full max-w-2xl mx-auto animate-[fadeIn_0.3s_ease-out]">
        <h2 className="text-sm font-extrabold text-gray-400 uppercase tracking-widest mb-8 text-center">
          Match the pairs
        </h2>
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-3">
            {terms.map((term) => (
              <button
                key={term}
                disabled={matchedPairs.includes(term) || isRevealed}
                onClick={() => handleMatchClick(term, true)}
                className={`w-full p-4 rounded-2xl border-2 font-bold text-lg transition-all ${
                  matchedPairs.includes(term)
                    ? "opacity-0"
                    : selectedMatchA === term
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 shadow-[0_4px_0_0_#5C6BC0]"
                      : "border-gray-200 hover:border-gray-300"
                }`}
              >
                {term}
              </button>
            ))}
          </div>
          <div className="space-y-3">
            {matches.map((match) => (
              <button
                key={match}
                disabled={matchedPairs.includes(match) || isRevealed}
                onClick={() => handleMatchClick(match, false)}
                className={`w-full p-4 rounded-2xl border-2 font-bold text-lg transition-all ${
                  matchedPairs.includes(match)
                    ? "opacity-0"
                    : selectedMatchA === match
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 shadow-[0_4px_0_0_#5C6BC0]"
                      : "border-gray-200 hover:border-gray-300"
                }`}
              >
                {match}
              </button>
            ))}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="absolute inset-0 z-50 bg-[#F8F9FA] flex flex-col w-full h-full">
      {/* Top Progress Bar */}
      <div className="px-6 py-4 flex items-center gap-4 border-b border-gray-200/50">
        <button
          onClick={onClose}
          className="text-gray-400 hover:text-gray-700 transition-colors"
        >
          <i className="fa-solid fa-xmark text-2xl"></i>
        </button>
        <div className="flex-1 h-3 bg-gray-200 rounded-full overflow-hidden">
          <div
            className="h-full bg-indigo-500 rounded-full transition-all duration-500 relative"
            style={{ width: `${progress}%` }}
          >
            <div className="absolute top-0.5 left-2 right-2 h-0.5 bg-white/30 rounded-full"></div>
          </div>
        </div>
        <div className="text-xs font-bold text-gray-400 uppercase tracking-widest">
          {currentIndex + 1} / {mockQueue.length}
        </div>
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col justify-center px-6 pb-32">
        {currentCard.type === "normal" &&
          renderFlashcard(currentCard as Flashcard)}
        {currentCard.type === "mcq" && renderMCQ(currentCard as MCQCard)}
        {currentCard.type === "blanks" &&
          renderBlanks(currentCard as BlanksCard)}
        {currentCard.type === "match" && renderMatch(currentCard as MatchCard)}
      </div>

      {/* Bottom Action Area (Sticky) */}
      <div className="absolute bottom-0 left-0 right-0 p-6 bg-white border-t border-gray-200 rounded-t-3xl shadow-[0_-10px_40px_rgba(0,0,0,0.05)]">
        {/* State 1: Need to check answer (Hidden for Flashcards/Match Madness which auto-reveal) */}
        {!isRevealed &&
          currentCard.type !== "normal" &&
          currentCard.type !== "match" && (
            <button
              onClick={handleCheckAnswer}
              disabled={
                (currentCard.type === "mcq" && !selectedOption) ||
                (currentCard.type === "blanks" && !blankInput)
              }
              className="w-full max-w-2xl mx-auto block active:translate-y-1 active:shadow-none disabled:opacity-50 disabled:active:translate-y-0 disabled:cursor-not-allowed bg-indigo-500 text-white px-8 py-4 rounded-2xl font-bold text-lg shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600 transition-all"
            >
              Check Answer
            </button>
          )}

        {/* State 2: FSRS Ratings (Revealed) */}
        {isRevealed && (
          <div className="animate-[fadeIn_0.3s_ease-out]">
            <h4 className="text-center text-xs font-bold text-gray-400 mb-4 uppercase tracking-widest">
              How well did you know this?
            </h4>
            <div className="grid grid-cols-4 gap-2 md:gap-4 max-w-2xl mx-auto">
              <RatingButton
                color="red"
                label="Again"
                time="1m"
                shadow="#ffcdd2"
                onClick={() => handleRate("again")}
              />
              <RatingButton
                color="orange"
                label="Hard"
                time="6m"
                shadow="#ffe0b2"
                onClick={() => handleRate("hard")}
              />
              <RatingButton
                color="green"
                label="Good"
                time="10m"
                shadow="#c8e6c9"
                onClick={() => handleRate("good")}
              />
              <RatingButton
                color="blue"
                label="Easy"
                time="4d"
                shadow="#bbdefb"
                onClick={() => handleRate("easy")}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

// --- HELPER COMPONENT ---
function RatingButton({
  color,
  label,
  time,
  shadow,
  onClick,
}: {
  color: string;
  label: string;
  time: string;
  shadow: string;
  onClick: () => void;
}) {
  const bgClasses: Record<string, string> = {
    red: "bg-red-50 text-[#F44336] border-red-200 hover:bg-red-100",
    orange: "bg-orange-50 text-[#FF9800] border-orange-200 hover:bg-orange-100",
    green: "bg-green-50 text-[#4CAF50] border-green-200 hover:bg-green-100",
    blue: "bg-blue-50 text-[#2196F3] border-blue-200 hover:bg-blue-100",
  };

  return (
    <button
      onClick={onClick}
      className={`active:translate-y-1 active:shadow-none transition-all border-2 rounded-2xl p-3 flex flex-col items-center justify-center cursor-pointer ${bgClasses[color]}`}
      style={{ boxShadow: `0 4px 0 0 ${shadow}` }}
    >
      <span className="font-extrabold text-sm md:text-base">{label}</span>
      <span className="text-xs font-medium opacity-70 mt-1">{time}</span>
    </button>
  );
}
