#!/bin/bash



conda env list

conda activate super_mario

nohup jupyter notebook --allow-root -NotebookApp.base_url=/jupyter -NoteookApp.password='' -NotebookApp.token='' &
