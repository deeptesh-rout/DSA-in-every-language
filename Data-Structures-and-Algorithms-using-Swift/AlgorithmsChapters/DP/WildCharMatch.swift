import Foundation;

func matchExp(_ expi : String, _ stri : String) -> Bool {
	var exp : [Character] = Array(expi)
	var str : [Character] = Array(stri)
	return matchExpUtil(&exp, &str,0,0);
}

func matchExpUtil(_ exp : inout [Character], _ str : inout [Character], _ m : Int, _ n : Int) -> Bool {
	if (m == exp.count && (n == str.count || exp[m - 1] == "*")) {
		return true;
	}

	if ((m == exp.count && n != str.count) || (m != exp.count && n == str.count)) {
		return false;
	}

	if (exp[m] == "?" || exp[m] == str[n]) {
		return matchExpUtil( &exp, &str,m + 1,n + 1);
	}

	if (exp[m] == "*") {
		return matchExpUtil( &exp, &str,m + 1,n) || matchExpUtil( &exp, &str,m,n + 1);
	}
	return false;
}

func matchExpDP(_ expi : String, _ stri : String) -> Bool {
	var exp : [Character] = Array(expi)
	var str : [Character] = Array(stri)
	return matchExpUtilDP( &exp, &str,exp.count,str.count);
}

func matchExpUtilDP(_ exp : inout [Character], _ str : inout [Character], _ m : Int, _ n : Int) -> Bool {
	var lookup : [[Bool]] = Array(repeating: Array(repeating: false, count: n + 1), count: m + 1);
	lookup[0][0] = true;

	// empty exp and empty str match.
	// 0 row will remain all false. empty exp can't match any str.
	// '*' can match with empty string, column 0 update.
	var i : Int = 1;
	while (i <= m) {
		if (exp[i - 1] == "*") {
			lookup[i][0] = lookup[i - 1][0];
		} else {
			break;
		}
		i += 1;
	}

	// Fill the table in bottom-up fashion
	i = 1;
	while (i <= m) {
		var j : Int = 1;
		while (j <= n) {
			// If we see a '*' in pattern:
			// 1) We ignore '*' character and consider next character in the pattern.
			// 2) We ignore one character in the input str and consider next character.
			if (exp[i - 1] == "*") {
				lookup[i][j] = lookup[i - 1][j] || lookup[i][j - 1];
			} else if (exp[i - 1] == "?" || str[j - 1] == exp[i - 1]) {
				lookup[i][j] = lookup[i - 1][j - 1];
			} else {
				lookup[i][j] = false;
			}
			j += 1;
		}
		i += 1;
	}
	return lookup[m][n];
}

// Testing code.
print("matchExp ::", matchExp("*llo,?World?","Hello, World!"));
print("matchExp ::", matchExpDP("*llo,?World?","Hello, World!"));
    
/*
matchExp :: true
matchExp :: true
*/