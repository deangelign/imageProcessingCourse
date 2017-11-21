clc;
clear;
close all;

img = imread('/home/deangeli/Desktop/sample2.jpg');
%img_g =  rgb2gray(img);
img_g = img;
img_out =  img_g;
img_out2 =  img_g;
imshow(img_g);
nrows = size(img_g,1);
ncols = size(img_g,2);
nchannels = size(img_g,3)
n = nrows*ncols;
p = zeros(3,n);
y = zeros(n,1);
a = 1;

for row=1:nrows
    for col=1:ncols
        p(1,a) = row-1;
        p(2,a) = col-1;
        p(3,a) = 1;
        a = a + 1;
    end
end

%rotation
%cx = 0;
%cy = 0;
cx = size(img_g,2)/2;
cy = size(img_g,1)/2;
tc1 = [1 0 -cx
    0 1 -cy
    0 0 1];
theta = (10/180)*pi;
tr = [cos(theta) -sin(theta) 0
      sin(theta) cos(theta) 0
      0              0       1];
tc2 = [1 0 cx
    0 1 cy
    0 0 1]; 
t1 = tc2*tr*tc1;
  
%scaling
sx = 1.0;
sy = 1.0;
t2 = [sx 0 0
      0 sy 0
      0 0  1];

%shear 
shx = 0.4;
shy = 0.8;
t3 = [1 shx 0
      shy 1 0
      0 0  1];
  
%translate
tx = -200;
ty = 0;
t4 = [1 0 tx
    0 1 ty
    0 0 1];

t = t1*t2*t3*t4;
tinv = inv(t);

p_t = tinv * p;
    

%bilinear
for channel=1:nchannels
    index = 1;
    for row=1:nrows
        for col=1:ncols
            y = p_t(1,index);
            x = p_t(2,index);
            index = index + 1;

            x_floor = floor(x);
            x_ceil = floor(x+1);
            y_floor = floor(y);
            y_ceil = floor(y+1);

             if(x_floor >= 0 && y_floor >= 0 && x_floor < ncols && y_floor < nrows)
                I11 = img_g(y_floor+1,x_floor+1,channel);
            else
                I11 = 0;
             end

             if(x_ceil >= 0 && y_floor >= 0 && x_ceil < ncols && y_floor < nrows)
                I12 = img_g(y_floor+1,x_ceil+1,channel);
            else
                I12 = 0;
             end

            if(x_floor >= 0 && y_ceil >= 0 && x_floor < ncols && y_ceil < nrows)
                I21 = img_g(y_ceil+1,x_floor+1,channel);
            else
                I21 = 0;
            end

            if(x_ceil >= 0 && y_ceil >= 0 && x_ceil < ncols && y_ceil < nrows)
                I22 = img_g(y_ceil+1,x_ceil+1,channel);
            else
                I22 = 0;
            end

            d11_floor = (x-x_floor)*I12 + (x_ceil-x)*I11;
            d12_ceil = (x-x_floor)*I22 + (x_ceil-x)*I21;
            d = (y - y_floor)*d12_ceil + (y_ceil - y)*d11_floor; 
            img_out(row,col,channel) = round(d);
        end
    end
end

%bicubic
% index = 1;
% for row=1:nrows
%     for col=1:ncols
%         y = p_t(1,index);
%         x = p_t(2,index);
%         index = index + 1;
%         
%         x_2 = floor(x);
%         x_3 = floor(x+1);
%         y_2 = floor(y);
%         y_3 = floor(y+1);
%         
%         x_1 = x_2 - 1;
%         x_4 = x_3 + 1;
%         y_1 = y_2 - 1;
%         y_4 = y_3 + 1;
%         
%         k1 = 0;
%         k2 = 0;
%         k3 = 0;
%         k4 = 0;
%         
%         img_out2(row,col) = 0;
%         
%         A = zeros(4,4);
%         vx = [1 x x*x x*x*x];
%         b = zeros(4,1);
%         
%         if(y_1 >= 0 && y_1 < nrows)
%             
%             if(x_1 >= 0 && x_1 < ncols)
%                 A(1,:) = [1 x_1 x_1*x_1 x_1*x_1*x_1];
%                 b(1) = double(img_g(y_1+1,x_1+1));
%             else
%                 continue;
%             end
%             
%             if(x_2 >= 0 && x_2 < ncols)
%                 A(2,:) = [1 x_2 x_2*x_2 x_2*x_2*x_2];
%                 b(2) = double(img_g(y_1+1,x_2+1));
%             else
%                 continue;
%             end
%             
%             if(x_3 >= 0 && x_3 < ncols)
%                 A(3,:) = [1 x_3 x_3*x_3 x_3*x_3*x_3];
%                 b(3) = double(img_g(y_1+1,x_3+1));
%             else
%                 continue
%             end
%             
%             if(x_4 >= 0 && x_4 < ncols)
%                 A(4,:) = [1 x_4 x_4*x_4 x_4*x_4*x_4];
%                 b(4) = double(img_g(y_1+1,x_4+1));
%             else
%                 continue;
%             end
%             if( nnz(~b) ~= 4) 
%                 coef1 = linsolve(A,b);
%                 k1 = vx*coef1;
%             end
%         else
%             continue;
%         end
%         
%         
%          if(y_2 >= 0 && y_2 < nrows)
%             b(1) = double(img_g(y_2+1,x_1+1));
%             b(2) = double(img_g(y_2+1,x_2+1));
%             b(3) = double(img_g(y_2+1,x_3+1));
%             b(4) = double(img_g(y_2+1,x_4+1));
%             if(nnz(~b) ~= 4)
%                 coef2 = linsolve(A,b);
%                 k2 = vx*coef2;
%             end
%         else
%             continue;
%         end
%         
%          
%          if(y_3 >= 0 && y_3 < nrows)
%             b(1) = double(img_g(y_3+1,x_1+1));
%             b(2) = double(img_g(y_3+1,x_2+1));
%             b(3) = double(img_g(y_3+1,x_3+1));
%             b(4) = double(img_g(y_3+1,x_4+1));
%             if(nnz(~b) ~= 4)
%                 coef3 = linsolve(A,b);
%                 k3 = vx*coef3;
%             end
%         else
%             continue;
%          end
%         
%          
%          if(y_4 >= 0 && y_4 < nrows)
%             b(1) = double(img_g(y_4+1,x_1+1));
%             b(2) = double(img_g(y_4+1,x_2+1));
%             b(3) = double(img_g(y_4+1,x_3+1));            
%             b(4) = double(img_g(y_4+1,x_4+1));
%             if(nnz(~b) ~= 4)
%                 coef4 = linsolve(A,b);
%                 k4 = vx*coef4;
%             end
%         else
%             continue;
%          end
%          
%          A(1,:) = [1 y_1 y_1*y_1 y_1*y_1*y_1];
%          b(1) = k1;
%          A(2,:) = [1 y_2 y_2*y_2 y_2*y_2*y_2];
%          b(2) = k2;
%          A(3,:) = [1 y_3 y_3*y_3 y_3*y_3*y_3];
%          b(3) = k3;
%          A(4,:) = [1 y_4 y_4*y_4 y_4*y_4*y_4];
%          b(4) = k4;
%          if(nnz(~b) ~= 4)
%             coef_final = linsolve(A,b);
%             value = [1 y y*y y*y*y]*coef_final;
%             if(value < 0)
%                 value = 0;
%             end
%             if(value > 255)
%                 value = 255;
%             end
%             img_out(row,col) = value;
%          end
%     end    
% end

%bicubic fast 1
% index = 1;
% for row=1:nrows
%     for col=1:ncols
%         y = p_t(1,index);
%         x = p_t(2,index);
%         index = index + 1;
%         
%         x_2 = floor(x);
%         x_3 = floor(x+1);
%         y_2 = floor(y);
%         y_3 = floor(y+1);
%         
%         x_1 = x_2 - 1;
%         x_4 = x_3 + 1;
%         y_1 = y_2 - 1;
%         y_4 = y_3 + 1;
%         
%         p00 = 0;
%         p01 = 0;
%         p02 = 0;
%         p03 = 0;
%         
%         p10 = 0; 
%         p11 = 0; 
%         p12 = 0; 
%         p13 = 0;
%         
%         p20 = 0; 
%         p21 = 0; 
%         p22 = 0; 
%         p23 = 0;
%         
%         p30 = 0; 
%         p31 = 0; 
%         p32 = 0; 
%         p33 = 0;
%         
%         if(y_1 > 0 && y_1 <= nrows)
%             if(x_1 > 0 && x_1 <= ncols)
%                 p00 = img_g(y_1, x_1);
%             end
%             if(x_2 > 0 && x_2 <= ncols)
%                 p01 = img_g(y_1, x_2);
%             end
%             if(x_3 > 0 && x_3 <= ncols)
%                 p02 = img_g(y_1, x_3);
%             end
%             if(x_4 > 0 && x_4 <= ncols)
%                 p03 = img_g(y_1, x_4);
%             end
%         end
%         
%        if(y_2 > 0 && y_2 <= nrows)
%             if(x_1 > 0 && x_1 <= ncols)
%                 p10 = img_g(y_2, x_1);
%             end
%             if(x_2 > 0 && x_2 <= ncols)
%                 p11 = img_g(y_2, x_2);
%             end
%             if(x_3 > 0 && x_3 <= ncols)
%                 p12 = img_g(y_2, x_3);
%             end
%             if(x_4 > 0 && x_4 <= ncols)
%                 p13 = img_g(y_2, x_4);
%             end
%        end
%         
%        if(y_3 > 0 && y_3 <= nrows)
%             if(x_1 > 0 && x_1 <= ncols)
%                 p20 = img_g(y_3, x_1);
%             end
%             if(x_2 > 0 && x_2 <= ncols)
%                 p21 = img_g(y_3, x_2);
%             end
%             if(x_3 > 0 && x_3 <= ncols)
%                 p22 = img_g(y_3, x_3);
%             end
%             if(x_4 > 0 && x_4 <= ncols)
%                 p23 = img_g(y_3, x_4);
%             end
%        end
%         
%        if(y_4 > 0 && y_4 <= nrows)
%             if(x_1 > 0 && x_1 <= ncols)
%                 p30 = img_g(y_4, x_1);
%             end
%             if(x_2 > 0 && x_2 <= ncols)
%                 p31 = img_g(y_4, x_2);
%             end
%             if(x_3 > 0 && x_3 <= ncols)
%                 p32 = img_g(y_4, x_3);
%             end
%             if(x_4 > 0 && x_4 <= ncols)
%                 p33 = img_g(y_4, x_4);
%             end
%         end
% 
%         a00 = p11;
%         a01 = -.5*p10 + .5*p12;
%         a02 = p10 - 2.5*p11 + 2*p12 - .5*p13;
% 		a03 = -.5*p10 + 1.5*p11 - 1.5*p12 + .5*p13;
% 		a10 = -.5*p01 + .5*p21;
% 		a11 = .25*p00 - .25*p02 - .25*p20 + .25*p22;
% 		a12 = -.5*p00 + 1.25*p01 - p02 + .25*p03 + .5*p20 - 1.25*p21 + p22 - .25*p23;
% 		a13 = .25*p00 - .75*p01 + .75*p02 - .25*p03 - .25*p20 + .75*p21 - .75*p22 + .25*p23;
% 		a20 = p01 - 2.5*p11 + 2*p21 - .5*p31;
% 		a21 = -.5*p00 + .5*p02 + 1.25*p10 - 1.25*p12 - p20 + p22 + .25*p30 - .25*p32;
% 		a22 = p00 - 2.5*p01 + 2*p02 - .5*p03 - 2.5*p10 + 6.25*p11 - 5*p12 + 1.25*p13 + 2*p20 - 5*p21 + 4*p22 - p23 - .5*p30 + 1.25*p31 - p32 + .25*p33;
% 		a23 = -.5*p00 + 1.5*p01 - 1.5*p02 + .5*p03 + 1.25*p10 - 3.75*p11 + 3.75*p12 - 1.25*p13 - p20 + 3*p21 - 3*p22 + p23 + .25*p30 - .75*p31 + .75*p32 - .25*p33;
% 		a30 = -.5*p01 + 1.5*p11 - 1.5*p21 + .5*p31;
% 		a31 = .25*p00 - .25*p02 - .75*p10 + .75*p12 + .75*p20 - .75*p22 - .25*p30 + .25*p32;
% 		a32 = -.5*p00 + 1.25*p01 - p02 + .25*p03 + 1.5*p10 - 3.75*p11 + 3*p12 - .75*p13 - 1.5*p20 + 3.75*p21 - 3*p22 + .75*p23 + .5*p30 - 1.25*p31 + p32 - .25*p33;
% 		a33 = .25*p00 - .75*p01 + .75*p02 - .25*p03 - .75*p10 + 2.25*p11 - 2.25*p12 + .75*p13 + .75*p20 - 2.25*p21 + 2.25*p22 - .75*p23 - .25*p30 + .75*p31 - .75*p32 + .25*p33;
%     
%         x2 = x*x;
%         x3 = x2*x;
%         
%         y2 = y*y;
%         y3 = y2*y;
%         
%         value = (a00 + a01*y + a02*y2 + a03*y3) + ...
%                 ((a10 + a11*y + a12*y2 + a13*y3)*x) + ...
%                 ((a20 + a21*y + a22*y2 + a23*y3)*x2) + ...
%                 ((a30 + a31*y + a32*y2 + a33*y3)*x3);
%         img_out2(row,col) = value;
%         
%     end
% end

%bicubic  fast 2
for channel=1:nchannels
    index = 1;
    for row=1:nrows
        for col=1:ncols
            y = p_t(1,index);
            x = p_t(2,index);
            x_corrected = x-floor(x);
            y_corrected = y-floor(y);
            index = index + 1;

            x_2 = floor(x);
            x_3 = floor(x+1);
            y_2 = floor(y);
            y_3 = floor(y+1);

            x_1 = x_2 - 1;
            x_4 = x_3 + 1;
            y_1 = y_2 - 1;
            y_4 = y_3 + 1;

            k1 = 0;
            k2 = 0;
            k3 = 0;
            k4 = 0;
            
            img_out2(row,col,channel) = 0;

            if(y_1 >= 0 && y_1 < nrows)
                f1 = 0;
                f2 = 0;
                f3 = 0;
                f4 = 0;
                if(x_1 >= 0 && x_1 < ncols)
                    f1 = double(img_g(y_1+1,x_1+1,channel));
                end

                if(x_2 >= 0 && x_2 < ncols)
                    f2 = double(img_g(y_1+1,x_2+1,channel));
                end


                if(x_3 >= 0 && x_3 < ncols)
                    f3 = double(img_g(y_1+1,x_3+1,channel));
                end

                if(x_4 >= 0 && x_4 < ncols)
                    f4 = double(img_g(y_1+1,x_4+1,channel));
                end

                a = (-0.5*f1) + (1.5*f2) + (-1.5*f3) + (0.5*f4);
                b = (f1) - (2.5*f2) + (2*f3) - (0.5*f4);
                c = (-0.5 * f1) + (0.5*f3);
                d = f2;
                value = d;
                var = x;
                value = value + c*x_corrected;
                var = var*x;
                value = value + b*x_corrected*x_corrected;
                var = var*x;
                value = value + a*x_corrected*x_corrected*x_corrected;
                k1 = value;
            else
                continue
            end

            if(y_2 >= 0 && y_2 < nrows)
                f1 = 0;
                f2 = 0;
                f3 = 0;
                f4 = 0;
                if(x_1 >= 0 && x_1 < ncols)
                    f1 = double(img_g(y_2+1,x_1+1,channel));
                end

                if(x_2 >= 0 && x_2 < ncols)
                    f2 = double(img_g(y_2+1,x_2+1,channel));
                end


                if(x_3 >= 0 && x_3 < ncols)
                    f3 = double(img_g(y_2+1,x_3+1,channel));
                end

                if(x_4 >= 0 && x_4 < ncols)
                    f4 = double(img_g(y_2+1,x_4+1,channel));
                end

                a = (-0.5*f1) + (1.5*f2) + (-1.5*f3) + (0.5*f4);
                b = (f1) - (2.5*f2) + (2*f3) - (0.5*f4);
                c = (-0.5 * f1) + (0.5*f3);
                d = f2;
                value = d;
                var = x;
                value = value + c*x_corrected;
                var = var*x;
                value = value + b*x_corrected*x_corrected;
                var = var*x;
                value = value + a*x_corrected*x_corrected*x_corrected;
                k2 = value;
            else
                continue
            end

            if(y_3 >= 0 && y_3 < nrows)
                f1 = 0;
                f2 = 0;
                f3 = 0;
                f4 = 0;
                if(x_1 >= 0 && x_1 < ncols)
                    f1 = double(img_g(y_3+1,x_1+1,channel));
                end

                if(x_2 >= 0 && x_2 < ncols)
                    f2 = double(img_g(y_3+1,x_2+1,channel));
                end


                if(x_3 >= 0 && x_3 < ncols)
                    f3 = double(img_g(y_3+1,x_3+1,channel));
                end

                if(x_4 >= 0 && x_4 < ncols)
                    f4 = double(img_g(y_3+1,x_4+1,channel));
                end
                

                a = (-0.5*f1) + (1.5*f2) + (-1.5*f3) + (0.5*f4);
                b = (f1) - (2.5*f2) + (2*f3) - (0.5*f4);
                c = (-0.5 * f1) + (0.5*f3);
                d = f2;
                value = d;
                var = x;
                value = value + c*x_corrected;
                var = var*x;
                value = value + b*x_corrected*x_corrected;
                var = var*x;
                value = value + a*x_corrected*x_corrected*x_corrected;
                k3 = value;
            else
                continue
            end

            if(y_4 >= 0 && y_4 < nrows)
                f1 = 0;
                f2 = 0;
                f3 = 0;
                f4 = 0;
                if(x_1 >= 0 && x_1 < ncols)
                    f1 = double(img_g(y_4+1,x_1+1,channel));
                end

                if(x_2 >= 0 && x_2 < ncols)
                    f2 = double(img_g(y_4+1,x_2+1,channel));
                end


                if(x_3 >= 0 && x_3 < ncols)
                    f3 = double(img_g(y_4+1,x_3+1,channel));
                end

                if(x_4 >= 0 && x_4 < ncols)
                    f4 = double(img_g(y_4+1,x_4+1,channel));
                end
                
                a = (-0.5*f1) + (1.5*f2) + (-1.5*f3) + (0.5*f4);
                b = (f1) - (2.5*f2) + (2*f3) - (0.5*f4);
                c = (-0.5 * f1) + (0.5*f3);
                d = f2;
                value = d;
                var = x;
                value = value + c*x_corrected;
                var = var*x;
                value = value + b*x_corrected*x_corrected;
                var = var*x;
                value = value + a*x_corrected*x_corrected*x_corrected;
                k4 = value;
            else 
                continue
            end


            a = (-0.5*k1) + (1.5*k2) + (-1.5*k3) + (0.5*k4);
            b = (k1) - (2.5*k2) + (2*k3) - (0.5*k4);
            c = (-0.5 * k1) + (0.5*k3);
            d = k2;

            value = d;
            var = y;
            value = value + c*y_corrected;
            var = var*y;
            value = value + b*y_corrected*y_corrected;
            var = var*y;
            value = value + a*y_corrected*y_corrected*y_corrected;
            if(value < 0)
                value = 0;
            end
            if(value > 255)
                value = value;
            end
            img_out2(row,col,channel) = value;

        end
    end
end
figure(1)
imshow(img_g)

figure(2)
imshow(img_out)

figure(3)
imshow(img_out2)