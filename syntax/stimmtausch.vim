" Simple syntax matching for MUCK commands

syn match MUCKWhisper /^wh\(isper\)\?[^=]*$/
syn match MUCKPage    /^p\(age\)\?[^=]*$/
syn match MUCKWPNames /^\(wh\(isper\)\?\|p\(age\)?\)\s\+[^=]*=/
syn match MUCKSay     /^\("\|say\?\)\s*$/
syn match MUCKPose    /^\(:\|po\(se\)\?\)\s*$/
syn match MUCKSPText  /^\(:\|po\(se\)\?\s\+\|"\|say\?\s\+\)./he=e-1
syn match MUCKTel     /^t\(axi\)\?\s*$/
syn match MUCKTelText /^t\(axi\)\? ./he=e-1
syn match MUCKLook    /^l\(ook\)\?\s*$/
syn match MUCKSmell   /^smell\s*$/
syn match MUCKLSText  /^\(l\(ook\)\?\|smell\)\s\+./he=e-1
syn match MUCKDir     /^\(n\[ew\]\?\|s\[ew\]\?\|e\|w\|in\|out\)$/

hi def link MUCKWhisper Todo
hi def link MUCKPage    Todo
hi def link MUCKSay     Todo
hi def link MUCKPose    Todo
hi def link MUCKLook    Todo
hi def link MUCKSmell   Todo
hi def link MUCKTel     Todo

hi def link MUCKWPNames Statement
hi def link MUCKSPText  Statement
hi def link MUCKTelText Statement
hi def link MUCKLSText  Statement
hi def link MUCKDir     Statement
