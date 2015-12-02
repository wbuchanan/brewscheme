---
layout: post
title:  "Getting ready for version 1 release"
date:   2015-12-02 04:50:00
categories: update
---

# New feature addition 
The `brewproof` prefix command has finally been added to the [brewscheme](https://github.com/wbuchanan/brewscheme) collection of programs.  [brewproof](https://wbuchanan.github.io/brewscheme/brewproof/) is a command that allows users to quickly and easily create proofs of their data visualizations that simulate the appearance of the graph to individuals with achromatopsia (complete color vision loss), protanopia (red color vision impairment), deuteranopia (green color vision impairment), and tritanopia (blue color vision impairment) without having to modify their existing syntax beyond the addition of `brewproof, scheme(brewscheme generated scheme name):` to the start of the command.  For additional information, examples, and to see the output of the command, please visit the [brewproof](https://wbuchanan.github.io/brewscheme/brewproof/) page.  

# Other news/updates
The addition of the `brewproof` command marks the end of development for the v 1.0.0 release.  No new features will be added prior to the release of this first major version.  However, some of the plans for the next release include:

1. Providing option for brewscheme/brewtheme to generate CSS file(s)
2. More comprehensive color translations (e.g., translating across color spaces, etc...)
3. Color distance estimation (e.g., to help users pick the most contrasting color given an input)

