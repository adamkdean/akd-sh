---

In your WebAPI project's web.config, put in the following:

    <httpProtocol>
        <customHeaders>
            <add name="Access-Control-Allow-Origin" value="*" />
            <add name="Access-Control-Allow-Headers" value="Origin, X-Requested-With, Content-Type, Accept" />
        </customHeaders>
    </httpProtocol>

This will enable cross-origin resource sharing (CORS) and allow you to get back to work.