Shader "ShaderStudy/Test/Chapter9/ShaderHologram"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor("RimColor",COLOR) = (1,1,1,1)
        _RimPower("RimPower",Range(1,10)) = 1
        _BumpMap("BumpMap",2D) = "bump"{}

    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Opaque"="Transparent"}

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float4 _RimColor;
        float _RimPower;


        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb;
            o.Emission = _RimColor.rgb; 
            o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
            float rim = saturate(dot(o.Normal, IN.viewDir));
            
            //o.Alpha = pow(1-rim, _RimPower) * (sin(_Time.y) * 0.5 + 0.5);
            //o.Alpha = pow(1-rim, _RimPower) * sin(_Time.y);
            o.Alpha = pow(1-rim, _RimPower) * abs(sin(_Time.y * 3));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
