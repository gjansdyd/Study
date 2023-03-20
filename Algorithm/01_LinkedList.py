#  https://leetcode.com/problems/design-browser-history/

class BrowserNode: 
    def __init__(self, homepage: str) -> None:
        self.homepage = homepage
        self.prev = None
        self.next = None

class BrowserHistory:
    def __init__(self, homepage: str):
        node = BrowserNode(homepage)
        self.head = node
        self.crnt = node
        self.maxCount = 1
        
    #insert
    def visit(self, url: str) -> None:
        if self.head is None:
           pass # not   
        else:
            node = BrowserNode(url)
            self.crnt.next = node
            node.prev = self.crnt
            self.crnt = node
            self.maxCount += 1

    def back(self, steps: int) -> str:
        crntIdx = self.maxCount
        while crntIdx > self.maxCount - steps:
            crntIdx -= 1
            if self.crnt.prev is None:
                return self.crnt.homepage
            self.crnt = self.crnt.prev
        return self.crnt.homepage

    def forward(self, steps: int) -> str:
        crntIdx = 0
        while crntIdx < steps:
            crntIdx += 1
            if self.crnt.next is None:
                return "you cannot move forward any steps"
            self.crnt = self.crnt.next
    
        return self.crnt.homepage

browserHistory = BrowserHistory("leetcode.com")
print(browserHistory.visit("google.com"))
print(browserHistory.visit("google.com"))
print(browserHistory.visit("facebook.com"))
print(browserHistory.visit("youtube.com"))
print(browserHistory.back(1))
print(browserHistory.back(1))
print(browserHistory.forward(1))
print(browserHistory.visit("linkedin.com"))
print(browserHistory.forward(2))
print(browserHistory.back(2))
print(browserHistory.back(7))