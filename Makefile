# ================= CONFIG =================
VALIDATED_DIR := /home/mouaguil/validated_projects
DEST_ROOT := /home/mouaguil/1337_projects

# ================= TARGET =================
export_proj:
	@if [ -z "$(CIRCLE)" ]; then \
		echo "Usage: make export_proj CIRCLE=circle_0 PROJ=get_next_line"; \
		exit 1; \
	fi
	@if [ -z "$(PROJ)" ]; then \
		echo "Usage: make export_proj CIRCLE=circle_0 PROJ=get_next_line"; \
		exit 1; \
	fi
	@if [ ! -d "$(VALIDATED_DIR)/$(PROJ)" ]; then \
		echo "Error: Project '$(PROJ)' not found in $(VALIDATED_DIR)"; \
		exit 1; \
	fi

	@SRC="$(VALIDATED_DIR)/$(PROJ)"; \
	DST="$(DEST_ROOT)/$(CIRCLE)/$(PROJ)"; \
	echo "Exporting project '$(PROJ)' to $$DST ..."; \
	rm -rf "$$DST"; \
	mkdir -p "$$DST"; \
	cp -r "$$SRC/." "$$DST/"; \
	echo "Project copied successfully!"; \
	cd $(DEST_ROOT); \
	git add .; \
	git commit -m "Add/Update $(PROJ) in $(CIRCLE)"; \
	git push; \
	echo "✅ Done: $(PROJ) exported to $(CIRCLE) and pushed to GitHub!"

