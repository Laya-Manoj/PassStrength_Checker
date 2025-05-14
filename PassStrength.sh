#!/bin/bash

# Read password input silently
read -sp "Enter a password to check strength: " password
echo

# Define the rules
has_uppercase=$(echo "$password" | grep -q '[A-Z]' && echo yes || echo no)
has_lowercase=$(echo "$password" | grep -q '[a-z]' && echo yes || echo no)
has_number=$(echo "$password" | grep -q '[0-9]' && echo yes || echo no)
has_special=$(echo "$password" | grep -q '[!@#$%^&*()_+={}\[\]:;\"\'<>,.?/~`-]' && echo yes || echo no)
length_ok=$( [ "${#password}" -ge 8 ] && echo yes || echo no)

# Count how many checks passed
score=0
[[ $has_uppercase == "yes" ]] && ((score++))
[[ $has_lowercase == "yes" ]] && ((score++))
[[ $has_number == "yes" ]] && ((score++))
[[ $has_special == "yes" ]] && ((score++))
[[ $length_ok == "yes" ]] && ((score++))

# Output strength based on score
echo "--------------------------------"
echo "Password Analysis:"
[[ $has_uppercase == "yes" ]] && echo "✔ Contains uppercase letter" || echo "✘ No uppercase letter"
[[ $has_lowercase == "yes" ]] && echo "✔ Contains lowercase letter" || echo "✘ No lowercase letter"
[[ $has_number == "yes" ]] && echo "✔ Contains number" || echo "✘ No number"
[[ $has_special == "yes" ]] && echo "✔ Contains special character" || echo "✘ No special character"
[[ $length_ok == "yes" ]] && echo "✔ At least 8 characters long" || echo "✘ Less than 8 characters"

echo "--------------------------------"
if [ $score -eq 5 ]; then
    echo "✅ Password Strength: VERY STRONG"
elif [ $score -ge 3 ]; then
    echo "🟡 Password Strength: MODERATE"
else
    echo "❌ Password Strength: WEAK"
fi
