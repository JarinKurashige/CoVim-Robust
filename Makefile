# Define the mandatory variable
USERNAME ?=

# Guard target to check if USERNAME is set
check_username:
	@if [ -z "$(USERNAME)" ]; then \
		echo "Error: USERNAME is not set. Please provide a username before running make setup."; \
		exit 1; \
	fi


deps:
	@echo "installing python3 dependencies"
	sudo apt install python3-twisted python3-argparse-addons python3-service-identity 
	@echo "dependencies installed."

# Setup target that depends on the check
setup: check_username
	@echo "Setting up for user: $(USERNAME)"

	echo 'let CoVim_default_name = "$(USERNAME)"' >> /home/$(USER)/.vimrc
	echo 'let CoVim_default_port = "25000"' >> /home/$(USER)/.vimrc
	# Add your setup commands here

install:
	@target="/home/$(USER)/.vim/plugin"; \
	echo "installing CoVim to $$target"; \
	mkdir -p $$target; \
	cp -r plugin/* $$target; \
	chmod +x $$target/*; \
	echo "installed successfully."

# Main target
all: 
	@echo "Run 'make setup USERNAME=your_username' to perform the setup."
	@echo "Run 'make deps' to install system dependencies."
	@echo "Run 'make install' to install the plugin in your vim directory."

# Example of how to run the Makefile
# To run this Makefile, use:
# make setup USERNAME=your_username

