describe "Library constructor", ->
  overloadableFunc = null
  propertyList = null;

  beforeEach(->
    overloadableFunc = new Overloadable()
    propertyList = ['_inheritFromOverloadable']
  )

  it("should have all the properties non-enumerable", ->
    expect(Object.keys(Overloadable)).toEqual([])
  )

  it("should have all the properties non-configurable", ->
    for property in propertyList
      expect(->
        Object.defineProperty Overloadable, property,
          enumerable: true
      ).toThrow()

    expect(Object.keys(Overloadable)).toEqual([])
  )

  it("should have all the properties non-writable", ->
    for property in propertyList
      oldValue = Overloadable[property]
      Overloadable[property] = null
      expect(Overloadable[property]).toEqual(oldValue)
  )

  describe(".prototype", ->
    beforeEach(->
      propertyList = ["_invoke", "match", "overload"]
    )
    
    it("should have all the properties non-enumerable", ->
      expect(Object.keys(Overloadable.prototype)).toEqual([])
    )

    it("should have all the properties non-configurable", ->
      for property in propertyList
        expect(->
          Object.defineProperty Overloadable.prototype, property,
            enumerable: true
        ).toThrow()

      expect(Object.keys(Overloadable.prototype)).toEqual([])
    )

    it("should have all the properties non-writable", ->
      for property in propertyList
        oldValue = Overloadable.prototype[property]
        Overloadable.prototype[property] = null
        expect(Overloadable.prototype[property]).toEqual(oldValue)
    )
  )

  it("should construct a function", ->
    expect(typeof overloadableFunc).toBe("function")
  )

  describe("Constructed functions", ->
    it("should have a proper public api", ->
      publicApi = ["overload", "match"]
      for method in publicApi
        expect(typeof overloadableFunc[method]).toBe("function")
    )
  )
  describe("Default function", ->
    it("should not throw when default function is a function", ->
      expect(->
        new Overloadable(->)
      ).not.toThrow()
    )

    it("should not throw when default function is null", ->
      expect(->
        new Overloadable(null)
      ).not.toThrow()
    )

    it("should not throw when default function is undefined", ->
      expect(->
        new Overloadable()
      ).not.toThrow()
    )
  )
