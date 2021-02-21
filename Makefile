update_data:
	if [ -d /tmp/iso-codes_clone ]; then rm -rf /tmp/iso-codes_clone; fi
	git clone --depth 1 https://salsa.debian.org/iso-codes-team/iso-codes.git /tmp/iso-codes_clone
	mkdir -p ./data
	mkdir -p ./data/iso_639-2
	mkdir -p ./data/iso_3166-1
	cp /tmp/iso-codes_clone/data/iso_639-2.json ./data/iso_639-2.json
	cp /tmp/iso-codes_clone/data/iso_3166-1.json ./data/iso_3166-1.json
	cp -r /tmp/iso-codes_clone/iso_639-2/*.po ./data/iso_639-2
	cp -r /tmp/iso-codes_clone/iso_3166-1/*.po ./data/iso_3166-1
