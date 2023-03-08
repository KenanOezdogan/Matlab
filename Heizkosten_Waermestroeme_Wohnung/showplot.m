function [h] = showplot(handle,Array,titel,xtext,ytext)
    figure(handle)
    grid off
    legend([])
    title([])
    cla
    semilogx(Array);
    hold on
    title(titel)
    ylabel(ytext)
    xlabel(xtext)
    set(gca,'fontsize',10)
    set(gca,'fontsize',10)
    legend(titel)
    grid minor
end