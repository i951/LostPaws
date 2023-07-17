const app = require("../../index");
const supertest = require("supertest");

describe("createUser", () => {
  test("empty userID", async () => {
    const payload = {
      userID: "",
      name: "%%$#(@!",
      email: "a@b.c",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
  });
  test("empty name", async () => {
    const payload = {
      userID: "a",
      name: "",
      email: "a@b.c",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
  });
  test("invalid name", async () => {
    const payload = {
      userID: "a",
      name: "%%$#(@!",
      email: "a@b.c",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
  });
  test("empty email", async () => {
    const payload = {
      userID: "a",
      name: "a",
      email: "",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
  });
  test("invalid email", async () => {
    const payload = {
      userID: "a",
      name: "a",
      email: "sdfsdf",
    };

    const res = await supertest(app).post("/users/").send(payload);
    expect(res.status).toEqual(422);
    expect(res.type).toEqual(expect.stringContaining("json"));
    expect(res.body).toHaveProperty("errors");
  });
});
