const app = require("../../index");
const supertest = require("supertest");
const expect = require("chai").expect;
const mongooseSetup = require("../../utils/mongoose");

before((done) => {
  mongooseSetup
    .dbconnect()
    .once("open", () => {
      console.log("Test: Mongodb connected!");
      done();
    })
    .on("error", (error) => {
      console.log("Test: Mongodb connection error!");
      done(error);
    });
});

after((done) => {
  mongooseSetup
    .dbclose()
    .then(() => {
      console.log("Test: Mongodb disconnected!");
      done();
    })
    .catch((err) => {
      console.log("Test: Mongodb disconnection error!");
      done(err);
    });
});

describe("POST: /users route to create user", () => {
  it("empty uid", async () => {
    const payload = {
      uid: "",
      name: "abc",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("uid");
  });
  it("empty name", async () => {
    const payload = {
      uid: "aaaaa",
      name: "",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("name");
  });
  it("invalid name", async () => {
    const payload = {
      uid: "aaaaa",
      name: "%%$#(@!",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("name");
  });
  it("empty email", async () => {
    const payload = {
      uid: "aaaaa",
      name: "aaaaa",
      email: "",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("email");
  });
  it("invalid email", async () => {
    const payload = {
      uid: "aaaaa",
      name: "aaaaa",
      email: "sdfsdf",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("email");
  });
});

// TODO: add tests
describe("GET: /users/:uid route to get a user profile", () => {
  it("empty uid", async () => {
    const uid = "";

    const res = await supertest(app).get("/users/" + uid);

    expect(res.status).to.equal(404);
    expect(res.headers["content-type"]).to.have.string("text/html");
  });

  it("invalid uid", async () => {
    const uid = "$((";

    const res = await supertest(app).get("/users/" + uid);

    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("uid");
  });

  it("non-existent uid", async () => {
    const uid = "bsfglo8dflshdfn";

    const res = await supertest(app).get("/users/" + uid);

    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("uid");
  });
});

// TODO: add tests
describe("POST: /users/edit route to edit profile", () => {
  it("empty uid", async () => {
    const payload = {
      uid: "",
      name: "abc",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/edit").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("uid");
  });
});
