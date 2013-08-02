
```js
    currentPlayer = new MediaElementPlayer('#video-tag', 
        {
          thumbnailSelectorEnabled: true,
          thumbnailSelectorUpdateURL: '/thumb-upload'
          features: 'thumbnailSelector']
        });
```

==Development


To watch for changes to the coffeescript file:

```cli
$ guard init
$ guard start
```