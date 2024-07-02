function nuclei_mask = detectingNuclei(imInput, num_clusters)
[x,y,z]=size(imInput);
X=reshape(double(imInput),[x*y,z]);
[idx,C]=kmeans(X,num_clusters,'Replicates',5);

    for i=1:num_clusters
        
        subplot (1,num_clusters,i), imshow(reshape(idx==i,[x,y]))
    end
    suptitle('Resultados K-means')
[a,b]=min(mean(C,2));
nuclei_mask=reshape(idx==b,[x,y]);

end