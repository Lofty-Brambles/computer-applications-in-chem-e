function [Cs, ts] = rk4(f, C_0, times) %#ok<FNDEF>
    % @parameter f: function for RK-4 to solve
    % @parameter C_0: initial condition
    % @parameter times: time range and step size

    % @return Cs: array of solution values
    % @return ts: array of time points

    step = times(3);
    ts = (times(1):step:times(2))';
    Cs = zeros(length(ts), 1);
    Cs(1) = C_0;

    for i = 1:length(ts)-1
        k1 = f(Cs(i));
        k2 = f(Cs(i) + 0.5 * step * k1);
        k3 = f(Cs(i) + 0.5 * step * k2);
        k4 = f(Cs(i) + step * k3);

        Cs(i+1) = Cs(i) + (step / 6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end