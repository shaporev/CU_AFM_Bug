function test2
    testVar;
    if (testVar~=0)
        disp(['TestVar:', num2str(testVar)]);
        testVar=testVar+1;
    else
        disp('Initialized TestVar');
        testVar=1;
    end
end