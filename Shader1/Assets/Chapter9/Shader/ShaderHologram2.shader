Shader "ShaderStudy/Test/Chapter9/ShaderHologram2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor ("RimColor", COLOR) = (1,1,1,1)
        _RimPower ("RimPower", Range(1,10)) = 1
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Opaque"="Transparent" }

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade

        sampler2D _MainTex;
        float4 _RimColor;
        float  _RimPower;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Emission = _RimColor;
            float rim = dot(o.Normal, IN.viewDir);
            
            o.Alpha = pow(1-rim,_RimPower) * abs(tan(_Time.y));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
