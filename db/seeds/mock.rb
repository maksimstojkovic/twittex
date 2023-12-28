u1 = User.email_find_or_create_by(name: "user1", username: "handle1", email: "u1@gmail.com", password: "password")
u2 = User.email_find_or_create_by(name: "user2", username: "handle2", email: "u2@gmail.com", password: "password")
u3 = User.email_find_or_create_by(name: "user3", username: "handle3", email: "u3@gmail.com", password: "password")

f1 = Follow.find_or_create_by(followee: u1, follower: u2, accepted: false)
f2 = Follow.find_or_create_by(followee: u1, follower: u3, accepted: true)