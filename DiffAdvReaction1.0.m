clc; clear; close all
%%%%%%%%%% SIMULATION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = 1;
Tfinal = 100;
J = 100;

dx = L/(J + 1);
dt = 1e-3/4;

t = 1;
xx = linspace(0,L,J + 2).';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PHYSICAL PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = 1/20;
v = 1;
f = @(t,u) 0*u; %% Ingen nytt ?
r =@(c) 0; %% Ingen reaction??
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% INITIAL CONDITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=zeros(J,1); 
for i=1:J
    if ((xx(i)>=0.5)&&((xx(i)<=0.6)))
        c(i)=1;
   
    end
end
%%c = c0(xx(2:end-1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% CONSTRUCTING FINITE DIFFERENCES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = full(spdiags(bsxfun(@times,ones(J,1),[-1 0 1]),[-1 0 1],J,J))/(2*dx);

D = full(spdiags(bsxfun(@times,ones(J+2,1),[1 -2 1]),[-1 0 1],J,J))/(dx*dx);

M = d*D - v*A;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% PREPARING PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ax = axes;
p = plot(xx,[0;c;0],'.-');
p.DisplayName = "Pollutant concentration";
ax.YLimMode = 'manual';
xlabel('m')
ylabel('kg/m^3')
ylim([0 2])
title(sprintf("t = %.3e",t));
legend show
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% SOLVING THE PROBLEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while t < Tfinal
    c = c + dt*(M*c - r(c) + f(t,c));
    p.YData = [0;c;0]; %% tvingar kanterna är 0 tror inte den som fuckar
    t = t + dt;
    ax.Title.String = sprintf("t = %.3e",t);
    drawnow
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%clc; clear; close all
