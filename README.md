## Summary

This R code takes a specified amount of statuses from a Facebook page as tabulates the likes/comments for those statuses (+ other attributes), then outputs all the data as a tab-delimited file, perfect for importing into a spreadsheet program and doing statistical analysis, such as pivot tables and conditional regression. (see my article "Does Asking Questions to Readers Increase Response Rate - And Other TechCrunch Analyses": http://minimaxir.com/2012/10/questions-equals-reponses/ )

An example output with 2425 statuses from the TechCrunch page from 12/31/12, both the raw output and a formatted Excel spreadsheet, is provided.

## Output Data

- Link Title: If the post is a Link post, this is the title of the link in the status. [Clicking the cell will take you to the link destination]
- Message: The status message. [Clicking the cell will take you to the status itself]
- Time Posted (PST): The time the message was posted, in PST.
- # Likes: The number of likes for the status.
- # Comments: The number of comments for the status
- Has Question?: Does the status ask a question to the reader? A "Yes" response should positively correlate with higher likes/comments.
- Is Photo?: Is the status a photo? A "Yes" response should positively correlate with higher likes/comments.

## Prerequisites

- The rjson R library
- The Page username of the page being analyzed. (http://facebook.com/[USERNAME])
- A valid access token. (go to http://developers.facebook.com/tools/explorer/ and copy the token. No permissions necessary)
