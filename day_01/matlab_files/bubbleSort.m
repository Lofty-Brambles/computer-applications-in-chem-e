%% [Set 1] Question 10 - Bubble Sort (Bruteforce & Early Stopping)

% --- INPUT ---
ascendingOrderSwapCondition = @(a, b) logical(a > b);
randomArrayGenerator = @(n, lower, upper) rand(n, 1) * (upper - lower) + lower;

disp("--- INPUT ---");
disp("Random array of 6 elements between -100 and 100:");
randomArray = randomArrayGenerator(6, -100, 100);
disp(randomArray');

% --- OUTPUT: Bruteforce approach ---
orderedArrayBruteforce = bubbleSortBruteforce(randomArray, ascendingOrderSwapCondition);
disp("--- OUTPUT ---");
disp("Sorted array in ascending order [Bubble sort with bruteforce]:");
disp(orderedArrayBruteforce');

% --- OUTPUT: Early stopping approach ---
orderedArrayEarlyStopping = bubbleSortEarlyStopping(randomArray, ascendingOrderSwapCondition);
disp("--- OUTPUT ---");
disp("Sorted array in ascending order [Bubble sort with early stopping]:");
disp(orderedArrayEarlyStopping');


%% ----- Local functions (must appear after all script commands) -----

function array = bubbleSortBruteforce(array, compareFunction)
    % @parameter array: array to be sorted
    % @parameter compareFunction: function comparing to determine sorting order
    % @return array: the array, sorted in-place

    arrayLength = length(array);
    outerTotalPasses = 1;

    while outerTotalPasses < arrayLength
        position = 1;

        while position <= arrayLength - outerTotalPasses
            if compareFunction(array(position), array(position + 1))
                [array(position), array(position + 1)] = ...
                    deal(array(position + 1), array(position));
            end
            position = position + 1;
        end % inner while loop ends, one position is checked

        outerTotalPasses = outerTotalPasses + 1;
    end % outer while loop ends, one pass through the array is completed
end

function array = bubbleSortEarlyStopping(array, compareFunction)
    % @parameter array: array to be sorted
    % @parameter compareFunction: function comparing to determine sorting order
    % @return array: the array, sorted in-place

    arrayLength = length(array);
    outerTotalPasses = 1;

    while outerTotalPasses < arrayLength
        position = 1;
        wasSwapped = false;

        while position <= arrayLength - outerTotalPasses
            if compareFunction(array(position), array(position + 1))
                [array(position), array(position + 1)] = ...
                    deal(array(position + 1), array(position));
                wasSwapped = true;
            end
            position = position + 1;
        end % inner while loop ends, one position is checked

        if ~wasSwapped; break; end

        outerTotalPasses = outerTotalPasses + 1;
    end % outer while loop ends, one pass through the array is completed
end