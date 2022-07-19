Shader "ShaderStudy/Test/Chapter8/ShaderHalfLambert1"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Bumpmap ("Bump",2D) = "Bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient

        sampler2D _MainTex;
        sampler2D _Bumpmap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bumpmap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_Bumpmap, IN.uv_Bumpmap);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(d);
            o.Alpha = c.a;
        }

        float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten)
        {
            float4 ndot1 =dot(s.Normal, lightDir) * 0.5 + 0.5;
            return pow(ndot1,3);
            //pow(X,n) => XÀÇ nÁ¦°ö±Ù
        }

        ENDCG
    }
    FallBack "Diffuse"
}
