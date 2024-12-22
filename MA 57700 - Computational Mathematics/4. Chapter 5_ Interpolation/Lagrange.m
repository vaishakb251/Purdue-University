function [coefficients, p_a] = Lagrange(x, y, a)
    % Number of data points
    n = length(x);
    
    % Initialize the polynomial coefficients
    coefficients = zeros(1, n);
    
    % Compute the Lagrange basis polynomials and the interpolating polynomial
    for i = 1:n
        % Initialize the Lagrange basis polynomial L_i(x)
        Li = ones(1, 1)
        for j = 1:n
            if i ~= j
                % Update the Lagrange basis polynomial L_i(x)
                Li = conv(Li, [1, -x(j)])/(x(i) - x(j))
            end
        end
     % Update the coefficients of the interpolating polynomial
        coefficients = coefficients + y(i)*Li;
    end
    
    % Evaluate the interpolating polynomial at a
    p_a = polyval(coefficients, a);
end