# Standarts about route binding of Laravel

## Route Binding
Here in this project we are not using Laravel Route Binding, because of two things;
1) When project gets bigger and bigger, we may need to bing cross objects from different modules. This sometimes creates
routing problems which you need to avoid. Because it can be a surprise.
2) Due to the security issue we pass the id to the service and expects service to find the related model.