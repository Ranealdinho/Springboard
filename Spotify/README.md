# Spotify Music Recommendation System

*In this project, I am creating a music recommendation system based on my own Spotify Data. My goal for this project is to use my past listening history to train my models, and then recommend other songs based on my history and lsitening patterns. I will be using my top artist data to rate the songs in my training/test dataset. These models are specifically trained to my data, but the models can be trained with the same filters using anyones data by using the Spotify API, Spotipy to extract their own data.*

## 1. Data

The Data for this project was all taken from my Personal Spotify account using the Spotify API, Spotipy. Links to access the Spotify for Developers and access your own Spotify data can be found below:

> * [Spotify for Developers](https://www.https://developer.spotify.com/)


## 2. Method

Because I was able to rate my dataset based on my top artists from Spotify, I used a content-based recommender:

1. **Content-based filter:** Recommending future items to the user that have similar innate features with previously "liked" items. Basically, content-based relies on similarities between features of the items & needs good item profiles to function properly.


## 3. Data Wrangling and EDA

[Data Wrangling](https://github.com/Ranealdinho/Springboard/blob/main/Spotify/Spotify_DataWrangling_RNW.ipynb)

[EDA Report](https://github.com/Ranealdinho/Springboard/blob/main/Spotify/Spotify_EDA_RNW.ipynb)

* The Idea for this project came about early in December while browsing social media. I noticed a lot of friends and family all share their own "Spotify Wrapped" for the year. Spotify Wrapped is basically a summary of your listening preferences throughout the year, such as favorites artists or most listened to songs / genres. It was this idea that made me interested in digging in deeper to my own data, and the motivation behind this project.

* EDA again is specific to me because I was using only my own personal data, but it was interesting to learn more about my own listening habits and which artists, songs, and genres I was actually listening to the most. 



## 4. Modeling and Predictions

[Modeling & Results](https://github.com/Ranealdinho/Springboard/blob/main/Spotify/Spotify_Recommendation_Modeling.ipynb)

First thing I did to my train/test dataset was I used my "Top Artist" Spotify data to rate my dataset. If a song in the playlist was by one of my 60 "top artists" I gave the song a rating of "1", if the song was not by one of my favorite artists, I gave the song a rating of "0"

Variables that I used to train the data:

 * 'danceability', 'energy', 'key', 'loudness', 'mode', 'speechiness', 'acousticness', 'instrumentalness', 'liveness', 'valence', 'tempo', 'time_signature', and 'genres'
 
 Variables that I did not want to use to train data:
 
 * 'popularity', 'explicit'
 
 Variable I was trying to predict:
 
 * 'rating'


I then fit 3 seperate Classification Models with my trained data, and compared the classification reports and accuracy scores of all 3 to determine which model would be the best.

* 1) Logistic regression (after scaling data): Accuracy score of 0.6651982378854625 

* 2) kNN(after determining optimal n_neighbors of 2): Accuracy score of 0.6563876651982379

* 3) Random Forest Classifier (after determining optimal max_depth = 20, and min_leaf_samples = 1): *Accuracy score of 0.947136563876652*

The Random Forest classifier easily outperformed the other models, and would be the model I used to predict.


## 5. Outcomes

When testing my model on the validation dataset, the model predicted *116 songs* that I would like with a probability rating of over 0.75! I was very excited to see these songs and add them to my playlists. I actually really did enjoy these songs and I thought the model did an excellent job in knowing exactly what kind of music I like.


## 6. Takeaways and Future Improvements

* In the future, I would try to come up with a more comprehensive rating system that is more in depth. Such as: rating every song individually, rating songs by both top artists and top songs, or being able to rate a song 0-10.

* Because my top artist data was primarily rap/ hip hop dominant, the song recommendations with the highest probabilty were very similar. Next time I would try to use a larger pool of top artist data (200 artists rather than 60 that I used) so it could account for more artist diversity.






