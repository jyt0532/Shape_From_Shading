function  height_map = get_surface(surface_normals, image_size, method)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object  h*w

    TIMES = 100;
%% <<< fill in your code below >>>
    height_map = zeros(192,168);
    fx = zeros(192,168);
    fy = zeros(192,168);
    
    fx = squeeze(surface_normals(:,:,1)./surface_normals(:,:,3));
    fy = squeeze(surface_normals(:,:,2)./surface_normals(:,:,3));
    switch method
        case 'column'     
            cum_fx = cumsum(fx, 2);
            cum_fy = cumsum(fy, 1);
            height_map = cum_fx + repmat(cum_fy(:,1), 1, 168);
        case 'row'
            cum_fx = cumsum(fx, 2);
            cum_fy = cumsum(fy, 1);
            height_map = cum_fy + repmat(cum_fx(1,:), 192, 1);
        case 'average'
            cum_fx = cumsum(fx, 2);
            cum_fy = cumsum(fy, 1);
            height_map = cum_fx + repmat(cum_fy(:,1), 1, 168) + cum_fy + repmat(cum_fx(1,:), 192, 1);
            height_map = height_map/2;
        case 'random'
            for times = 1:TIMES
                for i = 1:192
                    for j = 1:168
                        k = 1;
                        l = 1;
                        while k <= i && l <=j 
                            if mod(round(10*rand()), 2) == 0 %right
                                height_map(i, j) = height_map(i, j) + fx(k, l);
                                l = l + 1;
                            else %down
                                height_map(i, j) = height_map(i, j) + fy(k, l);
                                k = k + 1;
                            end
                        end
                        while k<=i
                            height_map(i, j) = height_map(i, j) + fy(k, l-1);
                            k = k + 1;
                        end
                        while l<=j
                            height_map(i, j) = height_map(i, j) + fx(k-1, l);
                            l = l + 1;
                        end
                    end
                end
            end
            height_map = height_map/TIMES;
        case 'random_from_middle'
            for times = 1:TIMES
                for i = 1:96
                    for j = 1:84
                        k = 96;
                        l = 84;
                        while k >= i && l >= j 
                            if mod(round(10*rand()), 2) == 0 %left
                                height_map(i, j) = height_map(i, j) - fx(k, l);
                                l = l - 1;
                            else %top
                                height_map(i, j) = height_map(i, j) - fy(k, l);
                                k = k - 1;
                            end
                        end
                        while k>=i
                            height_map(i, j) = height_map(i, j) - fy(k, l+1);
                            k = k - 1;
                        end
                        while l>=j
                            height_map(i, j) = height_map(i, j) - fx(k+1, l);
                            l = l - 1;
                        end
                    end
                end
                for i = 1:96
                    for j = 85:168
                        k = 96;
                        l = 84;
                        while k >= i && l <=j 
                            if mod(round(10*rand()), 2) == 0 
                                height_map(i, j) = height_map(i, j) + fx(k, l);
                                l = l + 1;
                            else 
                                height_map(i, j) = height_map(i, j) - fy(k, l);
                                k = k - 1;
                            end
                        end
                        while k>=i
                            height_map(i, j) = height_map(i, j) - fy(k, l-1);
                            k = k - 1;
                        end
                        while l<=j
                            height_map(i, j) = height_map(i, j) + fx(k+1, l);
                            l = l + 1;
                        end
                    end
                end
                for i = 97:192
                    for j = 1:84
                        k = 96;
                        l = 84;
                        while k <= i && l >=j 
                            if mod(round(10*rand()), 2) == 0 %right
                                height_map(i, j) = height_map(i, j) - fx(k, l);
                                l = l - 1;
                            else %down
                                height_map(i, j) = height_map(i, j) + fy(k, l);
                                k = k + 1;
                            end
                        end
                        while k<=i
                            height_map(i, j) = height_map(i, j) + fy(k, l+1);
                            k = k + 1;
                        end
                        while l>=j
                            height_map(i, j) = height_map(i, j) - fx(k-1, l);
                            l = l - 1;
                        end
                    end
                end
                for i = 97:192
                    for j = 85:168
                        k = 96;
                        l = 84;
                        while k <= i && l <=j 
                            if mod(round(10*rand()), 2) == 0 %right
                                height_map(i, j) = height_map(i, j) + fx(k, l);
                                l = l + 1;
                            else %down
                                height_map(i, j) = height_map(i, j) + fy(k, l);
                                k = k + 1;
                            end
                        end
                        while k<=i
                            height_map(i, j) = height_map(i, j) + fy(k, l-1);
                            k = k + 1;
                        end
                        while l<=j
                            height_map(i, j) = height_map(i, j) + fx(k-1, l);
                            l = l + 1;
                        end
                    end
                end
            end
            height_map = height_map/TIMES;
    end

end

