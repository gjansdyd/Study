#https://leetcode.com/problems/valid-parentheses/
class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        for c in s:
            if c == "(":
                stack.append(")")
            elif c == "{":
                stack.append("}")
            elif c == "[":
                stack.append("]")
            elif c != stack.pop():
                return False
        return not stack

print(Solution().isValid("(({}[[]]}}))"))

