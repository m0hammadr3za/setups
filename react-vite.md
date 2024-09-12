# Setting Up a React/Vite Project

This guide walks you through setting up a React project using Vite, with configurations for styled-components, Storybook, and path aliases for efficient project management.

## Create a New Project with Vite

1. **Open Terminal** (or your preferred command-line interface).
2. **Create a new Vite project**:

   ```bash
   yarn create vite
   ```

3. **Enter the project name**, e.g., `my-vite-react-app`.
4. **Choose a framework**: Select `React` from the options:

   ```bash
   Select a framework: » React
   ```

5. **Select a variant**: Choose `Typescript` for TypeScript support or `Javascript` for plain JavaScript.

---

## Navigate to the Project Folder

After the project has been created, navigate to the project directory:

```bash
cd my-vite-react-app
```

---

## Install Dependencies

Install the project dependencies:

```bash
yarn
```

---

## Run the Development Server

Start the Vite development server:

```bash
yarn dev
```

Your app will be running at [http://localhost:5173](http://localhost:5173).

---

## Setting Up Styled Components

### Install Styled Components

To add `styled-components`, run:

```bash
yarn add styled-components
yarn add -D @types/styled-components
```

This installs `styled-components` and its TypeScript definitions.

### Optional Vite Configuration

Vite supports styled-components without extra configuration. If you encounter issues with fast refresh, add the following to your `vite.config.ts`:

```ts
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  esbuild: {
    jsxFactory: "jsx",
    jsxFragment: "Fragment",
  },
});
```

### Use ThemeProvider for Global Styling (Optional)

To apply global theming, follow these steps:

1. **Create a theme file**:

   ```ts
   // src/theme.ts
   export const theme = {
     colors: {
       primary: "#0070f3",
       secondary: "#1c1c1e",
     },
   };
   ```

2. **Wrap your app in the ThemeProvider**:

   ```tsx
   // index.tsx
   import React from "react";
   import ReactDOM from "react-dom/client";
   import App from "./App";
   import { ThemeProvider } from "styled-components";
   import { theme } from "./theme";

   const rootElement = document.getElementById("root")!;
   const root = ReactDOM.createRoot(rootElement);

   root.render(
     <React.StrictMode>
       <ThemeProvider theme={theme}>
         <App />
       </ThemeProvider>
     </React.StrictMode>
   );
   ```

3. **Access theme variables in your styled components**:

   ```tsx
   // App.tsx
   import React from "react";
   import styled from "styled-components";

   const Container = styled.div`
     display: flex;
     justify-content: center;
     align-items: center;
     height: 100vh;
     background-color: ${(props) => props.theme.colors.primary};
   `;

   const Title = styled.h1`
     color: white;
     font-size: 2rem;
   `;

   const App: React.FC = () => {
     return (
       <Container>
         <Title>Themed Styled Components</Title>
       </Container>
     );
   };

   export default App;
   ```

### Using `styled-components` for Global Styles

Styled Components allows you to define global styles through its `createGlobalStyle` helper.

1. **Create a global styles file** (e.g., `GlobalStyles.js` in the `src` folder):

   ```jsx
   // src/GlobalStyles.js
   import { createGlobalStyle } from "styled-components";

   const GlobalStyle = createGlobalStyle`
     /* CSS Reset */
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
   ```

2. **Include the global styles in your App**:

   Open your `App.jsx` and import `GlobalStyle`:

   ```jsx
   import React from "react";
   import GlobalStyle from "./GlobalStyles";

   const App = () => {
     return (
       <>
         <GlobalStyle /> {/* Apply global styles */}
         <div>{/* Your App Components */}</div>
       </>
     );
   };

   export default App;
   ```

This will apply the global styles from `styled-components` across your entire app.

---

## Setting Up Storybook

### Install Storybook

Install Storybook by running:

```bash
npx storybook@latest init
```

This will install Storybook and configure it for React with Vite as the build tool.

### Run Storybook

Start the Storybook development server:

```bash
yarn storybook
```

Storybook will be available at [http://localhost:6006](http://localhost:6006).

---

## Configuring Path Aliases

### Configure Path Aliases in `tsconfig.json`

To set up path aliases for cleaner imports, modify your `tsconfig.json`:

```json
{
  "compilerOptions": {
    "baseUrl": "./src",
    "paths": {
      "@components/*": ["components/*"],
      "@utils/*": ["utils/*"],
      "@assets/*": ["assets/*"]
    }
  }
}
```

### Configure Vite for Path Aliases

Update your `vite.config.ts` file to ensure Vite understands the alias paths:

```ts
// vite.config.ts
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@components": path.resolve(__dirname, "./src/components"),
      "@utils": path.resolve(__dirname, "./src/utils"),
      "@assets": path.resolve(__dirname, "./src/assets"),
    },
  },
});
```

### Configure Storybook for Path Aliases

Add path aliases to Storybook's Vite configuration:

```ts
// .storybook/main.ts
import { StorybookConfig } from "@storybook/react-vite";
import path from "path";

const config: StorybookConfig = {
  stories: ["../src/**/*.mdx", "../src/**/*.stories.@(js|jsx|ts|tsx)"],
  addons: [
    "@storybook/addon-links",
    "@storybook/addon-essentials",
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
      "@components": path.resolve(__dirname, "../src/components"),
      "@utils": path.resolve(__dirname, "../src/utils"),
      "@assets": path.resolve(__dirname, "../src/assets"),
    };
    return config;
  },
};

export default config;
```

### Use Aliases in Your Project

Now, you can use aliases in your imports. For example, instead of:

```tsx
import Button from "../../../components/Button";
```

You can write:

```tsx
import Button from "@components/Button";
```

---

By following this guide, you'll have a React project set up with Vite, styled-components, Storybook, and path aliases, all working seamlessly together.
