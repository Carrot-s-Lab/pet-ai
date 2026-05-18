// class ContentExample {
//   static String markdownFlutterTeX() {
//     return """
// # flutter_tex
//
// # Contents
// * [About](#about)
// * [Demo Video]
// * [How to use?](#how-to-use)
//    * [Android](#android)
//    * [iOS](#ios)
//    * [Web](#web)
// * [Examples](#examples)
//     * [Quick Example](#quick-example)
//     * [TeXView Document Example](#texview-document-example)
//     * [TeXView Quiz Example](#texview-quiz-example)
//     * [TeXView Custom Fonts Example](#texview-custom-fonts-example)
//     * [TeXView Image and Video Example](#texview-image-and-video-example)
//     * [TeXView InkWell Example](#texview-inkwell-example)
//     * [Complete Example](#complete-example)
// * [Demo Application](#application-demo)
// * [Demo Web](#web-demo)
// * [Api Changes](#api-changes)
// * [Api Usage](#api-usage)
// * [Todo](#to-do)
// * [Cautions](#cautions)
//
// # About
// A Flutter Package to render **fully offline** so many types of equations based on **LaTeX** and **TeX**, most commonly used are as followings:
//
// - **Mathematics / Maths Equations** (Algebra, Calculus, Geometry, Geometry etc...)
//
// - **Physics Equations**
//
// - **Signal Processing Equations**
//
// - **Chemistry Equations**
//
// - **Statistics / Stats Equations**
//
// - It also includes full **HTML** with **JavaScript** support.
//
// Rendering of equations depends on [mini-mathjax](https://github.com/electricbookworks/mini-mathjax) a simplified version of [MathJax](https://github.com/mathjax/MathJax/) and [Katex](https://github.com/KaTeX/KaTeX) JavaScript libraries.
//
// This package mainly depends on [**webview_flutter_plus**](https://pub.dartlang.org/packages/webview_flutter_plus) a very powerful extension of [webview_flutter](https://pub.dartlang.org/packages/webview_flutter).
//
//
// # Demo Video
//
// ## [Click to Watch Demo on Youtube](https://www.youtube.com/watch?v=YiNbVEXV_NM)
//
// """;
//   }
//
//
//   static String mathExpression() {
//     return r"""
//
// This is inline latex: $$f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$$
//
// This is block level latex:
//
// $$
// c = \pm\sqrt{a^2 + b^2}
// $$
//
// This is inline latex with displayMode: $$f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$$
//
// The relationship between the height and the side length of an equilateral triangle is:
//
// \[ \text{Height} = \frac{\sqrt{3}}{2} \times \text{Side Length} \]
//
// \[ \text{X} = \frac{1}{2} \times \text{Y} \times \text{Z} = \frac{1}{2} \times 9 \times \frac{\sqrt{3}}{2} \times 9 = \frac{81\sqrt{333}}{4} \]
//
// The basic form of the Taylor series is:
//
// \[f(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \frac{f'''(a)}{3!}(x-a)^3 + \cdots\]
//
// where \(f(x)\) is the function to be expanded, \(a\) is the expansion point, \(f'(a)\), \(f''(a)\), \(f'''(a)\), etc., are the first, second, third, and so on derivatives of the function at point \(a\), and \(n!\) denotes the factorial of \(n\).
//
// In particular, when \(a=0\), this expansion is called the Maclaurin series.
//
// """;
//   }
//
//
//   static String htmlContentExample() {
//     return """${mathExpression()}<h1>Familiar. Fully-featured. Mobile optimized.</h1>\n<p>With an open source Core, uncomplicated low-code plug-in structure and additional Premium add-ons, TinyMCE scales with your app as you grow. That’s why it’s the WYSIWYG editor-of-choice for 1.5M+ developers when they need to build and ship products faster.</p>\n<p><img style=\"float: right;\" role=\"presentation\" src=\"https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg\" alt=\"TinyMCE demo image\" width=\"316\" />Use TinyMCE as:</p>\n<ul>\n<li>A <strong>basic</strong> editor</li>\n<li>An advanced 📝 editor</li>\n<li>An AI-powered 🪄✨ editor</li>\n<li>A {{template-based}} editor</li>\n<li>A totally <span class=\"highlight\"><code>&lt;customized&gt;</code></span> editor</li>\n<li>An equation ➕ formula editor</li>\n</ul>\n<h2>Play with this demo to see how it works</h2>""";
//   }
//
//   static String newMarkDownText() {
//     return r"""
//               <p><b>Cho công thức sau:</b></p>
//               <p><a href="#"><img height="43" width="161" alt="\sqrt{a^2 + b^2}" src="https://latex.codecogs.com/svg.latex?%5C%5C%20%5Csqrt%7Ba%5E2%20%2B%20b%5E2%7D" /></a></p>
//               <p>Khi <b>a = 1</b>, <b>b = 4</b>, thì biểu thức trên có kết quả là?</p>
//               """;
//   }
// }