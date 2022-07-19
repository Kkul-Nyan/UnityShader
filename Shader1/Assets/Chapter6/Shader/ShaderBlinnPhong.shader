Shader "ShaderStudy/Test/Chapter6/ShaderBlinnPhong"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
        _SpecColor("Specular Color", color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf BlinnPhong

        sampler2D _MainTex;
        // float4 _SpecColor �� ���� ������ BlinnPhong ���ο��� �ڵ����� �ް� �ֱ� �����̴�. ������ �����ָ� ������ ����.
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Specular = 0.5; //0~1����,Specular�� ũ�⸦ �ǹ��ϳ�. 0�ϼ��� Ŀ����, 1�ϼ��� �۾����� 
            o.Gloss = 1; //0~1����,Specular�� ������ �ǹ��Ѵ�. 0�̸� ��Ź, 1�̸� �Ų��������� 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
