#/bin/bash

function generate_sws_sites_list() {
  remctl sites1 report list | grep -E "webservices|langcenter|ethicsinsociety" | sed -r "s/\s{1,}/\,/g" | sed -r "s/^https[a-zA-z0-9\.:/_-]*,//" | sed -r "s/\,.*$//" | sed -r "s/^/ds_/" > ../data/sws_sites_list.data
}
