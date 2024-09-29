function Z=dynPlaneSystem(fun,N,tol,limits,roots)
% dynPlaneSystem(fun,N,tol,limits,roots) generates the final state of the
% orbit of the rational system fun, taking N^2 initial  guesses in the
% rectangle defined by limits. Convergence is set when the distance between
% the iterates and roots is lower than tol
%
% Test: fun = @(x1,x2)[x1-(x1.^2-1)/2./x1;x2-(x2.^2-1)/2./x2];
% Z=dynPlaneSystem(fun,200,1e-6,[-2 2 -2 2],[1 1 -1 -1;1 -1 1 -1])

x1=linspace(limits(1),limits(2),N);
x2=linspace(limits(3),limits(4),N);
[X1,X2]=meshgrid(x1,x2); 
Z=zeros(N); tol2=tol^2;
for fil=1:N
    for col=1:N
        iter=1;
        X=[X1(fil,col);X2(fil,col)];
        while iter<40 && all(sum((X-roots).^2)>tol2)
            X=fun(X(1),X(2));
            iter=iter+1;
        end
        Z(fil,col)=X(1)+1i*X(2);
    end
end

% Execute plotDynPlane(Z,tol,limits,roots) to generate the dynamical plane