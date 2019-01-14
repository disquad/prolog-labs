%% Факультет комьютерных наук, ХНУ Каразина 2014 КС-32

%% ЛАБ 4  Задачи поиска в пространстве состояний

%% У фермера есть волк, коза и капуста. Все они находятся на левом берегу реки. 
%% Необходимо перевезти это “трио” на правый берег, но в лодку может поместиться что-то одно – волк, 
%% коза или капуста. Нельзя оставлять на одном берегу волка с козой и козу с капустой.

% W-волк, G-коза, C-капуста, F-фермер
% Состояние: 0-левый берег, 1-правый берег

quest([0, 0, 0, 0], L):- write(L), !.  %% Конечное сосотяние, все на правом берегу
quest(X, L):-
  next(X, Y),      			% выбор преемника
  not(member(Y, L)),    % исключение повторного посещения
  quest(Y, [X|L]). 			% переход к следующему состоянию

%% выбор следующего состояния
next(X, Y):- move(X, Y), not(conflict(Y)).

%% возможные перемещения
move([1, G, C, 1], [0, G, C, 0]). % везем вправо волка
move([0, G, C, 0], [1, G, C, 1]). % везем влево волка
move([W, 1, C, 1], [W, 0, C, 0]). % везем вправо козу
move([W, 0, C, 0], [W, 1, C, 1]). % везем влево козу
move([W, G, 1, 1], [W, G, 0, 0]). % везем вправо капусту
move([W, G, 0, 0], [W, G, 1, 1]). % везем влево капусту
move([W, G, C, 1], [W, G, C, 0]). % соло идем вправо
move([W, G, C, 0], [W, G, C, 1]). % соло идем влево

%% конфликтные состояния
%% conflict(1, 1, _, 0). % фермер–справа, слева – волк, коза
%% conflict(_, 1, 1, 0). % фермер–справа, слева – коза, капуста
%% conflict(0, 0, _, 1). % фермер–слева, справа – волк, коза
%% conflict(_, 0, 0, 1). % фермер–слева, справа – коза, капуста

conflict([X, X, _, F]):- F =\= X.
conflict([_, X, X, F]):- F =\= X.
