/// Main export file for the design system
library design_system;

// Core exports
export 'core/breakpoints.dart';
export 'core/responsive_helper.dart';
export 'core/design_tokens.dart';
export 'core/abstract_sizing.dart';

// Extension exports
export 'extensions/context_extensions.dart';
export 'extensions/typography_extensions.dart';
export 'extensions/color_extensions.dart';

// Theme exports
export 'theme/app_colors.dart';
export 'theme/app_typography.dart';
export 'theme/app_theme.dart';

// Component exports - Buttons
export 'components/buttons/app_button.dart';

// Component exports - Text
export 'components/text/app_text.dart';

// Component exports - Layout
export 'components/layout/responsive_container.dart';

// Component exports - Navigation
export 'components/navigation/app_tabbar.dart';

// Component exports - Inputs
export 'components/inputs/app_dropdown.dart';
export 'components/inputs/app_checkbox.dart';
export 'components/inputs/app_radiobutton.dart';

// Component exports - Media
export 'components/media/app_image.dart';

// Utility exports
export 'utils/size_config.dart';
export 'utils/responsive_utils.dart';

// Utility exports
export 'utils/size_config.dart' show SizeConfig;
export 'utils/responsive_utils.dart' show ResponsiveUtils;
