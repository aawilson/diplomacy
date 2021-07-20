# -*- coding: utf-8 -*-

from ply import lex

tokens = (
    'DASH',
    'SEMICOLON',
    'HOLD',
    'SUPPORT',
    'CONVOY',
    'ARMY_OR_FLEET',
    'TERRITORY',
    'TERRITORY_WITH_COAST',
)
literals = (';')


def t_DASH(t):
    '[-\u2013\u2014]'
    t.value = '-'
    return t


def t_SEMICOLON(t):
    '[,;]'
    t.value = ';'
    return t


def t_HOLD(t):
    r'(?i)h\b|hold'
    t.value = 'HOLD'
    return t


def t_SUPPORT(t):
    r'(?i)s\b|support'
    t.value = 'SUPPORT'
    return t


def t_CONVOY(t):
    r'(?i)c\b|convoy'
    t.value = 'CONVOY'
    return t


def t_ARMY_OR_FLEET(t):
    r'(?i)(a|f)\b'
    t.value = t.value.upper()
    return t


t_TERRITORY = r'(?i)[a-z]{3}'
t_TERRITORY_WITH_COAST = r'(?i)[a-z]{3}/[a-z]{2}'
t_ignore = ' \t\n'


def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)


lexer = lex.lex()


# if __name__ == '__main__':
#     for input_data in (
#         'A Pic',
#         'A Pic Hold',
#         'A Pic - Bre',
#         'A Pic — Bre',
#         'A Pic S Bre H',
#         'A Pic H; A Bre H; A Par H',
#         'F NTH C Lon - Par',
#     ):
#         lexer.input(input_data)
#         print("next")
#         while True:
#             tok = lexer.token()
#             if not tok:
#                 break      # No more input
#             print(tok)


__all__ = ['lexer']
