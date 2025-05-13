import sys
from antlr4 import FileStream, CommonTokenStream
from MyLexer import MyLexer

# Ensure a filename is provided
if len(sys.argv) < 2:
    print("Usage: python test_lexer.py <input_file>")
    sys.exit(1)

# Read the specified input file
input_filename = sys.argv[1]
input_stream = FileStream(input_filename, encoding="utf-8")

# Initialize lexer and token stream
lexer = MyLexer(input_stream)
token_stream = CommonTokenStream(lexer)
token_stream.fill()

# Define invalid token categories based on lexer rules
INVALID_TOKENS = {
    "INVALID_INTEGER_LITERAL", 
    "INVALID_DOUBLE_LITERAL", 
    "INVALID_IDENTIFIER", 
    "ERROR"
}

# Open output file for writing
output_filename = input_filename.replace('.txt', '_output.txt')
with open(output_filename, 'w') as output_file:
    # Iterate through tokens and print in the format <token, token_category> --- VALID/INVALID
    for token in token_stream.tokens:
        if token.type == -1:  # EOF token
            break
            
        token_text = token.text
        token_category = lexer.symbolicNames[token.type] if token.type > 0 else "UNKNOWN"

        # Mark as INVALID if it belongs to the invalid category
        validity = "INVALID" if token_category in INVALID_TOKENS else "VALID"

        # Format the output
        output_line = f"<{token_text}, {token_category}> --- {validity}"
        
        # Print to console and write to file
        print(output_line)
        output_file.write(output_line + '\n')

print(f"\nTokenization complete. Results saved to {output_filename}")