% Juan Angeles Acuna and Moses Martinez

classdef sequence
	properties
		data
		offset
	end
	
	methods
		function s = sequence(data, offset)
			s.data = data;
			s.offset = offset;
		end
		
		function display(s)
			var = inputname(1);
			if (isempty(var))
				disp('ans =');
			else
				disp([var '=']);
			end
			switch length(s.data)
				case 0
					disp('    data: []')
				case 1
					disp(['    data: ', num2str(s.data)])
				otherwise
					disp(['    data: [' num2str(s.data) ']'])
			end
			disp(['  offset: ' num2str(s.offset)])
		end
		
		function y = flip(x)
            Lin = length(x.data) + x.offset -1;
            data = fliplr(x.data);
            offset = -Lin;
            y = sequence(data, offset);
        end
		
		function y = shift(x, n0)
            offset = x.offset + n0;
            y = sequence(x.data, offset);
        end
        
        function [xdata, ydata] = seqData(x, y)
            Lx = length(x.data);
            Ly = length(y.data);
            ody= y.offset - x.offset;
            odx= x.offset - y.offset;
            xdata = [zeros(1, odx) x.data zeros(1, ody - (Lx - Ly))];
            ydata = [zeros(1, ody) y.data zeros(1, odx - (Ly - Lx))];
        end
        
        function z = sequenceTrimmer(x)
            while(x.data(1) == 0)
                x.data(1) = [];
                x.offset = x.offset + 1;
            end;

            while(x.data(end) == 0)
                x.data(end) = [];
            end;
            z = sequence(x.data, x.offset);
        end
        
		function z = plus(x, y)
            if((isa(x,'sequence')) && (isa(y,'sequence')))
                [x.data, y.data] = seqData(x,y);
                z_data = x.data + y.data;
                z_offset = min(x.offset, y.offset);
            else
                if(isa(x,'sequence'))
                    z_data = x.data + y;
                    z_offset= x.offset; 
                elseif(isa(y,'sequence')) 
                    z_data = y.data + x;
                    z_offset=y.offset; 
                end
            end
            z = sequenceTrimmer(sequence(z_data, z_offset));
        end
        
		function z = minus(x, y)
            if((isa(x,'sequence')) && (isa(y,'sequence')))
                [x.data, y.data] = seqData(x,y);
                z_data = x.data - y.data;
                z_offset = min(x.offset, y.offset);
            else
                if(isa(x,'sequence'))
                    z_data = x.data - y;
                    z_offset= x.offset; 
                elseif(isa(y,'sequence'))
                    z_data = x - y.data;
                    z_offset=y.offset;
                end
            end
            z = sequenceTrimmer(sequence(z_data, z_offset));
        end
		
		function z = times(x, y)
            if((isa(x,'sequence')) && (isa(y,'sequence')))
                [x.data, y.data] = seqData(x,y);
                z_data = x.data .* y.data;
                z_offset = min(x.offset, y.offset);
            else
                if(isa(x,'sequence'))
                    z_data = x.data * y;
                    z_offset= x.offset; 
                elseif(isa(y,'sequence'))
                    z_data = x * y.data;
                    z_offset=y.offset; 
                end
            end
            z = sequenceTrimmer(sequence(z_data, z_offset));
        end
		
		function stem(x)
            Lin = length(x.data) + x.offset -1;
            stem((x.offset:Lin), x.data);
        end
        
        function y = conv(x, h)
            Lx = length(x.data);
            Lh = length(h.data);            
            
            if(Lx == min(Lx, Lh))
                s = x.data;
                b = h.data;
            else
                s = h.data;
                b = x.data;
            end
            
            Ls = length(s);
            Lb = length(b);
            numRow = Ls;
            numCol = Lb+Ls-1;
            h_matrix = zeros(numRow, numCol);
            for i = 1:1:numRow
                h_matrix(i,:) = [zeros(1,i-1) b zeros(1, numCol-Lb-i+1)];
            end
            
            y.data = s*h_matrix;
            y.offset = x.offset + h.offset;
            y = sequence(y.data, y.offset);
        end
        
        
        
      function x = deconv(y, h)
          Ly = length(y.data);
          Lh = length(h.data);
          Lx = Ly - Lh + 1;
          
          x_matrix = zeros(Lx,Lx);
          if(Lx < Lh)
              x_matrix = toeplitz([h.data(1:Lx)]);
          else
              x_matrix = toeplitz([h.data zeros(1, Lx-Lh)]); 
          end 
          y_matrix = 1*Lx;
          y_matrix = y.data(1:Lx);
          
          for i = 1:1:Lx
              x_matrix(i,1:i-1) = 0 ;
          end 
          x_matrix = inv(x_matrix);
          x.data = y_matrix * x_matrix;
          x.offset = y.offset - h.offset;
          x = sequence(x.data,x.offset);
        end
	end
end