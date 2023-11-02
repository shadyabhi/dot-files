install:
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.config/nvim/dein
	sudo jamf policy -trigger cleanpython
	wget https://bootstrap.pypa.io/get-pip.py
	# sudo /export/apps/python/2.7/bin/python ./get-pip.py
	# sudo /export/apps/python/3.5/bin/python3 ./get-pip.py
	sudo /export/apps/python/3.7/bin/python3 ./get-pip.py
	sudo /export/apps/python/3.7/bin/pip install neovim
	# sudo /export/apps/python/3.5/bin/pip install neovim
	# sudo /export/apps/python/2.7/bin/pip install neovim
