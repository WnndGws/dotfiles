# Firefox about:config flags
These are all the privacy and personal preferance flags i have come across

## Flags
1. privacy.firstparty.isolate = true
    * A result of the Tor Uplift effort, this preference isolates all browser identifier sources (e.g. cookies) to the first party domain, with the goal of preventing tracking across different domains. (Don't do this if you are using the Firefox Addon "Cookie AutoDelete" with Firefox v58 or below.)
2. privacy.resistFingerprinting = true
    * A result of the Tor Uplift effort, this preference makes Firefox more resistant to browser fingerprinting.
3. privacy.trackingprotection.enabled = true
    * This is Mozilla’s new built in tracking protection. It uses Disconnect.me filter list, which is redundant if you are already using uBlock Origin 3rd party filters, therefore you should set it to false if you are using the add-on functionalities.
4. browser.cache.offline.enable = false
    * Disables offline cache.
5. browser.safebrowsing.malware.enabled = false
    * Disable Google Safe Browsing malware checks. Security risk, but privacy improvement.
6. browser.safebrowsing.phishing.enabled = false
    * Disable Google Safe Browsing and phishing protection. Security risk, but privacy improvement.
7. browser.send_pings = false
    * The attribute would be useful for letting websites track visitors’ clicks.
8. browser.urlbar.speculativeConnect.enabled = false
    * Disable preloading of autocomplete URLs. Firefox preloads URLs that autocomplete when a user types into the address bar, which is a concern if URLs are suggested that the user does not want to connect to. Source
9. dom.battery.enabled = false
    * Website owners can track the battery status of your device. Source
10. dom.event.clipboardevents.enabled = false
    * Disable that websites can get notifications if you copy, paste, or cut something from a web page, and it lets them know which part of the page had been selected.
11. geo.enabled = false
    * Disables geolocation.
12. media.navigator.enabled = false
    * Websites can track the microphone and camera status of your device.
13. network.cookie.cookieBehavior = 1
    * Disable cookies
        * 0 = Accept all cookies by default
        * 1 = Only accept from the originating site (block third party cookies)
        * 2 = Block all cookies by default
14. network.cookie.lifetimePolicy = 3 60
    * cookies are deleted at the end of the session
        * 0 = Accept cookies normally
        * 1 = Prompt for each cookie
        * 2 = Accept for current session only
        * 3 = Accept for N days
15. network.http.referer.trimmingPolicy = 2
    * Send only the scheme, host, and port in the Referer header
        * 0 = Send the full URL in the Referer header
        * 1 = Send the URL without its query string in the Referer header
        * 2 = Send only the scheme, host, and port in the Referer header
16. network.http.referer.XOriginPolicy = 2
    * Only send Referer header when the full hostnames match. (Note: if you notice significant breakage, you might try 1 combined with an XOriginTrimmingPolicy tweak below.) Source
        * 0 = Send Referer in all cases
        * 1 = Send Referer to same eTLD sites
        * 2 = Send Referer only when the full hostnames match
17. network.http.referer.XOriginTrimmingPolicy = 2
    * When sending Referer across origins, only send scheme, host, and port in the Referer header of cross-origin requests. Source
        * 0 = Send full url in Referer
        * 1 = Send url without query string in Referer
        * 2 = Only send scheme, host, and port in Referer
0. network.http.referer.hideOnionSource = true
18. browser.sessionstore.privacy_level = 2
    * This preference controls when to store extra information about a session: contents of forms, scrollbar positions, cookies, and POST data. more information
        * 0 = Store extra session data for any site. (Default starting with Firefox 4.)
        * 1 = Store extra session data for unencrypted (non-HTTPS) sites only. (Default before Firefox 4.)
        * 2 = Never store extra session data.
19. network.IDN_show_punycode = true
    * Not rendering IDNs as their punycode equivalent leaves you open to phishing attacks that can be very difficult to notice.
20. network.standard-url.punycode-host = true
    * Not rendering IDNs as their punycode equivalent leaves you open to phishing attacks that can be very difficult to notice.
21. network.http.spdy.enabled = false
    * By running JavaScript code in the browser of the victim and sniffing HTTPS traffic, we can decrypt session cookies. Any browsers that support either TLS compression, which is a standard, or Google's SPDY. Basically what these guys are doing, we've talked about side-channel attacks on crypto.  The idea is by changing the data being sent, or sending their own, with and without compression, the content is leaked by the amount of compression it gets.
22. security.tls.version.max = 4
    * Enables TLS1.3
        * 1 = 1.0
        * 2 = 1.1
        * 3 = 1.2
        * 4 = 1.3
23. security.tls.version.min = 3
    * Limits browser to minimum TLS 1.2. This is because TLS1.0 and TLS 1.1 are depricated
24. browser.sessionstore.interval = 1800000
    * Stops browser from saving session every 15s and sets it to every 30mins
25. security.ocsp.require = true 
    * Forces browser to reject revoked certificates
26. browser.urlbar.trimURLSs = false
    * Show everything in url bar
27. media.autoplay.enabled = false
    * Stop videos autoplaying in firefox
28. extensions.pocket.enabled = false
    * Disables all pocket crap in firefox
29. network.trr.mode = 2
    * All preferences for the DNS-over-HTTPS functionality in Firefox are located under the "network.trr" prefix (TRR == Trusted Recursive Resolver). The support for these landed in Firefox 60 but will be polished further in 61.
        * 0 - Off (default). use standard native resolving only (don't use TRR at all)
        * 1 - Race native against TRR. Do them both in parallel and go with the one that returns a result first.
        * 2 - First. Use TRR first, and only if the name resolve fails use the native resolver as a fallback.
        * 3 - Only. Only use TRR. Never use the native (after the initial setup).
        * 4 - Shadow. Runs the TRR resolves in parallel with the native for timing and measurements but uses only the native resolver results.
        * 5 - Off by choice This is the same as 0 but marks it as done by choice and not done by default.
30. network.trr.uri = https://mozilla.cloudflare-dns.com/dns-query
    * (default: none) set the URI for your DOH server. That's the URL Firefox will issue its HTTP request to. It must be a HTTPS URL. If "useGET" is enabled, Firefox will append "?ct&dns=...." to the URI when it makes its HTTP requests. For the default POST requests, they will be issued to exactly the specified URI.
31. network.trr.allow-rfc1918 = true
    * (default: false) set this to true to allow RFC 1918 private addresses in TRR responses. When set false, any such response will be considered a wrong response that won't be used.
32. layout.spellcheckDefault = 2
    * Firefox defaults to spell checking only text area inputs. By modifying this configuration, you can tell Firefox to spell check all types of text inputs.
33. us.systemUsesDarkTheme = 1
    * To enable use of dark theme
34. browser.devedition.theme.enabled = 1
    * To enable use of dark theme
35. dom.webnotifications.enabled = False
    * Disable web notifications
36. media.peerconnection.ice.no_host = False
    * Don't reveal your internal IP when WebRTC is enabled (Firefox >= 42)
37. beacon.enabled = False
    * Disable "beacon" asynchronous HTTP transfers (used for analytics)
38. browser.send_pings = False
    * Disable pinging URIs specified in HTML <a> ping= attributes
39. media.video_stats.enabled = False
    * Disable video stats to reduce fingerprinting threat
40. extensions.getAddons.cache.enabled = False
    * Opt-out of add-on metadata updates
41. devtools.webide.enabled = False
    * Disable WebIDE
42. devtools.webide.autoinstallADBHelper = False
    * Disable WebIDE
43. devtools.webide.autoinstallFxdtAdapters = False
    * Disable WebIDE
44. devtools.debugger.remote-enabled = False
    * Disable remote debugging
45. devtools.chrome.enabled = False
    * Disable remote debugging
46. devtools.debugger.force-local = True
    * Disable remote debugging
47. toolkit.telemetry.enabled = false
    * Disallow Necko to do A/B testing
48. toolkit.telemetry.unified = false
    * Disallow Necko to do A/B testing
49. toolkit.telemetry.archive.enabled = false
    * Disallow Necko to do A/B testing
50. network.allow-experiments = false
    * Disallow Necko to do A/B testing
51. network.prefetch-next = false
    * Disable prefetching of <link rel="next"> URLs
52. network.dns.disablePrefetch = true
    * Disable DNS prefetching
53. network.predictor.enabled = false
    * Disable the predictive service (Necko)
54. network.dns.blockDotOnion = true
    * Reject .onion hostnames before passing the to DNS
55. network.http.speculative-parallel-limit = 0
    * Disable speculative pre-connections
56. browser.aboutHomeSnippets.updateUrl = ""
    * Disable downloading homepage snippets/messages from Mozilla
57. browser.formfill.enable = false
    * Disable form autofill, don't save information entered in web page forms and the Search Bar
58. signon.autofillForms = false
    * Require manual intervention to autofill known username/passwords sign-in forms
59. browser.helperApps.deleteTempFileOnExit = true
    * Delete temporary files on exit
60. security.insecure_password.ui.enabled = true
    * Enable insecure password warnings (login forms in non-HTTPS pages)
