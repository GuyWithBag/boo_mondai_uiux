import React, { createContext, useContext, useState, useEffect } from 'react';

interface SettingsContextType {
  showNotchMargin: boolean;
  setShowNotchMargin: (value: boolean) => void;
}

const SettingsContext = createContext<SettingsContextType | undefined>(undefined);

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

export const useSettings = () => {
  const context = useContext(SettingsContext);
  if (context === undefined) {
    throw new Error('useSettings must be used within a SettingsProvider');
  }
  return context;
};
