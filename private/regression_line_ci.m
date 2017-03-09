function [top_int, bot_int,X] = regression_line_ci(alpha,x,y,col,w)
%[TOP_INT, BOT_INT] = REGRESSION_LINE_CI(ALPHA,BETA,X,Y,COLOR,WIDTH)
%creates two curves marking the 1 - ALPHA confidence interval for the
%regression line, given BETA coefficience (BETA(1) = intercept, BETA(2) =
%slope). This is the format of STATS.beta when using
%STATS = REGSTATS(Y,X,'linear','beta');
%[TOP_INT, BOT_INT] = REGRESSION_LINE_CI(ALPHA,BETA,X,Y,N_PTS) defines the
%number of points at which the funnel plot is defined. Default = 100
%[TOP_INT, BOT_INT] = REGRESSION_LINE_CI(ALPHA,BETA,X,Y,N_PTS,XMIN,XMAX)
%defines the range of x values over which the funnel plot is defined

STATS = regstats(y,x,'linear','beta');
beta=STATS.beta;

N = length(x);
x_min = min(x);
x_max = max(x);
n_pts = 100;

X = x_min:(x_max-x_min)/n_pts:x_max;
Y = ones(size(X))*beta(1) + beta(2)*X;

SE_y_cond_x = sum((y - beta(1)*ones(size(y))-beta(2)*x).^2)/(N-2);
SSX = (N-1)*var(x);
SE_Y = SE_y_cond_x*(ones(size(X))*(1/N + (mean(x)^2)/SSX) + (X.^2 - 2*mean(x)*X)/SSX);

Yoff = (2*finv(1-alpha,2,N-2)*SE_Y).^0.5;


% SE_b0 = SE_y_cond_x*sum(x.^2)/(N*SSX)
% sqrt(SE_b0)

top_int = Y + Yoff;
bot_int = Y - Yoff;
hold on
l1=plot(X,Y,'LineWidth',w,'Color',(col));
l2=plot(X,top_int,'-','LineWidth',w/2,'Color',(col));
l3=plot(X,bot_int,'-','LineWidth',w/2,'Color',(col));
set(l1,'UserData','regressionLine');
set(l2,'UserData','regressionCI');
set(l3,'UserData','regressionCI');
end