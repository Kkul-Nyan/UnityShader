Shader "ShaderStudy/Test/Chapter5/ShaderOcclusion"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Bumpmap("Bumpmap", 2D) = "Bump"{}
        _Occlusion("Occlusion",2D) ="white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _Bumpmap;
        sampler2D _Occlusion;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bumpmap;
           // float2 uv_Occlusion; occlusion은 독립된  uv값을 받지못한다. 오류터진다.
        };

        half _Glossiness;
        half _Metallic;


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_Bumpmap, IN.uv_Bumpmap);
            o.Occlusion = tex2D(_Occlusion, IN.uv_MainTex);
            o.Normal = UnpackNormal(d);
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
