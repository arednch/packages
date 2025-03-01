# Deb Package: Phonebook

This folder contains the files necessary to build a very simple deb package for the phonebook.

## Building

- Build the phonebook itself

  ```bash
  GOOS=linux GOARCH=arm go build .
  ```

  Replace `GOARCH` with whatever architecture you need to build for.

- Copy the output executable into the `phonebook-deb/usr/bin` folder.

- Build the deb package (from outside the `phonebook-deb` folder)

  ```bash
  dpkg-deb --build phonebook-deb
  ```
