
module Bloviator


def self.fg(r,g,b)
     "\033[38;2;122;188;208m";
end

def self.bg(r,g,b)
     "\033[48;2;#{r};#{g};#{b}m";
end

def self.reset()
     "\033[0m";
end



def self.progress(*msg)
    puts fg(160,250,160), *msg, reset()
end

def self.complain(*msg)
    puts fg(255, 180, 80), bg(0, 36, 48), *msg, reset()
end

def self.score(*msg)
    puts fg(120, 255, 208), *msg, reset()
end


end # module
