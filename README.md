## Summary

This R code takes a specified amount of statuses from a Facebook page, tabulates the likes/comments for those statuses (+ other attributes), then outputs it in a tab-delimited file.

An example output with 2425 statuses from the TechCrunch page from 12/31/12, both the code output and a formatted Excel spreadsheet, is provided.

## Output Data

- Link Title: If the post is a Link post, this is the title of the link in the status. [Clicking the cell will take you to the post itself
- Message: The status message. [Clicking the cell will take you to the post itself]
- Time Posted (PST): The time the message was posted, in PST.
- # Likes: The number of likes for the status.
- # Comments: The number of comments for the status
- Has Question?: Does the status ask a question to the reader? This should positively correlate with higher likes/comments.
- Is Photo?: Is the status a photo? This should positively correlate with higher likes/comments.

## Prerequisites

- The rjson R library
- The Page username of the page being analyzed. (http://facebook.com/[USERNAME])
- A valid access token. (go to http://developers.facebook.com/tools/explorer/ and copy the token. No permissions necessary)
