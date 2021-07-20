# -*- coding: utf-8 -*-

from ply import yacc

from orders_lexer import lexer, tokens  # noqa


def p_orders(p):
    'orders : orders_list'
    p[0] = ('orders', p[1])


def p_orders_list(p):
    '''orders_list : orders_indiv_ orders_list
                   |'''
    if len(p) == 1:
        pass
    elif len(p) == 3 and not p[2]:
        p[0] = (p[1],)
    else:
        p[0] = (p[1], *p[2])


def p_orders_indiv_(p):
    '''orders_indiv_ : order SEMICOLON
                     | order'''
    p[0] = p[1]


def p_order(p):
    '''order : hold
             | invade
             | convoy
             | support'''
    p[0] = ('order', p[1])


def p_hold(p):
    '''hold : ARMY_OR_FLEET TERRITORY
            | ARMY_OR_FLEET TERRITORY HOLD'''
    p[0] = (p[1].upper(), p[2], 'hold')


def p_invade(p):
    '''invade : ARMY_OR_FLEET TERRITORY DASH TERRITORY
              | ARMY_OR_FLEET TERRITORY DASH TERRITORY_WITH_COAST'''
    p[0] = (p[1].upper(), p[2], 'invade', p[4])


def p_convoy(p):
    '''convoy : ARMY_OR_FLEET TERRITORY CONVOY order'''
    p[0] = (p[1].upper(), p[2], 'convoy', p[4])


def p_support(p):
    '''support : ARMY_OR_FLEET TERRITORY SUPPORT order'''
    p[0] = (p[1].upper(), p[2], 'support', p[4])


def parse(input_data, *args, **kwds):
    parser = yacc.yacc()
    return parser.parse(input_data, *args, **kwds)


def p_error(p):
    if p:
        print("Syntax error at token", p.type)
        print(f"    {p.value}")
    else:
        print("Syntax error at EOF")


if __name__ == '__main__':
    import pprint
    for order in (
        "A Pic; A Bre H; A Par Hold",
        "A Rus; A Mos",
        "A Pic - Bre",
        "A Pic S A Bre",
        "A Pic S A Bre - Par",
        "F ENG C A Lon - Par",
        "F WES - Spa/nc",
    ):
        print(f'  parsing {order}')
        pprint.pprint(parse(order))
