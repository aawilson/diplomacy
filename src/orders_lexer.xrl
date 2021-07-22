Definitions.

EN_DASH = \x{2014}
EM_DASH = \x{2015}

Rules.

[-{EN_DASH}{EM_DASH}]                        : {token, {'-', TokenLine}}.
[,;](\n)*                                    : {token, {separator, TokenLine}}.
\n+                                          : {token, {separator, TokenLine}}.
([hH]([oO][lL][dD])?)                        : {token, {hold, TokenLine}}.
([sS]([uU][pP][pP][oO][rR][tT])?)            : {token, {support, TokenLine}}.
([cC]([oO][nN][vV][oO][yY])?)                : {token, {convoy, TokenLine}}.
([aA]([rR][mM][yY])?)                        : {token, {army, TokenLine}}.
([fF]([lL][eE][eE][tT])?)                    : {token, {fleet, TokenLine}}.
[a-zA-Z][a-zA-Z][a-zA-Z](/[a-zA-Z][a-zA-Z])? : {token, {territory, TokenLine, TokenChars}}.
[\s\t\r]+                                    : skip_token.

Erlang code.
