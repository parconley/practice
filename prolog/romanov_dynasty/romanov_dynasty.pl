% Name: Parker Conley
% Date: 03.22.23
% Description: This is a knowledge base containing information about
% the first four generations of the Romanov dynasty.
% The family tree diagram is in the file "Romanov Dynasty.png".

% lifespan( <person's name>, <birth year>, <death year> ).
% Generation 1
lifespan(mikhail_i, 1596, 1645).
lifespan(maria_dolgorukaya, 1601, 1625).
lifespan(evdokia_streshneva, 1608, 1645).

% Generation 2
lifespan(irina, 1627, 1679).
lifespan(pelagiya, 1628, 1629).
lifespan(anna, 1631, 1676).
lifespan(marfa, 1631, 1632).
lifespan(ivan, 1633, 1639).
lifespan(tatyana, 1636, 1706).
lifespan(sofiya, 1634, 1636).
lifespan(vasily, 1638, 1639).
lifespan(yevdokiya, 1637, 1637).
lifespan(maria_miloslavskaya, 1625, 1669).
lifespan(alexis, 1629, 1676).
lifespan(natalya_naryshkina, 1651, 1694).

% Generation 3
lifespan(dmitry, 1648, 1649).
lifespan(agafya_grushetskaya, 1663, 1681).
lifespan(feodor_iii, 1661, 1682).
lifespan(marfa_apraksina, 1664, 1716).
lifespan(simeon, 1665, 1669).
lifespan(catherine, 1658, 1718).
lifespan(feodosia_alekseyevna, 1662, 1713).
lifespan(maria_alekseyevna, 1660, 1723).
lifespan(praskovia_saltykova, 1664, 1723).
lifespan(ivan_v, 1666, 1696).
lifespan(marfa, 1652, 1707).
lifespan(alexei, 1654, 1670).
lifespan(sofia, 1657, 1704).
lifespan(yevdokia, 1650, 1712).
lifespan(natalya, 1673, 1716).
lifespan(fyodora, 1674, 1677).
lifespan(eudoxia_lopukhina, 1669, 1731).
lifespan(peter_i_the_great, 1672, 1725).
lifespan(catherine_i, 1684, 1727).

% Generation 4
lifespan(maria, 1689, 1692).
lifespan(ivan_dmitriev_mamonov, 1680, 1730).
lifespan(praskovya, 1694, 1731).
lifespan(feodosia, 1690, 1691).
lifespan(karl_leopold, 1678, 1747).
lifespan(catherine_ivanonva, 1691, 1733).
lifespan(federick_william, 1692, 1711).
lifespan(anna_ivanona, 1693, 1740).


% parentOf( <parent's name>, <child's name> ).
parentOf(mikhail_i, irina).
parentOf(mikhail_i, pelagiya).
parentOf(mikhail_i, anna).
parentOf(mikhail_i, marfa).
parentOf(mikhail_i, ivan).
parentOf(mikhail_i, tatyana).
parentOf(mikhail_i, sofiya).
parentOf(mikhail_i, vasily).
parentOf(mikhail_i, yevdokiya).
parentOf(mikhail_i, alexis).
parentOf(evdokia_streshneva, irina).
parentOf(evdokia_streshneva, pelagiya).
parentOf(evdokia_streshneva, anna).
parentOf(evdokia_streshneva, marfa).
parentOf(evdokia_streshneva, ivan).
parentOf(evdokia_streshneva, tatyana).
parentOf(evdokia_streshneva, sofiya).
parentOf(evdokia_streshneva, vasily).
parentOf(evdokia_streshneva, yevdokiya).
parentOf(evdokia_streshneva, alexis).
parentOf(alexis, dmitry).
parentOf(alexis, feodor_iii).
parentOf(alexis, simeon).
parentOf(alexis, catherine).
parentOf(alexis, feodosia).
parentOf(alexis, maria_alekseyevna).
parentOf(alexis, ivan_v).
parentOf(alexis, marfa).
parentOf(alexis, alexei).
parentOf(alexis, sofia).
parentOf(alexis, yevdokia).
parentOf(maria_miloslavskaya, dmitry).
parentOf(maria_miloslavskaya, feodor_iii).
parentOf(maria_miloslavskaya, simeon).
parentOf(maria_miloslavskaya, catherine).
parentOf(maria_miloslavskaya, feodosia).
parentOf(maria_miloslavskaya, maria_alekseyevna).
parentOf(maria_miloslavskaya, ivan_v).
parentOf(maria_miloslavskaya, marfa).
parentOf(maria_miloslavskaya, alexei).
parentOf(maria_miloslavskaya, sofia).
parentOf(maria_miloslavskaya, yevdokia).
parentOf(alexis, natalya).
parentOf(alexis, fyodora).
parentOf(alexis, peter_i_the_great).
parentOf(natalya_naryshkina, natalya).
parentOf(natalya_naryshkina, fyodora).
parentOf(natalya_naryshkina, peter_i_the_great).
parentOf(ivan_v, maria).
parentOf(ivan_v, praskovya).
parentOf(ivan_v, feodosia).
parentOf(ivan_v, catherine_ivanonva).
parentOf(ivan_v, anna_ivanona).
parentOf(praskovia_saltykova, maria).
parentOf(praskovia_saltykova, praskovya).
parentOf(praskovia_saltykova, feodosia).
parentOf(praskovia_saltykova, catherine_ivanonva).
parentOf(praskovia_saltykova, anna_ivanona).

% rulerOf( <ruler's name>, <country's name>, <year began>, <year ended> ).
rulerOf(mikhail_i, russia, 1613, 1645).
rulerOf(alexis, russia, 1645, 1676).
rulerOf(feodor_iii, russia, 1676, 1682).
rulerOf(ivan_v, russia, 1682, 1696).
rulerOf(peter_i_the_great, russia, 1682, 1725).
rulerOf(catherine_i, russia, 1725, 1727).
rulerOf(anna_ivanona, russia, 1730, 1740).

grandparentOf(Grandparent, Person):-
    parentOf(Grandparent, X), parentOf(X, Person).

siblingOf(Person, Sibling):-
    parentOf(X, Person), parentOf(X, Sibling), Person \= Sibling.

firstCousinOf(Person, FirstCousin):-
    grandparentOf(X, Person), grandparentOf(X, FirstCousin), Person \= FirstCousin.


% Stopped here. Fix variables on all. Complete last two.
ancestorOf(Ancestor, Person):-
    parentOf(Ancestor, Person);
    parentOf(X, Person), ancestorOf(Ancestor, X).

descendentOf(Decendent, Person):-
    parentOf(Person, Decendent);
    parentOf(X, Decendent), descendentOf(Person, X).

%contemporaryOf(A, B):-
%    rulerOf(X, Y, Z)

%successorOf(X, Y):-
%    %