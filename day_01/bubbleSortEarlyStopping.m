function array = bubbleSortEarlyStopping(array, compareFunction) %#ok<FNDEF>
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
