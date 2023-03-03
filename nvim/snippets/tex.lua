local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    { trig = "begin", dscr = "A generic new environmennt" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  s(
  { trig = "bf", dscr = "Bold text" },
    fmta(
      [[
      \textbf{<>}
      ]],
      { i(1) }
    )
  ),
  s(
  { trig = "tt", dscr = "Typewriter text" },
    fmta(
      [[
      \texttt{<>}
      ]],
      { i(1) }
    )
  ),
  s(
    { trig = "eq", dscr = "Equation" },
    fmta(
      [[
      \begin{equation}
          <>
          \label{eq:<>}
      \end{equation}

    ]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "sec", dscr = "Section" },
    fmta(
      [[
      \section{<>}%
      \label{sec:<>}

    ]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "ssec", dscr = "Subsection" },
    fmta(
      [[
      \subsection{<>}%
      \label{ssec:<>}

    ]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "sssec", dscr = "Subsubsection" },
    fmta(
      [[
      \subsubsection{<>}%
      \label{sssec:<>}

    ]],
      { i(1), i(2) }
    )
  ),
  s(
    { trig = "rfig", dscr = "Reference figure" },
    fmta(
      [[
      Figure~\ref{fig:<>}
      ]],
      { i(1, "label") }
    )
  ),
  s(
    { trig = "fig", dscr = "Figure" },
    fmta(
      [[
      \begin{figure}
      \centering
      \includegraphics[width=<>\textwidth]{<>},
      \caption{<>}%
      \label{fig:<>}
      \end{figure}

      ]],
      {
        i(1, "0.9"),
        i(2, "file path"),
        i(3, "caption"),
        i(4, "label"),
      }
    )
  ),
  s(
    { trig = "rtab", dscr = "Reference table" },
    fmta(
      [[
      Table~\ref{tab:<>}
      ]],
      { i(1, "label") }
    )
  ),
  s(
    { trig = "table", dscr = "Table" },
    fmta(
      [[
      \begin{table}[<>]
      \centering
      \begin{tabular}{<>}
      \toprule
      <> \\
      \midrule
      <>
      \bottomrule
      \end{tabular}
      \caption{<>}%
      \label{tab:<>}
      \end{table}

      ]],
      {
        i(1, "htb"),
        i(2, "columns"),
        i(3, "tables"),
        i(4, "content"),
        i(5, "caption"),
        i(6, "label"),
      }
    )
  ),
}
