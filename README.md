# homework-for-adjust

This repository contains solution to deploy ruby webser.

Wrapper written in bash with static yaml manifests, minimal functionality to work in minimal time-frame. Spent less than 1 day.

I decided to not use high level iac tools due to it would be overkill. But everyone will be able to read it.

Web server doesnt support http requests so I have use curl to get respond fron different sub-urls.

Usage is quite simple - just execute **run-me.sh** with option: **deploy**, **clenup** or **check** and look to your terminal.