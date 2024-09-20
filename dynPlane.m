function Z=dynPlane(fun,N,tol,limits)
% Test: Z=dynPlane(@(x) x.^2,200,1e-3,[-2 2 -2 2])
x=linspace(limits(1),limits(2),N);
y=linspace(limits(3),limits(4),N);
[X,Y]=meshgrid(x,y); Z=X+1i*Y; Z=Z(:);
nodes=boolean(ones(1,N^2));
iter=1;
while and(iter<40,sum(nodes)>0)
    Z(nodes)=fun(Z(nodes));
    nodes(or(abs(Z)<tol,or(isinf(abs(Z)),isnan(abs(Z)))))=0;
    iter=iter+1;
end
Z=reshape(Z,N,N);
end
