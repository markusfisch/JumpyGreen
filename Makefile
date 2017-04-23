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
		MAX_SIZE=256 \
		MIN_SIZE=256 \
		MARGIN=1 \
		mkatlas ../$(SPRITES) | \
		patchatlas index.html
	convert $(HTDOCS)/atlas.png \
		-background black \
		-alpha Remove $(HTDOCS)/atlas.png \
		-compose Copy_Opacity \
		-composite $(HTDOCS)/atlas.png
