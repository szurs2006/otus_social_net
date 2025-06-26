SELECT uf.id_user, up.post FROM users_posts up
JOIN users_friends uf ON up.id_user = uf.id_friend
WHERE uf.id_user = 1

CREATE MATERIALIZED VIEW feed_posts
AS SELECT uf.id_user, up.post, up.post_created FROM users_posts up
JOIN users_friends uf ON up.id_user = uf.id_friend
ORDER BY up.post_created

CREATE INDEX index_feed_posts ON feed_posts (id_user)

SELECT fp.post FROM feed_posts fp WHERE fp.id_user = 1