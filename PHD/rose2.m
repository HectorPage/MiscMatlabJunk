function [tout,rout] = rose2(varargin)
%ROSE   Angle histogram plot.
%   ROSE(THETA) plots the angle histogram for the angles in THETA.  
%   The angles in the vector THETA must be specified in radians.
%
%   ROSE(THETA,N) where N is a scalar, uses N equally spaced bins 
%   from 0 to 2*PI.  The default value for N is 20.
%
%   ROSE(THETA,X) where X is a vector, draws the histogram using the
%   bins specified in X. Where the values of x specify the center 
%   angle of each bin.
%
%   ROSE(AX,...) plots into AX instead of GCA.
%
%   H = ROSE(...) returns a vector of line handles.
%
%   [T,R] = ROSE(...) returns the vectors T and R such that 
%   POLAR(T,R) is the histogram.  No plot is drawn.
%
%   See also HIST, POLAR, COMPASS.

%   Clay M. Thompson 7-9-91
%   Copyright 1984-2005 The MathWorks, Inc.
%   $Revision: 5.14.4.4 $  $Date: 2005/04/28 19:56:53 $

[cax,args,nargs] = axescheck(varargin{:});
error(nargchk(1,2,nargs,'struct'));

theta = args{1};
if nargs > 1, 
  x = args{2}; 
end

if ischar(theta)
  error(id('NonNumericInput'),'Input arguments must be numeric.');
end
theta = rem(rem(theta,2*pi)+2*pi,2*pi); % Make sure 0 <= theta <= 2*pi
if nargs==1,
  x = (0:19)*pi/10+pi/20;

elseif nargs==2,
  if ischar(x)
    error(id('NonNumericInput'),'Input arguments must be numeric.');
  end
  if length(x)==1,
    x = (0:x-1)*2*pi/x + pi/x;
  else
    x = sort(rem(x(:)',2*pi));
  end

end
if ischar(x) || ischar(theta)
  error(id('NonNumericInput'),'Input arguments must be numeric.');
end

% Determine bin edges and get histogram
edges = sort(rem([(x(2:end)+x(1:end-1))/2 (x(end)+x(1)+2*pi)/2],2*pi));
edges = [edges edges(1)+2*pi];
nn = histc(rem(theta+2*pi-edges(1),2*pi),edges-edges(1));
nn(end-1) = nn(end-1)+nn(end);
nn(end) = [];

% Form radius values for histogram triangle
if min(size(nn))==1, % Vector
  nn = nn(:); 
end
[m,n] = size(nn);
mm = 4*m;
r = zeros(mm,n);
r(2:4:mm,:) = nn;
r(3:4:mm,:) = nn;

% Form theta values for histogram triangle from triangle centers (xx)
zz = edges;

t = zeros(mm,1);
t(2:4:mm) = zz(1:m);
t(3:4:mm) = zz(2:m+1);

if nargout<2
  if ~isempty(cax)
    h = polar(cax,t,r);
  else
    h = polar(t,r);
  end
  
%rlim = 500; %Set the radial limit to the number of cells in simulation.
%axis([-1 1 -1 1] * rlim); %Set the cartesian axis limits so that the radial is the correct size.

[a,b] = pol2cart(t,r);     % convert histogram line to polar coordinates
A = reshape(a,4,numel(x)); % reshape 4*N-element x vector into N columns
B = reshape(b,4,numel(x)); % reshape 4*N-element y vector into N columns
Q = patch(A,B,[0 0 1]);         % plot N patches based on the columns of A and B
alpha(Q, 0.5);

set(Q, 'LineWidth', 2.0);

htext=findall(gca, 'type', 'text');
hOBJ=(findall(htext, 'string', '  500'));   %Manually deleting all the radial axis labels
delete(hOBJ);

htext=findall(gca, 'type', 'text');
hOBJ1=(findall(htext, 'string', '  400'));
delete(hOBJ1);

htext=findall(gca, 'type', 'text');
hOBJ2=(findall(htext, 'string', '  300'));
delete(hOBJ2);

htext=findall(gca, 'type', 'text');
hOBJ3=(findall(htext, 'string', '  200'));
delete(hOBJ3);

htext=findall(gca, 'type', 'text');
hOBJ4=(findall(htext, 'string', '  100'));
delete(hOBJ4);


atext = findall(gca, 'type', 'text');
AxLabels = [0:30:330];
for idx = 1:numel(AxLabels)
    hOBJ = (findall(atext, 'string', AxLabels(idx)));
    set(hOBJ, 'FontSize', 32);
end

hlines = findall(gcf,'Type','line');
for i = 1:length(hlines)
set(hlines(i),'LineWidth',2.0);
end 




  if nargout==1, tout = h; end
  return
end

if min(size(nn))==1,
  tout = t'; rout = r';
else
  tout = t; rout = r;
end



function str=id(str)
str = ['MATLAB:rose:' str];


