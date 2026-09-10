import re

def main():
    pattern = r'<span[^>]*>(.*?)</span>'
    with open('videotext.html') as file:
        lines = file.readlines()
    text = ''.join(lines)
    matches = re.findall(pattern, text, flags=re.IGNORECASE | re.DOTALL)

    with open('lines.txt', 'w') as file:
        file.writelines(match.strip() + '\n' for match in matches)

if __name__ == '__main__':
    main()
