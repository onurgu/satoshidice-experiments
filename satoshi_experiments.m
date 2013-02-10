exit_positions = zeros(N_bets, T);
required_pocket_depth = zeros(N_bets, T);

for t = 1:T
    X = randi(2^16, 1, N) - 1;
    
    bets_paid = (bet_amount-transaction_fee)*ones(N_bets, N);
    
    total_return = zeros(N_bets, N);
    net_profit = zeros(N_bets, N);
    
    wins = zeros(N_bets, N);
    losses = zeros(N_bets, N);
    
    for b = 1:N_bets,
        wins(b, :) = (X < bets(b));
        losses(b, :) = (X >= bets(b));
        % wins are added
        % losses are subtracted
        total_return(b, :) = bets_paid(b, :).*wins(b, :)*multipliers(b) ...
            + bets_paid(b, :).*losses(b, :)*0.005;
        % transaction fees were substracted in total
        net_profit(b, :) = total_return(b, :) - bets_paid(b, :);
    end
    
    % wins
    % losses
    
    % total_return
    % bets_paid
    
    % net_profit
    sum(net_profit')
    
    vault_series = cumsum(net_profit')';
    
    [I, J] = find(vault_series > exit_amount);
    
    for b = 1:N_bets
        [II, JJ] = find( I == b );
        
        if length(JJ) > 0
            exit_positions(b, t) = J(JJ(1));
            required_pocket_depth(b, t) = min(vault_series(b, 1:J(JJ(1))));
        else
            exit_positions(b, t) = 0;
            required_pocket_depth(b, t) = min(vault_series(b, :));
        end
    end
    plot(vault_series');
    legend(betnames);
    title(['bet\_amount: ' num2str(bet_amount) ', exit\_amount: ' num2str(exit_amount)]);
    drawnow;
end

how_many_successful_exits = sum( exit_positions > 0 , 2)
avg_exit_positions = mean(exit_positions, 2)
avg_required_pocket_depth = mean(required_pocket_depth, 2)

ret.exit_positions = exit_positions;
ret.how_many_successful_exits = how_many_successful_exits;
ret.avg_exit_positions = avg_exit_positions;
ret.avg_required_pocket_depth = avg_required_pocket_depth;

