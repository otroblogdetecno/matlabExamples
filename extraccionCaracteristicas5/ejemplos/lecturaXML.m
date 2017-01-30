%% Lectura de XML

%findLabel = 'Plot Tools';
%findCbk = '';

%Valores a buscar en el XML
findLabel = 'Mio';
findCbk = 'valor';


%xDoc = xmlread(fullfile(matlabroot,'toolbox','matlab','general','info.xml'));

xDoc = xmlread(fullfile('info.xml'));

allListitems = xDoc.getElementsByTagName('listitem');

for k = 0:allListitems.getLength-1
   thisListitem = allListitems.item(k);
   
   % Get the label element. In this file, each
   % listitem contains only one label.
   thisList = thisListitem.getElementsByTagName('label');
   thisElement = thisList.item(0);

   % Check whether this is the label you want.
   % The text is in the first child node.
   if strcmp(thisElement.getFirstChild.getData, findLabel)
       thisList = thisListitem.getElementsByTagName('callback');
       thisElement = thisList.item(0);
       findCbk = char(thisElement.getFirstChild.getData);
       break;
   end
   
end


if ~isempty(findCbk)
    msg = sprintf('Item "%s" has a callback of "%s."',...
                  findLabel, findCbk);
else
    msg = sprintf('Did not find the "%s" item.', findLabel);
end
disp(msg);