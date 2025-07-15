function calc_gui()
  f = figure('Name', 'Calculadora Azul', 'NumberTitle', 'off', ...
             'Position', [500 500 240 340], 'Color', [0.9 0.9 1]);

  input_field = uicontrol('Style', 'edit', 'Position', [20 290 200 30], ...
                          'FontSize', 14, 'BackgroundColor', 'white', 'Tag', 'input');

  result_field = uicontrol('Style', 'text', 'Position', [20 250 200 30], ...
                           'FontSize', 14, 'BackgroundColor', [0.8 0.9 1], 'Tag', 'output');

  operations = {'+', '-', '*', '/', '=', 'C'};
  x = 20;
  y = 210;

  for i = 1:length(operations)
    uicontrol('Style', 'pushbutton', 'String', operations{i}, ...
              'Position', [x y 40 30], 'FontSize', 12, ...
              'BackgroundColor', [0.3 0.5 1], ...
              'Callback', {@button_callback, operations{i}});
    x += 44;
  end

  digits = {'7','8','9','4','5','6','1','2','3','0'};
  x = 20;
  y = 170;

  for i = 1:length(digits)
    uicontrol('Style', 'pushbutton', 'String', digits{i}, ...
              'Position', [x y 40 30], 'FontSize', 12, ...
              'BackgroundColor', [0.3 0.5 1], ...
              'Callback', {@button_callback, digits{i}});
    x += 44;
    if mod(i, 3) == 0
      x = 20;
      y -= 40;
    end
  end
end

function button_callback(src, ~, val)
  input = findobj('Tag', 'input');
  output = findobj('Tag', 'output');
  str = get(input, 'String');

  switch val
    case '='
      try
        result = eval(str);
        set(output, 'String', ['= ' num2str(result)]);
      catch
        set(output, 'String', 'Erro de cálculo');
      end
    case 'C'
      set(input, 'String', '');
      set(output, 'String', '');
    otherwise
      set(input, 'String', [str val]);
  end
end

calc_gui();
