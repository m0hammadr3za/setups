# Prompt for the project name
$projectName = Read-Host "Enter your project name"

# Create a new Vite project with React and TypeScript
yarn create vite $projectName --template react-ts

# Navigate to the project directory
Set-Location $projectName

# Install project dependencies
yarn

# Install styled-components and its TypeScript definitions
yarn add styled-components
yarn add -D @types/styled-components

# Install Storybook
npx storybook@latest init --yes --skip-install
yarn

# Create the src/theme directory if it doesn't exist
if (-not (Test-Path "./src/theme")) {
  New-Item -ItemType Directory -Path "./src/theme"
}

# Add src/theme/index.ts
Set-Content -Path "./src/theme/index.ts" -Value @'
import { colors } from "./colors";
import { typography } from "./typography";
import { spacing } from "./spacing";
import { breakpoints } from "./breakpoints";
import { shadows } from "./shadows";
import { radius } from "./radius";

export const theme = {
colors,
typography,
spacing,
breakpoints,
shadows,
radius,
};
'@

# Add src/theme/colors.ts
Set-Content -Path "./src/theme/colors.ts" -Value @'
export const colors = {
primary: {
  light: "#4f8cff",
  main: "#1a73e8",
  dark: "#0059b2",
  contrastText: "#ffffff",
},
secondary: {
  light: "#ff8a80",
  main: "#ff5252",
  dark: "#c50e29",
  contrastText: "#ffffff",
},
neutral: {
  white: "#ffffff",
  black: "#000000",
  gray: "#b0bec5",
  darkGray: "#37474f",
  lightGray: "#eceff1",
},
background: {
  default: "#f7f8fa",
  paper: "#ffffff",
},
text: {
  primary: "#212121",
  secondary: "#757575",
  disabled: "#bdbdbd",
},
};
'@

# Add src/theme/breakpoints.ts
Set-Content -Path "./src/theme/breakpoints.ts" -Value @'
export const breakpoints = {
xs: "320px", // mobile devices
sm: "576px", // small screen (mobile phones in landscape, smaller tablets)
md: "768px", // medium screen (tablets, smaller laptops)
lg: "992px", // large screen (laptops, desktops)
xl: "1200px", // extra-large screen (large desktops, wide monitors)
};
'@

# Add src/theme/radius.ts
Set-Content -Path "./src/theme/radius.ts" -Value @'
export const radius = {
small: "4px",
medium: "8px",
large: "16px",
};
'@

# Add src/theme/shadows.ts
Set-Content -Path "./src/theme/shadows.ts" -Value @'
export const shadows = {
small: "0px 2px 4px rgba(0, 0, 0, 0.1)",
medium: "0px 4px 8px rgba(0, 0, 0, 0.15)",
large: "0px 6px 12px rgba(0, 0, 0, 0.2)",
};
'@

# Add src/theme/spacing.ts
Set-Content -Path "./src/theme/spacing.ts" -Value @'
export const spacing = {
xs: "4px",
sm: "8px",
md: "16px",
lg: "24px",
xl: "32px",
};
'@

# Add src/theme/typography.ts
Set-Content -Path "./src/theme/typography.ts" -Value @'
export const typography = {
fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
fontSize: {
  small: "0.875rem",
  medium: "1rem",
  large: "1.25rem",
},
fontWeight: {
  light: 300,
  regular: 400,
  medium: 500,
  bold: 700,
},
lineHeight: {
  small: 1.3,
  medium: 1.5,
  large: 1.7,
},
headingSizes: {
  h1: "2.5rem",
  h2: "2rem",
  h3: "1.75rem",
  h4: "1.5rem",
  h5: "1.25rem",
  h6: "1rem",
},
};
'@

# Add src/GlobalStyles.ts
Set-Content -Path "./src/GlobalStyles.ts" -Value @'
import { createGlobalStyle } from "styled-components";

const GlobalStyle = createGlobalStyle`
  *,
  *::before,
  *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  }

  html,
  body {
  height: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 16px;
  line-height: 1.5;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  }

  body {
  background-color: #fff;
  color: #333;
  overflow-x: hidden;
  }

  a {
  text-decoration: none;
  color: inherit;
  }

  ul,
  ol {
  list-style: none;
  }

  img,
  picture,
  video,
  canvas,
  svg {
  display: block;
  max-width: 100%;
  }

  button,
  input,
  textarea,
  select {
  font: inherit;
  border: none;
  outline: none;
  }

  button {
  cursor: pointer;
  background-color: transparent;
  }

  table {
  border-collapse: collapse;
  border-spacing: 0;
  }

  blockquote,
  q {
  quotes: none;
  }

  blockquote::before,
  blockquote::after,
  q::before,
  q::after {
  content: "";
  content: none;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  p {
  margin: 0;
  }

  address {
  font-style: normal;
  }
`;

export default GlobalStyle;
'@

# Replace the code inside of src/App.tsx
Set-Content -Path "./src/App.tsx" -Value @'
export const App = () => {
  return (
    <>
      <h1>Working as intended</h1>
    </>
  );
};
'@

# Replace the code inside of src/main.tsx
Set-Content -Path "./src/main.tsx" -Value @'
import { createRoot } from "react-dom/client";
import { StrictMode } from "react";
import { ThemeProvider } from "styled-components";
import GlobalStyle from "./GlobalStyles";
import { theme } from "./theme";
import { App } from "./App";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <ThemeProvider theme={theme}>
      <GlobalStyle />
      <App />
    </ThemeProvider>
  </StrictMode>
);
'@

# Delete every file in public
Remove-Item -Path "./public/*" -Force

# Delete every file in src/assets
Remove-Item -Path "./src/assets/*" -Force

# Delete src/stories
Remove-Item -Path "./src/stories" -Recurse -Force

# Delete src/app.css
Remove-Item -Path "./src/app.css" -Force

# Delete src/index.css
Remove-Item -Path "./src/index.css" -Force

# Change the extension of .storybook/preview.ts to .tsx
Rename-Item -Path "./.storybook/preview.ts" -NewName "preview.tsx"

# Replace the code inside of .storybook/preview.tsx
Set-Content -Path "./.storybook/preview.tsx" -Value @'
import React from "react";
import type { Preview } from "@storybook/react";
import { ThemeProvider } from "styled-components";
import GlobalStyles from "../src/GlobalStyles";
import { theme } from "../src/theme";

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    backgrounds: {
      values: [
        { name: "Dark", value: "#333" },
        { name: "Light", value: "#F7F9F2" },
        { name: "Black", value: "#000000" },
        { name: "White", vlaue: "#ffffff" },
      ],
      default: "Light",
    },
  },
  decorators: [
    (Story) => (
      <ThemeProvider theme={theme}>
        <GlobalStyles />
        <Story />
      </ThemeProvider>
    ),
  ],
};

export default preview;
'@

# Replace the code inside of ./tsconfig.json
Set-Content -Path "./tsconfig.json" -Value @'
{
  "compilerOptions": {
    "baseUrl": "./src",
    "paths": {
      "@src/*": ["./*"],
      "@assets/*": ["assets/*"]
    }
  },
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
'@

# Replace the code inside of ./vite.config.ts
Set-Content -Path "./vite.config.ts" -Value @'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@src": path.resolve(__dirname, "./src"),
      "@assets": path.resolve(__dirname, "./src/assets"),
    },
  },
});
'@

# Replace the code inside of ./.storybook/main.ts
Set-Content -Path "./.storybook/main.ts" -Value @'
import type { StorybookConfig } from "@storybook/react-vite";
import path from "path";

const config: StorybookConfig = {
  stories: ["../src/**/*.mdx", "../src/**/*.stories.@(js|jsx|mjs|ts|tsx)"],
  addons: [
    "@storybook/addon-onboarding",
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@chromatic-com/storybook",
    "@storybook/addon-interactions",
  ],
  framework: {
    name: "@storybook/react-vite",
    options: {},
  },
  async viteFinal(config) {
    config.resolve = config.resolve || {};
    config.resolve.alias = {
      ...config.resolve.alias,
      "@src": path.resolve(__dirname, "../src"),
      "@assets": path.resolve(__dirname, "../src/assets"),
    };
    return config;
  },
};
export default config;
'@
