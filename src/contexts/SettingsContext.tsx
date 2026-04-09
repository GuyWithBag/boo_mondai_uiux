import React, { createContext, useState, useEffect } from 'react';

interface SettingsContextType {
  showNotchMargin: boolean;
  setShowNotchMargin: (value: boolean) => void;
}

// eslint-disable-next-line react-refresh/only-export-components
export const SettingsContext = createContext<SettingsContextType | undefined>(undefined);

export const SettingsProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [showNotchMargin, setShowNotchMargin] = useState(() => {
    const saved = localStorage.getItem('showNotchMargin');
    return saved === 'true';
  });

  useEffect(() => {
    localStorage.setItem('showNotchMargin', showNotchMargin.toString());
  }, [showNotchMargin]);

  return (
    <SettingsContext.Provider value={{ showNotchMargin, setShowNotchMargin }}>
      {children}
    </SettingsContext.Provider>
  );
};

