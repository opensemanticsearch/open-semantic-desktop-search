#!/bin/sh

#localization="en"
localization="de"

# no questions from Debian package manager
export DEBIAN_FRONTEND=noninteractive

# no paging (wait for user scrolling) while Solr installation script
export SYSTEMD_PAGER=""


# update package lists and sources to contrib and non-free
cat <<EOF > ${rootdir}/etc/apt/sources.list
deb http://deb.debian.org/debian/ stable main contrib non-free
deb http://security.debian.org/ stable/updates main contrib non-free
deb http://deb.debian.org/debian stretch-backports main
EOF

apt-get update
apt-get upgrade

# install VM guest additions so later no problems
apt-get -y install linux-image-amd64 linux-headers-amd64 build-essential module-assistant

# mount VM guest additions
mkdir /tmp/cdrom
mount /dev/cdrom /tmp/cdrom
sh /tmp/cdrom/VBoxLinuxAdditions.run || exit
umount /dev/cdrom

# install first, so later no problems
apt-get -y install dbus

# configure debconf options
echo 'Debconf'

debconffilelist=`ls /usr/src/customize/debconf`

for debconffile in ${debconffilelist};
do
    echo "Configurating debconf with ${debconffile}"
    debconf-set-selections /usr/src/customize/debconf/${debconffile}
done

echo 'Debconf (localization)'

debconffilelist=`ls /usr/src/customize/debconf.${localization}`

for debconffile in ${debconffilelist};
do
    echo "Configurating debconf with ${debconffile}"
    debconf-set-selections /usr/src/customize/debconf.${localization}/${debconffile}
done


# packages from backports
echo "Installation of backports"
apt-get -t stretch-backports -y install tesseract-ocr-all tesseract-ocr tesseract-ocr-bul tesseract-ocr-cat tesseract-ocr-ces tesseract-ocr-dan tesseract-ocr-deu tesseract-ocr-ell tesseract-ocr-eng tesseract-ocr-fin tesseract-ocr-fra tesseract-ocr-hun tesseract-ocr-ind tesseract-ocr-ita tesseract-ocr-lav tesseract-ocr-lit tesseract-ocr-nld tesseract-ocr-nor tesseract-ocr-pol tesseract-ocr-por tesseract-ocr-ron tesseract-ocr-rus tesseract-ocr-slk tesseract-ocr-slv tesseract-ocr-spa tesseract-ocr-srp tesseract-ocr-swe tesseract-ocr-tur tesseract-ocr-ukr tesseract-ocr-vie tesseract-ocr-chi-sim tesseract-ocr-chi-tra tesseract-ocr-amh tesseract-ocr-asm tesseract-ocr-aze-cyrl tesseract-ocr-bod tesseract-ocr-bos tesseract-ocr-ceb tesseract-ocr-cym tesseract-ocr-dzo tesseract-ocr-fas tesseract-ocr-gle tesseract-ocr-guj tesseract-ocr-hat tesseract-ocr-iku tesseract-ocr-jav tesseract-ocr-kat tesseract-ocr-kat-old tesseract-ocr-kaz tesseract-ocr-khm tesseract-ocr-kir tesseract-ocr-lao tesseract-ocr-lat tesseract-ocr-mar tesseract-ocr-mya tesseract-ocr-nep tesseract-ocr-ori tesseract-ocr-pan tesseract-ocr-pus tesseract-ocr-san tesseract-ocr-sin tesseract-ocr-srp-latn tesseract-ocr-syr tesseract-ocr-tgk tesseract-ocr-tir tesseract-ocr-uig tesseract-ocr-urd tesseract-ocr-uzb tesseract-ocr-uzb-cyrl tesseract-ocr-yid tesseract-ocr-osd tesseract-ocr-afr tesseract-ocr-ara tesseract-ocr-aze tesseract-ocr-bel tesseract-ocr-ben tesseract-ocr-chr tesseract-ocr-enm tesseract-ocr-epo tesseract-ocr-est tesseract-ocr-eus tesseract-ocr-frk tesseract-ocr-frm tesseract-ocr-glg tesseract-ocr-heb tesseract-ocr-hin tesseract-ocr-hrv tesseract-ocr-isl tesseract-ocr-ita-old tesseract-ocr-jpn tesseract-ocr-kan tesseract-ocr-kor tesseract-ocr-mal tesseract-ocr-mkd tesseract-ocr-mlt tesseract-ocr-msa tesseract-ocr-spa-old tesseract-ocr-sqi tesseract-ocr-swa tesseract-ocr-tam tesseract-ocr-tel tesseract-ocr-tha tesseract-ocr-bre tesseract-ocr-chi-sim-vert tesseract-ocr-chi-tra-vert tesseract-ocr-cos tesseract-ocr-div tesseract-ocr-fao tesseract-ocr-fil tesseract-ocr-fry tesseract-ocr-gla tesseract-ocr-hye tesseract-ocr-jpn-vert tesseract-ocr-kor-vert tesseract-ocr-kur-ara tesseract-ocr-ltz tesseract-ocr-mon tesseract-ocr-mri tesseract-ocr-oci tesseract-ocr-que tesseract-ocr-snd tesseract-ocr-sun tesseract-ocr-tat tesseract-ocr-ton tesseract-ocr-yor tesseract-ocr-script-arab tesseract-ocr-script-armn tesseract-ocr-script-beng tesseract-ocr-script-cans tesseract-ocr-script-cher tesseract-ocr-script-cyrl tesseract-ocr-script-deva tesseract-ocr-script-ethi tesseract-ocr-script-frak tesseract-ocr-script-geor tesseract-ocr-script-grek tesseract-ocr-script-gujr tesseract-ocr-script-guru tesseract-ocr-script-hans tesseract-ocr-script-hans-vert tesseract-ocr-script-hant tesseract-ocr-script-hant-vert tesseract-ocr-script-hang tesseract-ocr-script-hang-vert tesseract-ocr-script-hebr tesseract-ocr-script-jpan tesseract-ocr-script-jpan-vert tesseract-ocr-script-knda tesseract-ocr-script-khmr tesseract-ocr-script-laoo tesseract-ocr-script-latn tesseract-ocr-script-mlym tesseract-ocr-script-mymr tesseract-ocr-script-orya tesseract-ocr-script-sinh tesseract-ocr-script-syrc tesseract-ocr-script-taml tesseract-ocr-script-telu tesseract-ocr-script-thaa tesseract-ocr-script-thai tesseract-ocr-script-tibt tesseract-ocr-script-viet


# packages lists
packagelists=`ls /usr/src/customize/package-lists`

for list in ${packagelists};
do
    echo "Adding packagelist $list"
    packages=`cat /usr/src/customize/package-lists/${list} | xargs`
    packagesparams="$packages $packagesparams"

done

# packages lists for language
packagelists=`ls /usr/src/customize/package-lists.${localization}`

for list in ${packagelists};
do
    echo "Adding packagelist $list"
    packages=`cat /usr/src/customize/package-lists.${localization}/${list} | xargs`
    packagesparams="$packages $packagesparams"

done

echo "Installing packages from packagelists: ${packagesparams}"
apt-get -y install ${packagesparams}

# install custom packages
dpkg --install /usr/src/customize/packages.chroot/*.deb

# install dependencies
apt-get -y -f install

# stop Solr so we can overwrite its config and data
service solr stop

# Add (optional shared) folder for index
mkdir /media/sf_index
mkdir /media/sf_index/tmp

# link Solr index to shared folder
rm -r /var/solr/data/opensemanticsearch/data
ln -s /media/sf_index /var/solr/data/opensemanticsearch/data

# allow Solr to write to index directory, if not external index (so mounted to Virtual Box shared folder and rights from vboxsf group)
chown solr:solr /media/sf_index

# copy overwriting or additional files to root dir
cp -a /usr/src/customize/includes.chroot/* /

# copy files for language to root dir
cp -a /usr/src/customize/includes.chroot.${localization}/* /

# run config script
/usr/src/customize/hooks/config.chroot

# add solr and user to group vboxsf, so they have access to shared folders of host system
usermod -a -G vboxsf solr
usermod -a -G vboxsf opensemanticetl

# delete apt package cache
apt-get clean

# set localization in Open Semantic Search setup
curl 'http://localhost/search-apps/setup/set_language?language=de&languages=en,de&languagesforce=de&ocrlanguages=deu'

# delete installation sources and this script
rm -r /usr/src/customize

# delete deleted data on filesystem by filling up ueros, which will increase compression rate on appliance export
dd if=/dev/zero of=/ZEROS bs=1M
sync
rm -f /ZEROS

# shutdown ready build VM
systemctl poweroff
