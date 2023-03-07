# OpenDome
This is an Open-Source-Implementation for the Companion-App for Azdome Daschcams.
I specifically test all my builds with an AZDome GS63H.

## Technical Implementation
The official App uses a simple HTTP-Implementation, and therefore can easily be captured.
My Aim is to uses this information, to imitate the communication.

### Communication
Every Request goes to 192.168.1.254:80/?custom=<>&cmd=<>
| custom | cmd | Response | Effect |
|--------|-----|----------|--------|
|  1     | 2019|  <?xml version="1.0" encoding="UTF-8" ?><LIST><MovieLiveViewLink>http://192.168.1.254:8192</MovieLiveViewLink><PhotoLiveViewLink>http://192.168.1.254:8192</PhotoLiveViewLink></LIST>        |Returns Stream-URLs        |
|        |     |          |        |
|        |     |          |        |
