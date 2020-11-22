classdef Block < handle
    properties
        mass {mustBeNumeric}
        velocity {mustBeNumeric}
        pos {mustBeNumeric}
        width {mustBeNumeric}
    end
    methods
        function self = Block(varargin)
            self.mass = abs(varargin{1});
            self.velocity = varargin{2};
            self.pos = varargin{3};
            if nargin > 3
                self.width = varargin{4};
            else
                if self.mass > 1
                    self.width = log(self.mass);
                else
                    self.width = 1;
                end
            end
        end
        
        function update(a, b)
            a.pos = a.pos + a.velocity;
            b.pos = b.pos + b.velocity;
            bounce(a, b);
        end
        
        function bounce(a, b)
            if a.pos < 0
                a.velocity = a.velocity * -1;
            end
            if overlaps(a, b)
                mass_sum = a.mass + b.mass;
                a11 = (a.mass - b.mass) / mass_sum;
                a12 = 2 * b.mass / mass_sum;
                a21 = 2 * a.mass / mass_sum;
                a22 = (b.mass - a.mass) / mass_sum;
                
                a.velocity = a.velocity * a11 + b.velocity * a22;
                b.velocity = a.velocity * a21 + b.velocity * a22;
            end
        end
        
        function f = overlaps(a, b)
            f = a.pos <= b.pos + b.width && a.pos + a.width >= b.pos;
        end
        
        function r = drawBlock(block)
            r = rectangle('Position', [block.pos, 0, block.width, block.width], 'EdgeColor', 'black', 'FaceColor', "#888888", 'LineWidth', 1);
        end
    end
end
