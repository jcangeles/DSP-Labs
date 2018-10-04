% AUTHORS: JUAN ANGELES & MOSES MARTINEZ
% lab2.m
% Please place lab2.m in your working directory 
% Provide the print-out from running this function
% using 'publish lab2'
%
% T. Holton 10 Sept 08


%%
% Questions:
% Q: Why do we have to pad these sequences with zeros?
% A: We pad the sequences to be multiplied correct part of the sequence
%   as h travels through x.
% 
% Q: In heneral, how does the number of sequeces we have to sum and the
%	length of these sequences on the sizes of x[n] and h[n]?
% A: If made efficient, the number of sequences we have to sum is the sum
%	of the lengths minus 1. The length of the sequences would depend on
%	whichever is shorter, x or l.
%
% Q: Why the difference?
% A: If x[n] and h[n] vary in length, the algorithm can be made more
%   efficient if the shorter sequence is chosen as x[n]*h[n], due to the 
%   less number of sequence additions in the end.
%
% Q: Why the difference?
% A: Depending base on whether we convolve the input with the impulse or 
%   the impulse with the input we will obtain different rows in the Matrix 
%   but same columns.
% 
% Q: In general, how do the number of rows and columns of the matrix depend 
%   on the lengths of the sequences x[n] and h[n]?
% A: The number of columns is always the length of x[n] plus the length of 
%   h[n] minus one. The number of rows depends on which sequence we decided 
%   to convolve. 
% 
% Q: When is it more advantageous to compute x[n]*h[n] and when is it 
%   better to compute h[n]*x[n]?
% A: The advantage all depends on which sequence has the shorter length. 
%   This will give us a smaller Matrix to multiply. 
%%

test_lab2;

%% Convolution, Part I
% Convolution #1
x = sequence([1 2 6 -3 5], 1);
h = sequence([4 -1 5 3 2], -3);
test_lab2(x, h);

% Convolution #2
test_lab2(h, x);

% Convolution #3
h = sequence(1, 0);
test_lab2(x, h);

% Convolution #4
test_lab2(h, x);

% Convolution #5
x = sequence(cos(2 * pi * (1:50000) / 16), -5); % nice, big sequence
h = sequence(ones(1, 10), 10);
test_lab2(x, h);

% Convolution #6
test_lab2(h, x);

% Convolution #7
x = sequence(1, 2);
h = sequence(1, -1);
test_lab2(x, h);

% Convolution #8
test_lab2(h, x);

%% Real-time Convolution
% Real-time convolution #1
x = [1 4 2 6 5];
h = [4 -1 3 -5 2];
test_lab2a;
test_lab2a(x, h);

% Real-time convolution convolution #2
test_lab2a(h, x);

% Real-time convolution #3
x = cos(2 * pi * (1:50000) / 16); % nice, big sequence
h = ones(1, 10);
test_lab2a(x, h);

%% Deconvolution
% Deconvolution #1
h = sequence([1 3 2], 2);
y = sequence([1 6 15 20 15 7 2], -1);
test_lab2b;
test_lab2b(y, h);

% Deconvolution #1
y = sequence([-1 -2 0 0 0 0 1 2], 2);
test_lab2b(y, h);

%% Code
disp('---------------------------------------------------')
disp('                     Code')
disp('---------------------------------------------------')
type sequence
type conv_rt
