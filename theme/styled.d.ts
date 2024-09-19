import "styled-components";
import { colors } from "./colors";
import { typography } from "./typography";
import { spacing } from "./spacing";
import { breakpoints } from "./breakpoints";
import { shadows } from "./shadows";
import { radius } from "./radius";

declare module "styled-components" {
  export interface DefaultTheme {
    colors: typeof colors;
    typography: typeof typography;
    spacing: typeof spacing;
    breakpoints: typeof breakpoints;
    shadows: typeof shadows;
    radius: typeof radius;
  }
}
