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

  const renderMCQ = (card: MCQCard) => (
    <div className="flex flex-col h-full animate-[fadeIn_0.3s_ease-out]">
      <h2 className="text-2xl font-extrabold text-gray-900 mb-6 text-center leading-tight">
        {card.prompt}
      </h2>
      <div className="space-y-3 flex-1 overflow-y-auto pr-1 custom-scrollbar">
        {card.options.map((option) => {
          const isSelected = selectedOption === option;
          const isCorrect = option === card.correctOption;

          let btnClass =
            "border-gray-200 hover:border-indigo-500 hover:bg-indigo-50 text-gray-700 shadow-[0_4px_0_0_#E5E7EB]";

          if (isRevealed) {
            if (isCorrect)
              btnClass =
                "border-green-500 bg-green-50 text-green-700 shadow-[0_4px_0_0_#4CAF50]";
            else if (isSelected && !isCorrect)
              btnClass =
                "border-red-500 bg-red-50 text-red-700 opacity-60 shadow-[0_4px_0_0_#EF4444]";
            else
              btnClass =
                "border-gray-200 opacity-50 shadow-[0_4px_0_0_#E5E7EB]";
          } else if (isSelected) {
            btnClass =
              "border-indigo-500 bg-indigo-50 text-indigo-700 shadow-[0_4px_0_0_#5C6BC0]";
          }

          return (
            <button
              key={option}
              disabled={isRevealed}
              onClick={() => setSelectedOption(option)}
              className={`w-full p-4 rounded-2xl border-2 font-bold text-base md:text-lg text-left transition-all active:translate-y-1 active:shadow-none ${
                isSelected && !isRevealed ? "translate-y-1 shadow-none" : ""
              } ${btnClass}`}
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
        : "bg-red-50 text-red-700 border-red-500 line-through opacity-70"
      : "bg-gray-50 border-gray-300 focus:border-indigo-500 text-indigo-500 shadow-inner";

    return (
      <div className="flex flex-col items-center justify-center h-full text-center animate-[fadeIn_0.3s_ease-out]">
        <div className="text-2xl md:text-3xl font-extrabold text-gray-900 leading-relaxed flex flex-wrap items-center justify-center gap-3">
          <span>{card.prefix}</span>
          <div className="relative inline-block mt-2 mb-2">
            <input
              type="text"
              disabled={isRevealed}
              value={blankInput}
              onChange={(e) => setBlankInput(e.target.value)}
              className={`w-32 md:w-40 text-center font-bold px-4 py-3 rounded-2xl border-b-4 outline-none transition-colors ${inputClass}`}
            />
            {isRevealed && !isCorrect && (
              <span className="absolute -top-10 left-1/2 -translate-x-1/2 text-sm font-black text-green-600 bg-green-100 px-3 py-1 rounded-lg shadow-sm whitespace-nowrap">
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
    const terms = card.pairs.map((p) => p.term);
    const matches = card.pairs.map((p) => p.match);

    const handleMatchClick = (item: string) => {
      if (isRevealed) return;
      if (!selectedMatchA) {
        setSelectedMatchA(item);
      } else {
        const isPair = card.pairs.some(
          (p) =>
            (p.term === selectedMatchA && p.match === item) ||
            (p.match === selectedMatchA && p.term === item),
        );

        if (isPair) {
          const newMatched = [...matchedPairs, selectedMatchA, item];
          setMatchedPairs(newMatched);
          if (newMatched.length === card.pairs.length * 2) {
            setIsRevealed(true);
          }
        }
        setSelectedMatchA(null);
      }
    };

    return (
      <div className="flex flex-col h-full animate-[fadeIn_0.3s_ease-out]">
        <div className="grid grid-cols-2 gap-4 flex-1">
          <div className="space-y-3 flex flex-col justify-center">
            {terms.map((term) => (
              <button
                key={term}
                disabled={matchedPairs.includes(term) || isRevealed}
                onClick={() => handleMatchClick(term)}
                className={`w-full p-4 rounded-2xl border-2 font-bold text-base md:text-lg transition-all shadow-[0_4px_0_0_#E5E7EB] active:translate-y-1 active:shadow-none ${
                  matchedPairs.includes(term)
                    ? "opacity-0 pointer-events-none"
                    : selectedMatchA === term
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 translate-y-1 !shadow-none"
                      : "border-gray-200 hover:border-gray-300 text-gray-700 bg-white"
                }`}
              >
                {term}
              </button>
            ))}
          </div>
          <div className="space-y-3 flex flex-col justify-center">
            {matches.map((match) => (
              <button
                key={match}
                disabled={matchedPairs.includes(match) || isRevealed}
                onClick={() => handleMatchClick(match)}
                className={`w-full p-4 rounded-2xl border-2 font-bold text-base md:text-lg transition-all shadow-[0_4px_0_0_#E5E7EB] active:translate-y-1 active:shadow-none ${
                  matchedPairs.includes(match)
                    ? "opacity-0 pointer-events-none"
                    : selectedMatchA === match
                      ? "border-indigo-500 bg-indigo-50 text-indigo-500 translate-y-1 !shadow-none"
                      : "border-gray-200 hover:border-gray-300 text-gray-700 bg-white"
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

  const getCardHeaderLabel = (type: QuestionFormat) => {
    switch (type) {
      case "normal":
        return "Flashcard";
      case "mcq":
        return "Multiple Choice";
      case "blanks":
        return "Fill in the blanks";
      case "match":
        return "Match the pairs";
    }
  };

  return (
    <div className="absolute inset-0 z-50 bg-[#F8F9FA] flex flex-col w-full h-full font-sans overflow-hidden">
      {/* Tactile Top Progress Bar */}
      <div className="w-full max-w-lg mx-auto px-6 py-6 flex items-center gap-4">
        <button
          onClick={onClose}
          className="w-10 h-10 rounded-xl bg-white border-2 border-gray-200 text-gray-400 hover:text-gray-700 flex items-center justify-center shadow-sm active:translate-y-1 active:shadow-none transition-all"
        >
          <i className="fa-solid fa-xmark text-lg"></i>
        </button>
        <div className="flex-1 h-4 bg-gray-200 rounded-full overflow-hidden shadow-inner relative">
          <div
            className="h-full bg-indigo-500 rounded-full transition-all duration-500 relative"
            style={{ width: `${progress}%` }}
          >
            {/* Highlight line for physical depth */}
            <div className="absolute top-1 left-2 right-2 h-1 bg-white/30 rounded-full"></div>
          </div>
        </div>
      </div>

      {/* Main Content Area - Centered Tactile Card */}
      <div
        className="flex-1 w-full flex flex-col items-center justify-center px-4 pb-12 overflow-hidden"
        style={{ perspective: "1500px" }}
      >
        {/* The Physical Card Wrapper */}
        <div
          className="relative w-full max-w-[380px] md:max-w-[420px] aspect-[3/4] max-h-[70vh] transition-transform duration-700"
          style={{
            transformStyle: "preserve-3d",
            transform:
              isRevealed && currentCard.type === "normal"
                ? "rotateY(180deg)"
                : "rotateY(0deg)",
          }}
        >
          {/* FRONT OF CARD */}
          <div
            className="absolute inset-0 bg-white border-2 border-gray-200 rounded-[40px] shadow-[0_12px_0_0_#E5E7EB] flex flex-col p-6 md:p-8"
            style={{ backfaceVisibility: "hidden" }}
          >
            {/* Card Header Label */}
            <div className="flex justify-center mb-6">
              <span className="text-[10px] md:text-xs font-black text-gray-400 uppercase tracking-[0.2em]">
                {getCardHeaderLabel(currentCard.type)}
              </span>
            </div>

            {/* Content Injection */}
            <div className="flex-1 flex flex-col overflow-hidden">
              {currentCard.type === "normal" && (
                <div
                  className="flex-1 flex flex-col items-center justify-center cursor-pointer"
                  onClick={() => setIsRevealed(true)}
                >
                  <h2 className="text-5xl md:text-7xl font-extrabold text-gray-900 tracking-tight text-center">
                    {(currentCard as Flashcard).front}
                  </h2>
                  <p className="text-gray-400 font-bold text-sm mt-12 animate-pulse flex items-center gap-2">
                    <i className="fa-solid fa-hand-pointer"></i> Tap to flip
                  </p>
                </div>
              )}
              {currentCard.type === "mcq" && renderMCQ(currentCard as MCQCard)}
              {currentCard.type === "blanks" &&
                renderBlanks(currentCard as BlanksCard)}
              {currentCard.type === "match" &&
                renderMatch(currentCard as MatchCard)}
            </div>
          </div>

          {/* BACK OF CARD (Only used for Flashcards) */}
          <div
            className="absolute inset-0 bg-white border-2 border-indigo-500 rounded-[40px] shadow-[0_12px_0_0_#C7D2FE] flex flex-col p-6 md:p-8"
            style={{
              backfaceVisibility: "hidden",
              transform: "rotateY(180deg)",
            }}
          >
            <div className="flex justify-center mb-6">
              <span className="text-[10px] md:text-xs font-black text-indigo-400 uppercase tracking-[0.2em]">
                Answer
              </span>
            </div>

            <div className="flex-1 flex flex-col items-center justify-center">
              <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 mb-6 text-center">
                {(currentCard as Flashcard).front}
              </h2>
              <div className="w-16 h-1.5 bg-indigo-100 rounded-full mb-6"></div>
              <h3 className="text-2xl md:text-3xl font-black text-indigo-500 text-center">
                {(currentCard as Flashcard).back}
              </h3>
            </div>
          </div>
        </div>

        {/* Action Area anchored immediately below the card */}
        <div className="w-full max-w-[380px] md:max-w-[420px] mt-10 min-h-[80px]">
          {/* State 1: Needs to check answer (Hidden for Flashcards/Match Madness) */}
          {!isRevealed &&
            currentCard.type !== "normal" &&
            currentCard.type !== "match" && (
              <button
                onClick={handleCheckAnswer}
                disabled={
                  (currentCard.type === "mcq" && !selectedOption) ||
                  (currentCard.type === "blanks" && !blankInput)
                }
                className="w-full active:translate-y-1 active:shadow-none disabled:opacity-50 disabled:active:translate-y-0 disabled:cursor-not-allowed bg-indigo-500 text-white px-8 py-4 rounded-2xl font-black text-lg shadow-[0_6px_0_0_#3F498A] hover:bg-indigo-600 transition-all uppercase tracking-wider"
              >
                Check Answer
              </button>
            )}

          {/* State 2: FSRS Ratings (Revealed) */}
          {isRevealed && (
            <div className="animate-[fadeIn_0.3s_ease-out]">
              <div className="grid grid-cols-4 gap-2 md:gap-3">
                <RatingButton
                  color="red"
                  label="Again"
                  time="1m"
                  shadow="#FECACA"
                  onClick={() => handleRate("again")}
                />
                <RatingButton
                  color="orange"
                  label="Hard"
                  time="6m"
                  shadow="#FED7AA"
                  onClick={() => handleRate("hard")}
                />
                <RatingButton
                  color="green"
                  label="Good"
                  time="10m"
                  shadow="#BBF7D0"
                  onClick={() => handleRate("good")}
                />
                <RatingButton
                  color="blue"
                  label="Easy"
                  time="4d"
                  shadow="#BFDBFE"
                  onClick={() => handleRate("easy")}
                />
              </div>
            </div>
          )}
        </div>
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
    red: "bg-red-50 text-red-600 border-red-200 hover:bg-red-100",
    orange:
      "bg-orange-50 text-orange-500 border-orange-200 hover:bg-orange-100",
    green: "bg-green-50 text-green-600 border-green-200 hover:bg-green-100",
    blue: "bg-blue-50 text-blue-500 border-blue-200 hover:bg-blue-100",
  };

  return (
    <button
      onClick={onClick}
      className={`active:translate-y-1 active:shadow-none transition-all border-2 rounded-2xl py-3 flex flex-col items-center justify-center cursor-pointer ${bgClasses[color]}`}
      style={{ boxShadow: `0 4px 0 0 ${shadow}` }}
    >
      <span className="font-black text-sm md:text-base uppercase tracking-tight">
        {label}
      </span>
      <span className="text-[10px] font-bold opacity-60 mt-0.5">{time}</span>
    </button>
  );
}
