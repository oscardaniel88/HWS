import UIKit

enum TaylorAlbums{
    case Red
    case Fearless
    case Folklore
    case Sparks
}

var albums: [TaylorAlbums] = []

albums.append(TaylorAlbums.Red)
albums.append(TaylorAlbums.Fearless)
albums.append(TaylorAlbums.Folklore)
albums.append(TaylorAlbums.Red)
albums.append(TaylorAlbums.Fearless)
albums.append(TaylorAlbums.Red)
albums.append(TaylorAlbums.Fearless)
albums.append(TaylorAlbums.Folklore)
albums.append(TaylorAlbums.Red)
albums.append(TaylorAlbums.Fearless)

var uniqueAlbums = Set<TaylorAlbums>()
uniqueAlbums = Set(albums)
let itemsCount = albums.count
let uniqueCount = uniqueAlbums.count

print("There are \(itemsCount) elements in the array");
print("There are \(uniqueCount) unique elements in the array");
