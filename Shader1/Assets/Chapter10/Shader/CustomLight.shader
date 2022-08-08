Shader "ShaderStudy/Test/Chapter10/CustomLight"
{
     Properties
    {
        _MainTex("Albedo (RGB)",2D) ="white"{}
        _BumpMap("Normalmap",2D)="bump"{}
        _SpceCol("Specular Color",Color) = (1,1,1,1)
        _SpecPow("Specular Power",Range(10,200)) = 100
        _GlossTex("Gloss Tex",2D) = "white"{}
        _RimColor("Rim Color",Color) =( 1,1,1,1)
        _RimPower("Rim Power",Range(-1,1)) = 1
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        
        #pragma surface surf Test noambient

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _GlossTex;
        float4  _SpecCol;
        float _SpecPow;
        float4 _RimColor;
        float _RimPower;



        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_GlossTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_GlossTex, IN.uv_GlossTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
            o.Gloss = d.a;
            o.Alpha = c.a;
        }

        float4 LightingTest (SurfaceOutput s, float3 lightDir, float viewDir, float atten)
        {
            float4 final;

            // Lambert term 
            float3 DiffColor;
            float ndot1 = saturate(dot(s.Normal, lightDir));
            DiffColor = ndot1 * s.Albedo * _LightColor0.rgb * atten;

            //Spec term 
            float3 SpecColor;
            float H = normalize(lightDir + viewDir);
            float spec = saturate(dot(H, s.Normal));
            spec = pow(spec, _SpecPow);
            SpecColor = spec * _SpecCol.rgb * s.Gloss;

            //Rim term
            float rim = abs(dot(viewDir, s.Normal));
            float invrim =1-rim;
            RimColor = pow(invrim,6) * float3(0.5,0.5,0.5);


            //fimal term 
            final.rgb = DiffColor.rgb + SpecColor.rgb;
            final.a = s.Alpha;
            return final;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
