const app = require("../../index");
const supertest = require("supertest");
const expect = require("chai").expect;
const mongooseSetup = require("../../utils/mongoose");

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

let validPayload = {
  idToken: "2857394y53kjrhs8ftiga",
  userName: "Default test userName",
  postType: "LOST",
  postTitle: "Default test post title",
  photos: "Photos go here",
  petType: "CAT",
  breed: "Default test breed",
  colour: { hexValue: 123, colourName: "Gold" },
  weight: "nfbhisdofijslk32498o",
  size: "Medium",
  dateLastSeen: "2023-08-08",
  locationLastSeen: {
    latitude: "49.14000670656538",
    longitude: "49.14000670656538",
    street: "12314 Abc Street",
    city: "Test city",
    regionalDistrict: "Test region",
    province: "Test province",
    country: "Test country",
    postalCode: "AHF 987",
  },
  description: "Default test description",
  contactEmail: "deafult@test.email",
  contactPhone: "1234567890",
};

describe("POST: /posts route to create post", () => {
  it("empty fields", async () => {
    const payload = {
      idToken: "",
      userName: "",
      postType: "",
      postTitle: "",
      photos: "",
      petType: "",
      breed: "",
      colour: { hexValue: "", colourName: "" },
      weight: "",
      size: "",
      dateLastSeen: "",
      locationLastSeen: {
        latitude: "",
        longitude: "",
        street: "",
        city: "",
        regionalDistrict: "",
        province: "",
        country: "",
        postalCode: "",
      },
      description: "",
      contactEmail: "",
      contactPhone: "",
    };

    const res = await supertest(app).post("/posts/").send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(20);
    expect(res.body.errors[0].path).to.equal("idToken");
  });

  it("valid fields", async () => {
    const payload = validPayload;

    const res = await supertest(app).post("/posts/").send(payload);
    expect(res.status).to.equal(400);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("error");
  });
});

describe("POST: /posts/:postId route to edit post", () => {
  it("empty fields", async () => {
    const postId = "postId";
    const payload = {
      idToken: "",
      userName: "",
      postType: "",
      postTitle: "",
      photos: "",
      petType: "",
      breed: "",
      colour: { hexValue: "", colourName: "" },
      weight: "",
      size: "",
      dateLastSeen: "",
      locationLastSeen: {
        latitude: "",
        longitude: "",
        street: "",
        city: "",
        regionalDistrict: "",
        province: "",
        country: "",
        postalCode: "",
      },
      description: "",
      contactEmail: "",
      contactPhone: "",
    };

    const res = await supertest(app)
      .post("/posts/" + postId)
      .send(payload);
    expect(res.status).to.equal(422);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("errors");
    expect(res.body.errors).to.have.length(20);
    expect(res.body.errors[0].path).to.equal("idToken");
  });

  it("valid fields", async () => {
    const postId = "postId";
    const payload = validPayload;

    const res = await supertest(app)
      .post("/posts/" + postId)
      .send(payload);
    expect(res.status).to.equal(400);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("error");
  });
});

describe("GET: /posts/:postId route to get post", () => {
  it("empty postId", async () => {
    const postId = "d";

    const res = await supertest(app)
      .get("/posts/" + postId)
    expect(res.status).to.equal(404);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("error");
  });

  it("invalid postId", async () => {
    const postId = "postId";

    const res = await supertest(app)
      .get("/posts/" + postId)
    expect(res.status).to.equal(404);
    expect(res.headers["content-type"]).to.have.string("json");
    expect(res.body).to.have.property("error");
  });
});
