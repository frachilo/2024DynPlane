function plotDynPlane(Z,tol,limits,roots)
% plotDynPlane(Z,tol,limits,roots) represents the basins of attraction
% after the execution of dynPlane
if roots==0 % Roots 0 and Inf
    M(:,1)=abs(Z(:))<tol; 
    M(:,2)=or(isnan(abs(Z(:))),isinf(abs(Z(:))));
    LR=2;
else 
    if and(ismatrix(roots),~isvector(roots))
        roots=roots(:); roots=roots(1:2:end)+1i*roots(2:2:end); 
        roots=roots.';
    end
        M=double(abs(Z(:)-roots)<tol);
    LR=length(roots);
end

N=length(Z); 
RGB=[249 145 6;6 110 249;6 249 23;249 6 232]/255; RGB(LR+1:end,:)=[];
R=sum(M.*repmat(RGB(:,1).',N^2,1),2);
G=sum(M.*repmat(RGB(:,2).',N^2,1),2);
B=sum(M.*repmat(RGB(:,3).',N^2,1),2);
I=cat(3,reshape(R,N,N),reshape(G,N,N),reshape(B,N,N));
x=linspace(limits(1),limits(2),N);
y=linspace(limits(3),limits(4),N);

figure, imshow(I,'XData',double(x),'YData',double(y)), axis on, axis xy
hold on
grid
xlabel('Re\{z_0\}'), ylabel('Im\{z_0\}')