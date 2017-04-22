HTDOCS = htdocs
ATLAS = $(HTDOCS)/atlas.png
SPRITES = sprites/*
WEBROOT = hhsw.de@ssh.strato.de:sites/proto/ld38
OPTIONS = \
	--recursive \
	--links \
	--update \
	--delete-after \
	--times \
	--compress

live: $(ATLAS)
	rsync $(OPTIONS) $(HTDOCS)/* $(WEBROOT)

$(ATLAS): $(SPRITES)
	cd $(HTDOCS) && \
		MAX_SIZE=1024 \
		MIN_SIZE=1024 \
			MARGIN=2 \
			EXPAND='tile_*' \
			mkatlas ../$(SPRITES) | \
		patchatlas index.html
	convert $(ATLAS) \( +clone -alpha Extract \) \
		-channel RGB \
		-compose Multiply \
		-composite $(ATLAS)
