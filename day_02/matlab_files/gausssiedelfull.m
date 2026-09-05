% --- INPUT ---
fprintf("--- INPUT ---\n");
n = input("n: ");

A = zeros(n, n);
for i = 1:n
    A(i, :) = input(sprintf("A row %d: ", i));
end

b = input("b: ")';

x0 = input("Initial guess: ")';

display_input = table(A, b, x0, ...
    VariableNames={'A', 'b', 'Initial_guess'});
disp(display_input);

% --- OUTPUT ---
fprintf("\n--- OUTPUT ---\n");
[final_guess, converged, guess_history] = gausssiedel(A, b, x0, 1e-6, 10);

fprintf("Final guess: \n");
format short g

disp(final_guess);
fprintf("Converged: %s\n", string(converged));

% print pretty table of guess history, with truncation for too many iterations
row_indices = "Iteration " + string(1:size(guess_history, 1));
fprintf("\nGuess history:\n");
guess_history_table = array2table(guess_history, ...
    VariableNames="x" + string(1:n), RowNames=row_indices);
disp(guess_history_table);


function [final_guess, converged, guess_history] = ...
    gausssiedel(A, b, x0, epsilon, k_max) %#ok<FNDEF>
    % @parameter A: coefficient matrix
    % @parameter b: right-hand-side vector
    % @parameter x0: initial guess vector
    % @parameter k_max: maximum number of iterations
    % @parameter epsilon: tolerance factor for convergence
    % @return final_guess: final guess vector after convergence
    % @return converged: shows if convergence was achieved
    % @return guess_history: history of guesses
    if nargin < 5; k_max = 100; end
    if nargin < 4; epsilon = 1e-6; end

    k = 1; current_guess = x0; new_guess = inf(size(x0));
    guess_history = zeros(k_max, size(x0, 1));
    guess_history(1, :) = x0;

    convergence_criteria_met = @(current_guess, new_guess) ...
        norm(new_guess - current_guess) < epsilon;
    stopping_criteria_met = @(iter, current_guess, new_guess) ...
        iter >= k_max || convergence_criteria_met(current_guess, new_guess);

    while ~stopping_criteria_met(k, current_guess, new_guess)
        if k > 1; current_guess = new_guess; end

        for i = 1:size(A, 1)
            terms_before = A(i, 1:i-1) * new_guess(1:i-1);
            terms_after = A(i, i+1:end) * current_guess(i+1:end);
            new_guess(i) = (b(i) - terms_before - terms_after) / A(i, i);
        end % end of loop updating new guess values for one iteration

        k = k + 1;
        guess_history(k, :) = new_guess;
    end % end of loop of iterations predicting guess vectors

    final_guess = new_guess;
    converged = convergence_criteria_met(current_guess, new_guess);
    guess_history = guess_history(1:k, :);
end