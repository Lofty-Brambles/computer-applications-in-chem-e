%% [Set 2] Question 5 - Newton-Raphson Method
% Solve: x^4 - x - 10 = 0

% --- INPUT ---
f = @(x) x.^4 - x - 10;
df = @(x) 4*x.^3 - 1;
initial_guess = 2.0;

disp("--- INPUT ---");
disp("We take an initial guess of: " + initial_guess)

% --- OUTPUT ---
[root, final_iter, guess_history] = newtonRaphsonSolver(f, df, initial_guess);

disp(newline + "--- OUTPUT ---");
disp("The root of the equation is: " + root);
disp("The number of iterations taken to converge to that root is: " + final_iter);

% --- GRAPH ---
GRAPH_PADDING = 0.15;
graph_x_min = min(guess_history) - GRAPH_PADDING;
graph_x_max = max(guess_history) + GRAPH_PADDING;

ref_points = linspace(graph_x_min, graph_x_max, 100);
plot(ref_points, f(ref_points), "-b", "LineWidth", 2);
hold on;

plot(guess_history, f(guess_history), "o-r", "LineWidth", 1.5, "MarkerSize", 8, "MarkerFaceColor", "r");
plot([graph_x_min, graph_x_max], [0, 0], "-k", "LineWidth", 2);

title("Guesses for root using Newton-Raphson Method");
xlabel("x"); ylabel("y");
legend("Reference function", "Guesses for the root");
hold off; grid on;


%% ----- Local function (must appear after all script commands) -----

function [root, final_iter, guess_history] = newtonRaphsonSolver(f, df, initial_guess, tolerance, maxIterations)
    % @parameter f: numeric equation with rhs = 0
    % @parameter df: derivative of the numeric equation
    % @parameter initial_guess: initial guess for root
    % @parameter tolerance: stopping factor, compared to difference between consecutive guesses
    % @parameter maxIterations: stopping factor, compared to limit iteration count
    % @return root: the final guess for the root
    % @return final_iter: the number of iterations taken to converge to that root
    % @return guess_history: the array of guesses made during each iteration

    if nargin < 5; maxIterations = 100; end
    if nargin < 4; tolerance = 1e-6; end

    guess_history = zeros(maxIterations, 1);
    guess_history(1) = initial_guess;

    for iter = 1:maxIterations
        current_guess = guess_history(iter);
        next_guess = current_guess - f(current_guess) / df(current_guess);
        guess_history(iter + 1) = next_guess;

        stopping_criteria = ...
            iter >= maxIterations || abs(next_guess - current_guess) < tolerance;
        if stopping_criteria; break; end
    end

    root = guess_history(iter + 1);
    final_iter = iter;
    guess_history = guess_history(1:iter + 1);
end