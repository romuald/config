"""Simple completion utility for your standard python interactive mode
Imports and setup the rlcompleter and use an history file"""
def startup_completion():
    try:
        import readline
        import os
        import rlcompleter
        import atexit 
    except ImportError:
        pass
    else:
        readline.parse_and_bind("tab: complete")

        histpath = os.path.expanduser('~/.python_history')
        if os.path.exists(histpath):
            readline.read_history_file(histpath)
            readline.set_history_length(150)
        atexit.register(readline.write_history_file, histpath)

if __name__ == '__main__':
    startup_completion()
    del startup_completion
