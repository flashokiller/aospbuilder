#!/bin/bash
cd /tmp/rom # Depends on where source got synced
rm -rf device/generic/opengl-transport
# Normal build steps
. build/envsetup.sh
lunch spark_ysl-user
# Next 8 lines should be run first to collect ccache and then upload, after doning it 1 or 2 times, our ccache will help to build without these 8 lines Sepolicy Fix.
mka api-stubs-docs || echo no problem, we need ccache
mka system-api-stubs-docs || echo no problem we need ccache
mka test-api-stubs-docs || echo no problem, we need ccache
make Sparky & # dont remove that '&'
#sleep 80m
and dont use below codes for first 1 or 2 times, to get ccache uploaded,


# upload function for uploading rom zip file! I don't want unwanted builds in my google drive haha!
up(){
	curl -sL https://git.io/file-transfer | sh
	./transfer wet $1; echo
        # 14 days, 10 GB limit
}

tg(){
	bot_api=1716503529:AAHp9iHcS5N4EQZJOKU5PWxER-4rDdDj7eY# Your tg bot api, dont use my one haha
	your_telegram_id=$1 # No need to touch
	msg=$2 # No need to touch
	curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" --data "text=$msg&chat_id=${your_telegram_id}"
}

id=1574611094 # Your telegram id

# Build command! j10 for 10 cpu, j8 for 8 cpu, otherwise memeroy will end up even its 24G
# Upload rom zip file if succeed to build! Send notification to tg! And send shell to tg if build fails!

# Let's compile by parts! Coz of ram issue!
#mka api-stubs-docs || echo no problem
#mka system-api-stubs-docs || echo no problem
#mka test-api-stubs-docs || echo no problem
#
mka bacon -j8 \
	&& send_zip=$(up out/target/product/ysl/*zip) && tg $id "Build Succeed!
$send_zip" \
	|| tmate -S /tmp/tmate.sock new-session -d && tmate -S /tmp/tmate.sock wait tmate-ready && send_shell=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}') && tg $id "Build Failed" && tg $id "$send_shell" && ccache -s && sleep 2h
ccache -s # Let's print ccache statistics finally

######