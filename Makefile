help:
	@echo "\033[1;34m[make targets]:\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; \
			{printf "\033[1;36m%-15s\033[0m%s\n", $$1, $$2}'

deps: ## Install dependencies
	@echo "[Installing Dependencies]"
	@bash setup.bash
