elem' :: Eq a => [a] -> a -> Bool
elem' x y = foldr (\x r -> x == y || r) False x
 
concatPichi :: [a] -> [a] -> [a]
concatPichi [] y     = y
concatPichi (x:xs) y = x : concatPichi xs y

concat' :: [a] -> [a] -> [a]
concat' x y = foldr (:) y x

filterPichi :: (a -> Bool) -> [a] -> [a]
filterPichi f []     = []
filterPichi f (x:xs) = if f x
                       then x : (filterPichi f xs)
                       else filterPichi f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' f = foldr (\x r -> if f x then x:r else r) []

map' :: (a -> b) -> [a] -> [b]
map' f x = foldr (\x r -> (f x) : r) [] x
--map' f x = foldr (:).f [] x -- no funciona

-- Definir la función mejorSegún :: (a -> a -> Bool) -> [a] -> a,
-- que devuelve el máximo elemento de la lista según una función
-- de comparación, utilizando foldr1. Por ejemplo,
-- maximum = mejorSegún (>).

mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x y -> if f x y then x else y)

-- . Definir la función sumasParciales :: Num a => [a] -> [a],
-- que dada una lista de números devuelve otra de la misma
-- longitud, que tiene en cada posición la suma parcial de
-- los elementos de la lista original desde la cabeza hasta
-- la posición actual. Por ejemplo, sumasParciales [1,4,-1,0,5]
-- ; [1,5,4,4,9].

sumasParciales :: Num a => [a] -> [a]
sumasParciales [] = []
sumasParciales x  = foldl (\acc x -> acc + x) 0 x