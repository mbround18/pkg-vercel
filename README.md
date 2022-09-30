# Proof of Concept for `pkg` by Vercel

## Intention

Test the validity of utilizing `pkg` by Vercel which should bundle the node process into an easily executable file. 
The image produced should be a small image with minimal dependancies. 

## Usage

1. yarn install
2. yarn docker:build
3. yarn docker:run
4. Acces via `http://localhost:3000`


## Conclusion

Traditional docker image that would require a node server would package node modules. This is chunky and should be the norm. 
In this sitation, we are using pkg to convert to node v8 binary and executing within an alpine image. 

Traditional docker image is roughly 285MB
pkg for alpine is 54MB