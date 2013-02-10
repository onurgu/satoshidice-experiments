
% How many bets you want to make in a row?
N = 10000;

% How many times do you want to repeat a single row?
T = 100;

% What's your standard bet amount?
bet_amount = 0.1;

% Set the fixed transaction fee here.
transaction_fee = 0.0005;

% This is the amount you want to exit when you reach this amount
% of profit
exit_amount = 0.11;

% The bets (and their corresponding multipliers) you want to analyze
bets = [1 32000 64000];
multipliers = [64000.000 2.004 1.004];

betnames = arrayfun(@(x)(num2str(x)), bets, 'UniformOutput', false);

N_bets = length(bets);