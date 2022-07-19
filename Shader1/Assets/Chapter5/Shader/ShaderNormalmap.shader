Shader "ShaderStudy/Test/Chapter5/ShaderNormalmap"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Metallic("Metallic",Range(0,1)) = 0
        _Smoothness("Smoothness",Range(0,1)) = 0.5
        _Bumpmap("Normalmap",2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        sampler2D _Bumpmap;
        float _Metallic;
        float _Smoothness;


        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bumpmap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //1. o.Normal = UnpackNormal (tex2D (_Bumpmap, IN.uv_Bumpmap));
            //2.fixed4 d = tex2D(_Bumpmap, IN.uv_Bumpmap);
            //o.Normal = UnpackNormal(d);
            //3.fixed4 d = tex2D(_Bumpmap, IN.uv_Bumpmap);
            //o.Normal = float3(d.x*2, d.y*2, d.z);
            fixed4 d = tex2D(_Bumpmap, IN.uv_Bumpmap);
            o.Normal = UnpackNormal(d) * 3;
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
