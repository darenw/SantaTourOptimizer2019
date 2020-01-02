
module Bloviator

Hot = "\033[1m"
Underline ="\033[4m"
UnderlineOff="\033[24m"

def self.hot()
    Hot
end

def self.uline()
    Underline
end

def self.ulineoff()
    UnderlineOff
end

def self.fg(r,g,b)
     "\033[38;2;#{r};#{g};#{b}m";
end

def self.bg(r,g,b)
     "\033[48;2;#{r};#{g};#{b}m";
end

def self.reset()
     "\033[0m";
end




def self.progress(*msg)
    puts fg(110,250,110), *msg, reset()
end

def self.complain(*msg)
    puts fg(255, 180, 80),  *msg, reset()
end

def self.score(*msg)
    puts fg(120, 255, 208), bg(0, 36, 48), *msg, reset()
end

def self.step(*msg)   # for "debugging by print"
    puts fg(0, 50, 50), bg(160, 211, 208), *msg, reset()
end



end # module
