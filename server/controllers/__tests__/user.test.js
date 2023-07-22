const app = require("../../index");
const supertest = require("supertest");

describe("createUser", () => {
  test("empty userID", async () => {
    const payload = {
      userID: "",
      name: "abc",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
    expect(res.body.errors).toHaveLength(1);
    expect(res.body.errors[0].path).toEqual("userID");
  });
  test("empty name", async () => {
    const payload = {
      userID: "aaaaa",
      name: "",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
    expect(res.body.errors).toHaveLength(1);
    expect(res.body.errors[0].path).toEqual("name");
  });
  test("invalid name", async () => {
    const payload = {
      userID: "aaaaa",
      name: "%%$#(@!",
      email: "a@b.com",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
    expect(res.body.errors).toHaveLength(1);
    expect(res.body.errors[0].path).toEqual("name");
  });
  test("empty email", async () => {
    const payload = {
      userID: "aaaaa",
      name: "aaaaa",
      email: "",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
    expect(res.body.errors).toHaveLength(1);
    expect(res.body.errors[0].path).toEqual("email");
  });
  test("invalid email", async () => {
    const payload = {
      userID: "aaaaa",
      name: "aaaaa",
      email: "sdfsdf",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
    expect(res.body.errors).toHaveLength(1);
    expect(res.body.errors[0].path).toEqual("email");
  });
});
