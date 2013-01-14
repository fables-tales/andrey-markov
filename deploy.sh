#!/bin/bash
ssh tea "cp markov/checkout/.andrey /tmp"
ssh tea "cd markov/checkout && kill -2 \`cat .andrey.pid\`"
ssh tea rm -rf markov/checkout
git push tea:markov/repo.git master
ssh tea "cd markov && git clone ./repo.git checkout"
ssh tea "cp /tmp/.andrey markov/checkout"
ssh tea "cd markov/checkout && screen -d -m ruby -Ilib/ bin/andreymarkov"
