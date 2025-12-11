function separateWordsOfMessageInLines(message,maxLineWidth,font)
    local appearenceInTheMessage={}
    local messageLines={{}}
    local currentLine=1
    local widthOfLine=0
    local widthOfWord,numberOfCharactersInWord,wordToBeDivided
    surface.SetFont(font)
    local widthOfSpace=surface.GetTextSize(" ")
    local widthOfHyphen=surface.GetTextSize("-")
    for word in string.gmatch(message,"%S+") do -- For each word of the message
        local widthOfWord=surface.GetTextSize(word)
        if maxLineWidth>=widthOfLine+widthOfWord then
            widthOfLine=widthOfLine+widthOfWord+widthOfSpace
            messageLines[currentLine][#messageLines[currentLine]+1]=word.." "
        elseif maxLineWidth>=widthOfWord then
            currentLine=currentLine+1
            widthOfLine=widthOfWord+widthOfSpace
            messageLines[currentLine]={word.." "}
        else
            wordToBeDivided=word
            widthOfLine=math.huge
            while maxLineWidth<widthOfLine-widthOfSpace do -- The only case we have to ignore the width of a space: when the word is so long that we need more than one line. For each of those lines, but the last one, there cannot be any spaces
                widthOfLine=0
                numberOfCharactersRemoved=1
                numberOfCharactersInWord=string.len(wordToBeDivided)
                widthOfWord=surface.GetTextSize(wordToBeDivided)
                while maxLineWidth<widthOfWord do
                    numberOfCharactersRemoved=numberOfCharactersRemoved+1
                    wordInCurrentLine=string.sub(wordToBeDivided,1,numberOfCharactersInWord-numberOfCharactersRemoved)
                    widthOfWord=surface.GetTextSize(wordInCurrentLine)+widthOfHyphen
                end
                currentLine=currentLine+1
                messageLines[currentLine]={wordInCurrentLine.."-"}
                currentLine=currentLine+1
                wordInCurrentLine=string.sub(wordToBeDivided,numberOfCharactersInWord-numberOfCharactersRemoved+1)
                widthOfLine=surface.GetTextSize(wordInCurrentLine)+widthOfSpace
                wordToBeDivided=wordInCurrentLine
            end
            messageLines[currentLine]={wordInCurrentLine.." "}
        end
    end
    return messageLines
end
function stringifyLinesAndAddSpaces(messageLines)
    local linesAsString={}
    local lineAsString,lengthOfLastWordOfMessage
    for index,line in ipairs(messageLines) do
        lineAsString=""
        for number,word in ipairs(line) do
            lineAsString=lineAsString..word
        end
        if lineAsString!="" then linesAsString[#linesAsString+1]=lineAsString end
    end
    return linesAsString
end
function separateMessageInLines(message,maxLineWidth,messageLineFont)
    local messageLines=separateWordsOfMessageInLines(message,maxLineWidth,messageLineFont)
    return stringifyLinesAndAddSpaces(messageLines)
end