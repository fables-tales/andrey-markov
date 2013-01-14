#!/bin/bash
ssh tea rm -rf markov
scp -r . tea:markov/
echo "Restart it in screen yo!"
ssh tea
