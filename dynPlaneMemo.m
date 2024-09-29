function Z=dynPlaneMemo(fun,N,tol,limits,roots)
% dynPlaneMemo(fun,N,tol,limits,roots) generates the final state of the 
% orbit of the rational function fun with memory, taking N^2 initial 
% guesses in the rectangle defined by limits. Convergence is set when the 
% distance between the iterates and roots is lower than tol
% 
% Test: fun = @(x)(x(:,1).*x(:,2)+)./(x(:,1)+x(:,2))
% Z=dynPlaneMemo(fun,200,1e-6,[-2 2 -2 2],[-1 1])

x=linspace(limits(1),limits(2),N);
y=linspace(limits(3),limits(4),N);
[X0,X1]=meshgrid(x,y); X0=X0(:); X1=X1(:);
nodes=true(N^2,1); 
iter=1; X2=zeros(size(X0));
while iter<40 && sum(nodes)>0
    X2(nodes)=fun([X0(nodes),X1(nodes)]);
    X2r=X2-roots;
    nodes(any(abs(X2r)<tol,2))=false;
    nodes(~isfinite(X2))=false;
    X0=X1; X1=X2;
    iter=iter+1;
end
Z=reshape(X1,N,N);
end

% Execute plotDynPlane(Z,tol,limits,roots) to generate the dynamical plane
