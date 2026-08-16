function [root, final_iter, guess_history] = newtonRaphsonSolver(f, df, initial_guess, tolerance, maxIterations) %#ok<FNDEF>
    % @parameter f: numeric equation with rhs = 0
    % @parameter df: derivative of the numeric equation
    % @parameter initial_guess: initial guess for root
    % @parameter tolerance: stopping factor, compared to difference between consecutive guesses
    % @parameter maxIterations: stopping factor, compared to limit iteration count

    % @return root: the final guess for the root
    % @return final_iter: the number of iterations taken to converge to that root
    % @return guess_history: the array of guesses made during each iteration

    % default arguments
    if nargin < 5; maxIterations = 100; end
    if nargin < 4; tolerance = 1e-6; end

    guess_history = zeros(maxIterations, 1);
    guess_history(1) = initial_guess;

    for iter = 1:maxIterations
        current_guess = guess_history(iter);
        next_guess = current_guess - f(current_guess) / df(current_guess);
        guess_history(iter + 1) = next_guess;

        % consider both criteria, either fulfills, we break out of the loop
        stopping_criteria = ...
            iter >= maxIterations || abs(next_guess - current_guess) < tolerance;
        if stopping_criteria; break; end
    end

    root = guess_history(iter + 1);
    final_iter = iter;
    guess_history = guess_history(1:iter + 1);
end