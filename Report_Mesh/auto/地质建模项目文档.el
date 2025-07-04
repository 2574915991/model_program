(TeX-add-style-hook
 "地质建模项目文档"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("ctexart" "a4paper" "twoside")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("hyperref" "colorlinks" "linkcolor=blue")))
   (TeX-run-style-hooks
    "latex2e"
    "ctexart"
    "ctexart10"
    "geometry"
    "makecell"
    "siunitx"
    "amssymb"
    "indentfirst"
    "multirow"
    "caption"
    "mathrsfs"
    "amsfonts"
    "amsmath"
    "amsthm"
    "enumerate"
    "xcolor"
    "graphicx"
    "float"
    "subfigure"
    "epstopdf"
    "multicol"
    "fancyhdr"
    "layout"
    "listings"
    "dsfont"
    "hyperref"
    "anyfontsize"
    "tikz")
   (TeX-add-symbols
    '("Pyr" 2)
    '("pnSpaceK" 1)
    '("vertexSequence" 4)
    '("closure" 1)
    '("DRLNA" 1)
    '("DRLLN" 1)
    '("DRLN" 1)
    '("timelineA" 2)
    '("streak" 2)
    '("timeBPA" 1)
    '("timeBP" 1)
    '("timeline" 2)
    '("regrz" 1)
    '("curve" 1)
    '("scientific" 2)
    '("dist" 2)
    '("pdfFrac" 2)
    '("difFrac" 2)
    '("avg" 1)
    "dif"
    "OFL"
    "UFL"
    "fl"
    "op"
    "Eabs"
    "Erel"
    "Zero"
    "One"
    "Int"
    "unitV"
    "bmi"
    "bmj"
    "bmn"
    "Dim"
    "me"
    "mi"
    "dt"
    "isCovered"
    "coveredBy"
    "Span"
    "oplusDR"
    "qo"
    "xo"
    "yo"
    "ppSpace"
    "pnSpace"
    "sixteen")
   (LaTeX-add-labels
    "fig:二维地质构造剖面示例"
    "sec:Preliminary"
    "fig:地层分层剖面"
    "fig:不同形态特征的褶皱构造"
    "fig:相似褶皱"
    "fig:平行褶皱"
    "fig:不同几何模式的褶皱构造"
    "fig:断层示意图"
    "fig:断层面"
    "fig:断层滑距和断距"
    "fig:断层破碎带"
    "fig:方位角"
    "fig:真倾角和视倾角"
    "fig:岩层产状"
    "fig:岩层产状示例"
    "fig:岩层产状及其示例"
    "fig:井轨迹投影"
    "fig:井斜角和井斜方位角"
    "fig:井斜相关概念"
    "sec:极等面积网"
    "sec:投影原理"
    "fig:兰伯特投影上半球"
    "fig:兰伯特等积投影示意"
    "fig:兰伯特等积投影法"
    "fig:极等面积网投影"
    "fig:极等面积网"
    "sec:构成分析"
    "fig:单斜示例"
    "fig:褶皱示例"
    "fig:构成分析"
    "fig:褶皱构造图示"
    "sec:构造轴线与投影平面计算"
    "fig:图解法求褶皱枢纽"
    "sec:蛛网法"
    "fig:蛛网法")
   (LaTeX-add-environments
    "theorem"
    "corollary"
    "lemma"
    "definition"
    "proposition"
    "example"
    "notation"
    "algorithm"))
 :latex)

