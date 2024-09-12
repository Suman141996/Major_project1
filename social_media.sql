#Identify Users by Location
#Write a query to find all posts made by users in specific locations such as'Agra', 'Maharashtra', and 'West Bengal'.
SELECT p.post_id, 
       p.caption, 
       p.location, 
       p.created_at AS post_created_at, 
       ph.photo_url, 
       v.video_url, 
       p.user_id
FROM post p
LEFT JOIN photos ph ON p.post_id = ph.post_id
LEFT JOIN videos v ON p.post_id = v.post_id
WHERE p.location LIKE '%Agra%' 
   OR p.location LIKE '%Maharashtra%' 
   OR p.location LIKE '%West Bengal%'
ORDER BY p.created_at DESC;

# Determine the Most Followed Hashtags
#Write a query to list the top 5 most-followed hashtags on the platform.
SELECT h.hashtag_name, 
       COUNT(hf.hashtag_id) AS follow_count
FROM hashtags h
JOIN hashtag_follow hf ON h.hashtag_id = hf.hashtag_id
GROUP BY h.hashtag_name
ORDER BY follow_count DESC
LIMIT 5;

#Identify the top 10 most-used hashtags in posts.
SELECT h.hashtag_name, 
       COUNT(pt.hashtag_id) AS usage_count
FROM hashtags h
JOIN post_tags pt ON h.hashtag_id = pt.hashtag_id
GROUP BY h.hashtag_name
ORDER BY usage_count DESC
LIMIT 10;

#Identify the Most Inactive User
#Write a query to find users who have never made any posts on the platform.
SELECT u.user_id, 
       u.username, 
       u.profile_photo_url, 
       u.bio, 
       u.created_at, 
       u.email
FROM users u
LEFT JOIN post p ON u.user_id = p.user_id
WHERE p.user_id IS NULL;

#Identify the Posts with the Most Likes
#Write a query to find the posts that have received the highest number of likes.
SELECT p.post_id, 
       p.caption, 
       p.location, 
       p.created_at AS post_created_at, 
       COUNT(pl.user_id) AS like_count
FROM post p
JOIN post_likes pl ON p.post_id = pl.post_id
GROUP BY p.post_id, p.caption, p.location, p.created_at
ORDER BY like_count DESC
LIMIT 10;

#Write a query to determine the average number of posts made by users.
SELECT AVG(post_count) AS average_posts_per_user
FROM (
    SELECT user_id, COUNT(*) AS post_count
    FROM post
    GROUP BY user_id
) AS user_post_counts;

#Write a query to track the total number of logins made by each user.
SELECT  u.user_id,u.username,
       COUNT(l.login_id) AS total_logins
FROM login l
JOIN users u ON l.user_id = u.user_id
GROUP BY u.username, u.user_id
ORDER BY total_logins DESC;

#Write a query to find any user who has liked every post on the platform.
SELECT u.username, COUNT(DISTINCT pl.post_id) as liked_posts_count
FROM users u
JOIN post_likes pl ON u.user_id = pl.user_id
GROUP BY u.user_id, u.username;

#Write a query to find users who have never commented on any post
SELECT u.username
FROM users u
LEFT JOIN comments c ON u.user_id = c.user_id
WHERE c.user_id IS NULL;

#Write a query to find any user who has commented on every post on the platform.\

SELECT u.username, COUNT(DISTINCT c.post_id) AS post_count
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username;
SELECT u.username, COUNT(DISTINCT c.post_id) AS user_comments, 
(SELECT COUNT(*) FROM post) AS total_posts
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
HAVING user_comments = total_posts;

#Identify Users Not Followed by Anyone
SELECT u.username
FROM users u
LEFT JOIN follows f ON u.user_id = f.follower_id
WHERE f.follower_id IS NULL;

#Write a query to find users who are not following anyone
SELECT u.username
FROM users u
WHERE u.user_id NOT IN (
    SELECT f.follower_id
    FROM follows f
);

 #Write a query to find users who have made more than five posts.
SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
JOIN post p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
HAVING COUNT(p.post_id) > 5;

 # Write a query to find users who have more than 40 followers.
 SELECT u.username, COUNT(f.follower_id) AS total_followers
FROM users u
JOIN follows f ON u.user_id = f.followee_id
GROUP BY u.user_id, u.username
HAVING COUNT(f.follower_id) > 40;

#Write a query to find comments containing specific words like "good" or "beautiful."
SELECT *
FROM comments
WHERE comment_text LIKE '%good%'
   OR comment_text LIKE '%beautiful%';
   
#Write a query to find the posts with the longest captions.
SELECT user_id, caption, location, created_at
FROM post
ORDER BY CHAR_LENGTH(caption) DESC
LIMIT 5;
                                                               #end



