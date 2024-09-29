function Z=dynPlane(fun,N,tol,limits,roots) 
% dynPlane(fun,N,tol,limits,roots) generates the final state of the orbit
% of the rational function fun, taking N^2 initial guesses in the rectangle
% defined by limits. Convergence is set when the distance between the
% iterates and roots is lower than tol
% 
% Test for rational functions that satisfy the scaling theorem
% fun=@(z) z.^2; Z=dynPlane(fun,200,1e-6,[-2 2 -2 2],0)
% 
% Test for rational functions that do not satisfy the scaling theorem
% fun = @(z) (z.^3+z.^2-z+1)./(z.^2+2*z-1);
% Z=dynPlane(fun,200,1e-6,[-2 2 -2 2],[-1 1])

x=linspace(limits(1),limits(2),N);
y=linspace(limits(3),limits(4),N);
[X,Y]=meshgrid(x,y); Z=X+1i*Y; Z=Z(:);
nodes=true(1,N^2); tol2=tol^2;
iter=1;
while iter<40 && sum(nodes)>0
    Z(nodes)=fun(Z(nodes));
    aZ=(Z-roots).*conj(Z-roots);
    nodes(any(aZ<tol2,2))=false;
    nodes(~isfinite(Z))=false;
    iter=iter+1;
end
Z=reshape(Z,N,N);
end

% Execute plotDynPlane(Z,tol,limits,roots) to generate the dynamical plane