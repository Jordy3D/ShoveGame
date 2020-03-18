// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SimpleDoubleSided"
{
	Properties
	{
		_FrontColour("Front Colour", Color) = (0,0,0,0)
		_FrontTexture("Front Texture", 2D) = "white" {}
		[Toggle]_FrontColourTextureToggle("Front Colour/Texture Toggle", Float) = 0
		[Toggle]_RearDiffuseUniquenessToggle("Rear Diffuse Uniqueness Toggle", Float) = 0
		[Toggle]_RearNormalUniquenessToggle("Rear Normal Uniqueness Toggle", Float) = 0
		_RearColour("Rear Colour", Color) = (1,1,1,0)
		_RearTexture("Rear Texture", 2D) = "white" {}
		[Toggle]_RearColourTextureToggle("Rear Colour/Texture Toggle", Float) = 0
		_FrontNormal("Front Normal", 2D) = "white" {}
		_RearNormal("Rear Normal", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
		};

		uniform float _RearNormalUniquenessToggle;
		uniform sampler2D _FrontNormal;
		uniform float4 _FrontNormal_ST;
		uniform sampler2D _RearNormal;
		uniform float4 _RearNormal_ST;
		uniform float _RearDiffuseUniquenessToggle;
		uniform float _FrontColourTextureToggle;
		uniform sampler2D _FrontTexture;
		uniform float4 _FrontTexture_ST;
		uniform float4 _FrontColour;
		uniform float _RearColourTextureToggle;
		uniform sampler2D _RearTexture;
		uniform float4 _RearTexture_ST;
		uniform float4 _RearColour;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FrontNormal = i.uv_texcoord * _FrontNormal_ST.xy + _FrontNormal_ST.zw;
			float4 tex2DNode11 = tex2D( _FrontNormal, uv_FrontNormal );
			float2 uv_RearNormal = i.uv_texcoord * _RearNormal_ST.xy + _RearNormal_ST.zw;
			float4 switchResult13 = (((i.ASEVFace>0)?(tex2DNode11):(tex2D( _RearNormal, uv_RearNormal ))));
			float4 Normal15 = (( _RearNormalUniquenessToggle )?( switchResult13 ):( tex2DNode11 ));
			o.Normal = Normal15.rgb;
			float2 uv_FrontTexture = i.uv_texcoord * _FrontTexture_ST.xy + _FrontTexture_ST.zw;
			float2 uv_RearTexture = i.uv_texcoord * _RearTexture_ST.xy + _RearTexture_ST.zw;
			float4 switchResult2 = (((i.ASEVFace>0)?((( _FrontColourTextureToggle )?( _FrontColour ):( tex2D( _FrontTexture, uv_FrontTexture ) ))):((( _RearColourTextureToggle )?( _RearColour ):( tex2D( _RearTexture, uv_RearTexture ) )))));
			float4 Diffuse16 = (( _RearDiffuseUniquenessToggle )?( switchResult2 ):( (( _FrontColourTextureToggle )?( _FrontColour ):( tex2D( _FrontTexture, uv_FrontTexture ) )) ));
			o.Albedo = Diffuse16.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;2342.426;245.5413;1;True;False
Node;AmplifyShaderEditor.ColorNode;1;-1879.644,-38.49003;Inherit;False;Property;_FrontColour;Front Colour;0;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1973.745,-237.69;Inherit;True;Property;_FrontTexture;Front Texture;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1948.245,145.2099;Inherit;True;Property;_RearTexture;Rear Texture;6;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-1861.245,339.0101;Inherit;False;Property;_RearColour;Rear Colour;5;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;10;-1604.465,147.6761;Inherit;False;Property;_RearColourTextureToggle;Rear Colour/Texture Toggle;7;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;9;-1607.066,-107.124;Inherit;False;Property;_FrontColourTextureToggle;Front Colour/Texture Toggle;2;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;11;-1945.971,558.9407;Inherit;True;Property;_FrontNormal;Front Normal;8;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1951.171,751.3408;Inherit;True;Property;_RearNormal;Rear Normal;9;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;2;-1282.744,-6.790005;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;13;-1594.971,657.7415;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;4;-1057.74,-110.1737;Inherit;False;Property;_RearDiffuseUniquenessToggle;Rear Diffuse Uniqueness Toggle;3;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;14;-1367.471,564.1412;Inherit;False;Property;_RearNormalUniquenessToggle;Rear Normal Uniqueness Toggle;4;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-742.155,-109.344;Inherit;False;Diffuse;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-1047.725,570.1366;Inherit;False;Normal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;17;-61.0498,-230.4386;Inherit;False;16;Diffuse;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-60.40552,-155.6159;Inherit;False;15;Normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;136.5,-150.8;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SimpleDoubleSided;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;8;0
WireConnection;10;1;3;0
WireConnection;9;0;7;0
WireConnection;9;1;1;0
WireConnection;2;0;9;0
WireConnection;2;1;10;0
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;4;0;9;0
WireConnection;4;1;2;0
WireConnection;14;0;11;0
WireConnection;14;1;13;0
WireConnection;16;0;4;0
WireConnection;15;0;14;0
WireConnection;0;0;17;0
WireConnection;0;1;18;0
ASEEND*/
//CHKSM=426B80B64D9DF3ABE7029ED6C46D8F741B3B13D9