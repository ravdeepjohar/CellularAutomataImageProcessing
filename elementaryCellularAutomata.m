function pattern = elementaryCellularAutomata(rule, n, width, randfrac)

error(nargchk(2, 4, nargin));
validateattributes(rule, {'numeric'}, {'scalar' 'integer' 'nonnegative' '<=' 255}, ...
    'elementaryCellularAutomata', 'RULE');
validateattributes(n, {'numeric'}, {'scalar' 'integer' 'positive'}, ...
    'elementaryCellularAutomata', 'N');
if nargin < 3 || isempty(width)
    width = 2*n-1;
elseif isscalar(width)
    validateattributes(width, {'numeric'}, {'integer' 'positive'}, ...
        'elementaryCellularAutomata', 'WIDTH');
else
    validateattributes(width, {'numeric' 'logical'}, {'binary' 'row'}, ...
        'elementaryCellularAutomata', 'START');
end
if nargin < 4 || isempty(randfrac)
    dorand = false;
else
    validateattributes(randfrac, {'double' 'single'}, {'scalar' 'nonnegative' '<=' 1}, ...
        'elementaryCellularAutomata', 'FNOISE');
    dorand = true;
end

% set up machine
if isscalar(width)
    patt = ones(1, width);
    patt(floor((width+1)/2)) = 2;
else
    patt = width + 1;  % change 0,1 to 1,2 so can use sub2ind
    width = length(patt);
end

% unpack rule
rulearr = (bitget(rule, 1:8) + 1);

% initialise output array
pattern = zeros(n, width);

% iterate to generate rest of pattern
for i = 1:n
    pattern(i, :) = patt;   % record current state in output array
    
    % core step: apply CA rules to propagate to next 1D pattern
    ind = sub2ind([2 2 2], ...
        [patt(2:end) patt(1)], patt, [patt(end) patt(1:end-1)]);
    patt = rulearr(ind);
    
    %optional randomisation
    if dorand
        flip = rand(1, width) < randfrac;
        patt(flip) = 3 - patt(flip);
    end
end

% change symbols from 1 and 2 to 0 and 1
pattern = pattern-1;
end
