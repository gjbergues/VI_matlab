function [fitresult, gof] = fitV(x, cv)

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, cv );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [235 15 2.55];
opts.Upper = [Inf Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
%figure( 'Name', 'untitled fit 1' );
%h = plot( fitresult, xData, yData );




