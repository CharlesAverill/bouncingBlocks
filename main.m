% This is a program to calculate Pi using bouncing blocks

grid off;
clear;

collisions = 0;

global m1
global m2
m1 = 1;
m2 = 100;

global x1
global x2
x1 = 3;
x2 = 5.1;

w1 = 2;
w2 = 3;

v1 = 0;
v2 = -.1;

collision_type = "block";

while check_speeds(v1, v2)
    clf;
    
    axis([0 10 0 10]);
    
    [x1, x2] = update_positions(v1, v2);
    
    r1 = drawBlock(x1, w1);
    r2 = drawBlock(x2, w2);
    
    if x1 + w1 >= x2
        [v1, v2] = block_collision(v1, v2);
        collisions = collisions + 1;
    elseif x1 <= 0
        [v1, v2] = wall_collision(v1, v2);
        collisions = collisions + 1;
    end
    
    drawnow();
    
    pause(.025);
end

disp(collisions);

close(figure(1));

function f = check_speeds(v1, v2)
    f = 1;    
    if v1 >= 0 && v2 >= 0
        if abs(v2) >= abs(v1)
            f = 0;
        end
    end
end

function [out_v1, out_v2] = block_collision(v1, v2)
    global m1;
    global m2;
    msum = m1 + m2;
    a11 = (m1 - m2) / msum;
    a12 = 2 * m2 / msum;
    a21 = 2 * m1 / msum;
    a22 = (m2 - m1) / msum;
    
    out_v1 = a11 * v1 + a12 * v2;
    out_v2 = a21 * v1 + a22 * v2;
end

function [out_v1, out_v2] = wall_collision(v1, v2)
    out_v1 = v1 * -1;
    out_v2 = v2;
end

function [out_x1, out_x2] = update_positions(v1, v2)
    global x1;
    global x2;
    out_x1 = x1 + v1;
    out_x2 = x2 + v2;
end

function r = drawBlock(position, width)
    r = rectangle('Position', [position, 0, width, width], 'EdgeColor', 'black', 'FaceColor', "#888888", 'LineWidth', 1);
end