Shader "ShaderStudy/Test/Chapter8/ShaderCustomLightBasic"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        
        float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten)
        // Lighting + �Լ��̸� �����̾��� Ŀ���Ҷ���Ʈ �Լ��� �޾Ƶ鿩����. 
        // SurfaceOutput,lightDir,atten �ܿ��� Properties�� �Է¹��� ������ �Է°����� �����ü��ִ�. �̿ܿ��� ����Ҽ�����.
        // SurfaceOutput = Normal,Emission,Specular,Gloss,Alpha���� �����´�. �ٸ����δ� o.Albedo�ȿ� �־�� �� s.ALbedo�� �����ͼ� �����ִ�.
        // lightDir�� Normalized�ǰ�, �������� ���� ���̴�.
        // atten�� attenuation�� �ظ� �Ÿ��� �־�ķ� ������� �κ�
        // void�� �ƴ� float4�� ��ȯ�Ѵٰ� ���������� float4���� ��ȯ���ش�.
        { 
            return float4(1,1,0,1);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
