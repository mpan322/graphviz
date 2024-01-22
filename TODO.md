 - Write function to automatically call the dot programme to display the generated graph and open an external window from within gap.
 - Write tests for James' existing code
 - Fix any bugs found
 - Implement subgraphs in the style of James' existing code 
 - (+) Implement a display function which includes line numbers.
 - (*) Add a mode which will output the dot representation after every modification to make editing easier (not sure how feasible this is)
 - Potentially merge / minimize attribute declarations when possible 
 (not needed but may be nice)
 

 ## Bug
 - Make sure no holes related problems when generating the output string.

## Questions
- I am going to stick with the line by line modification approach which exists, however I am not sure whether this is the nicest approach given that the user cannot easily determine the line number (partially the reason why (*) and (+) are mentioned)