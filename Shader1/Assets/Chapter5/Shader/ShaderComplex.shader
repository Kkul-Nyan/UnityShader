Shader "ShaderStudy/Test/Chapter5/ShaderComplex"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex3 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex4 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex5 ("Albedo (RGB)", 2D) = "white" {}
        
        _ComplexPower("Power",Range(0,3)) = 1
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Bumpmap ("Bumpmap",2D) = "Bump"{}
        _Occlusion("Occlusion",2D) = "white"{}
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard
         #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _MainTex3;
        sampler2D _MainTex4;
        sampler2D _MainTex5;
        sampler2D _Bumpmap;
        sampler2D _Occlusion;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_MainTex3;
            float2 uv_MainTex4;
            float2 uv_MainTex5;
            float2 uv_Bumpmap;

            float4 color:COLOR;
        };

        half _Glossiness;
        half _Metallic;

        float _ComplexPower;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 k = tex2D (_MainTex4, float2(IN.uv_MainTex5.x, IN.uv_MainTex5.y +(_Time.x * 3)));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2+k.b);
            fixed4 e = tex2D (_MainTex3, IN.uv_MainTex3);
            fixed4 f = tex2D (_MainTex4, IN.uv_MainTex4);
            fixed4 bump = tex2D (_Bumpmap, IN.uv_Bumpmap);
           
            o.Albedo = lerp(c.rgb, d.rgb, IN.color.r * _ComplexPower);
            o.Albedo = lerp(o.Albedo.rgb,e.rgb, IN.color.g * _ComplexPower);
            o.Albedo = lerp(o.Albedo.rgb,f.rgb, IN.color.b * _ComplexPower);
            o.Occlusion = tex2D(_Occlusion, IN.uv_MainTex);
            o.Metallic = _Metallic;
            o.Smoothness = (IN.color.b *0.5)*_Glossiness +0.3;
            o.Normal = UnpackNormal(bump);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
