function [Cs, ts, convergence_iters] = crank_nicolson(f, C_0, times, epsilon, k_max) %#ok<FNDEF>
    % @parameter f: function for Crank-Nicolson
    % @parameter C_0: initial condition
    % @parameter times: time range and step size
    % @parameter epsilon: tolerance for Newton-Raphson
    % @parameter k_max: maximum iterations for Newton-Raphson

    % @return Cs: array of solution values
    % @return ts: array of time points
    % @return convergence_iters: array of iterations taken for convergence

    step = times(3);
    ts = (times(1):step:times(2))';
    Cs = zeros(length(ts), 1);
    convergence_iters = zeros(length(ts), 1);
    Cs(1) = C_0;
    k_2 = 0.02; V_by_F = 5; C_i_new = 30;

    for i = 1:length(ts)-1
        g = @(C) k_2 * C^2 + (1 / V_by_F + 2 / step) * C ...
            - (2 / step * Cs(i) + 1 / V_by_F * C_i_new + f(Cs(i)));
        dg = @(C) 2 * k_2 * C + (1 / V_by_F + 2 / step);

        [C_new, converged, guess_history] = newtonraphson(g, dg, Cs(i), epsilon, k_max);
        if ~converged
            error("Newton-Raphson did not converge at t = %.2f", ts(i));
        end

        Cs(i+1) = C_new;
        convergence_iters(i+1) = length(guess_history);
    end
end