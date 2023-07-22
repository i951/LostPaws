require("dotenv").config();
// const app = require("../../index");
const supertest = require("supertest");
const expect = require("chai").expect;
// const mongoose = require("mongoose");

before(async () => {
  console.log("before")
  app = await require("../../index");
  console.log("here")
});

describe("POST: /users route to create user", () => {
  it("empty userID", async () => {
    const payload = {
      userID: "",
      name: "abc",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(1);
    expect(res.body.errors[0].path).to.equal("userID");
  });
  it("empty name", async () => {
    const payload = {
      userID: "aaaaa",
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
      userID: "aaaaa",
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
      userID: "aaaaa",
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
      userID: "aaaaa",
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
