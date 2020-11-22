% This is a program to calculate Pi using bouncing blocks

grid off;

b1 = Block(1, 0, 1, 1);
b2 = Block(1, -.1, 5);

collisions = 0;

for time=1:100
    if b1.velocity < 0 && b2.velocity < 0
        if abs(b2.velocity) >= abs(b1.velocity)
            break
        end
    end
    
    clf
    
    axis([0 10 0 10])
    
    update(b1, b2);
    
    if overlaps(b1, b2) || b1.pos < 10
        collisions = collisions + 1;
    end
    
    drawBlock(b1);
    drawBlock(b2);
    
    drawnow();
    
    pause(.01);
end

disp(collisions);

close(figure(1));