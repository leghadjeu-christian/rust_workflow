FROM rust:1.67 as build

# create a new empty shell project
RUN USER=root cargo new --bin rust_workflow
WORKDIR /rust_workflow

# copy over your manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# this build step will cache your dependencies
RUN cargo build --release
RUN rm src/*.rs

# copy your source tree
COPY ./src ./src

# build for release
RUN rm ./target/release/rust_workflow
RUN cargo build --release

# our final base
FROM gcr.io/distroless/cc AS runtime

# copy the build artifact from the build stage
COPY --from=build /rust_workflow/target/release/rust_workflow .

# set the startup command to run your binary
ENTRYPOINT ["/rust_workflow"]
