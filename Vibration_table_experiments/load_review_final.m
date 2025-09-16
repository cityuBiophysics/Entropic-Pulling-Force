clear
load(".\review\32cm_review_m3.mat")
scale = 660/32;
edgeX = linspace(-15,15,16);
m_edgeX = edgeX(1:end-1)+(edgeX(2)-edgeX(1))/2;
dis_anchor = histcounts((yi(:,33)+yi(:,34))/2,edgeX);

E_anchor = -log(dis_anchor);
Yrefer = [yi(:,26) ; yi(:,27); yi(41); yi(40)];
dis_refer_add = histcounts(Yrefer,edgeX,'Normalization','probability');
E_refer = -log(dis_refer_add);
figure (7)
hold on
plot(m_edgeX/scale,dis_refer_add/2*scale,'o')
hold on
figure (5)
plot(m_edgeX/scale,E_anchor-min(E_anchor),'o');
hold on
% plot(m_edgeX/scale,E_refer,'o');
figure (6)
hold on
Delta_E = E_anchor-E_refer-min(E_anchor)+min(E_refer);

plot(m_edgeX,Delta_E)

a = polyfit(m_edgeX/scale,Delta_E,1);