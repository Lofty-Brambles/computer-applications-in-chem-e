function [final_guess, converged, guess_history] = ...
    newtonraphson(f, df, x0, epsilon, k_max) %#ok<FNDEF>

% @parameter f: function handle, f(v) = 0 defines the root to be found
% @parameter df: function handle, analytical derivative of f
% @parameter x0: initial guess (scalar)
% @parameter epsilon: tolerance factor for convergence
% @parameter k_max: maximum number of iterations

% @return final_guess: final guess vector after convergence
% @return converged: shows if convergence was achieved
% @return guess_history: history of guesses

if nargin < 5; k_max = 100; end
if nargin < 4; epsilon = 1e-6; end

k = 1; current_guess = x0; new_guess = inf;
guess_history = zeros(k_max, 1);
guess_history(1) = x0;

convergence_criteria_met = @(current_guess, new_guess) ...
    abs(new_guess - current_guess) < epsilon;
stopping_criteria_met = @(iter, current_guess, new_guess) ...
    iter >= k_max || convergence_criteria_met(current_guess, new_guess);

while ~stopping_criteria_met(k, current_guess, new_guess)
    if k > 1; current_guess = new_guess; end
    
    new_guess = current_guess - f(current_guess) / df(current_guess);
    fprintf("(%d) v: %.6f, f(v): %.6e\n", k, new_guess, f(new_guess));
    
    k = k + 1;
    guess_history(k) = new_guess;
end % end iterating with guess in kth place

final_guess = new_guess;
converged = convergence_criteria_met(current_guess, new_guess);
guess_history = guess_history(1:k);

end