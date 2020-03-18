// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ColourReplacer"
{
	Properties
	{
		[Toggle]_ToggleSwitch0("Toggle Switch0", Float) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		_BlueTexture("Blue Texture", 2D) = "white" {}
		_RedTexture("Red Texture", 2D) = "white" {}
		_GreenTexture("Green Texture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _ToggleSwitch0;
		uniform sampler2D _BlueTexture;
		uniform float4 _BlueTexture_ST;
		uniform sampler2D _RedTexture;
		uniform float4 _RedTexture_ST;
		uniform sampler2D _GreenTexture;
		uniform float4 _GreenTexture_ST;
		uniform float _Float1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BlueTexture = i.uv_texcoord * _BlueTexture_ST.xy + _BlueTexture_ST.zw;
			float2 uv_RedTexture = i.uv_texcoord * _RedTexture_ST.xy + _RedTexture_ST.zw;
			float4 lerpResult58 = lerp( tex2D( _BlueTexture, uv_BlueTexture ) , tex2D( _RedTexture, uv_RedTexture ) , i.vertexColor.r);
			float2 uv_GreenTexture = i.uv_texcoord * _GreenTexture_ST.xy + _GreenTexture_ST.zw;
			float4 lerpResult59 = lerp( lerpResult58 , tex2D( _GreenTexture, uv_GreenTexture ) , i.vertexColor.g);
			float4 VertText61 = lerpResult59;
			o.Albedo = (( _ToggleSwitch0 )?( i.vertexColor ):( VertText61 )).rgb;
			float clampResult45 = clamp( ( i.vertexColor.r + _Float1 ) , 0.0 , 1.0 );
			o.Occlusion = clampResult45;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2104;140;1390;791;-1998.969;421.0716;1.3;True;False
Node;AmplifyShaderEditor.VertexColorNode;60;2208.129,-135.6373;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;2063.348,-515.7969;Inherit;True;Property;_BlueTexture;Blue Texture;11;0;Create;True;0;0;False;0;-1;None;9505d896bf2fcb042b0250d9b92b15b3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;56;2072.069,-324.8499;Inherit;True;Property;_RedTexture;Red Texture;12;0;Create;True;0;0;False;0;-1;None;e280124c74dc03f42b90c2fefd900752;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;75;2478.27,-10.6713;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;2489.536,-186.017;Inherit;True;Property;_GreenTexture;Green Texture;13;0;Create;True;0;0;False;0;-1;None;f7e96904e8667e1439548f0f86389447;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;58;2601.936,-323.5502;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;59;2904.879,-85.01022;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;3550.588,162.6647;Inherit;False;VertText;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;29;781.6027,-218.5333;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;934.0002,7.013489;Inherit;False;Property;_Float1;Float 1;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;1206,-121.9865;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;1424.315,-304.3751;Inherit;False;61;VertText;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;45;1462,-34.98651;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-3899.99,-302.7219;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;1392.665,-791.5818;Inherit;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;0.09706476;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;21;-3335.638,-338.0902;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;466.6;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCGrayscale;20;-2749.115,-246.4188;Inherit;True;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-353.5419,-361.0778;Inherit;False;Property;_Scale;Scale;8;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;8;-1864.185,-21.01612;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;7;-1854.185,-198.0162;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;517.0079,-601.4669;Inherit;False;Property;_HighlightBrightness;Highlight Brightness;9;0;Create;True;0;0;False;0;0;0.363;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;1392.665,-636.9954;Inherit;False;Constant;_Float3;Float 3;11;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-4280.497,-605.1678;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;b7cfceff4e904b341a00b0cce5fa1d20;b7cfceff4e904b341a00b0cce5fa1d20;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;46;1013.491,-129.2654;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1548.697,-35.32701;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;47;1786.817,-753.2481;Inherit;True;WaveyNoise;-1;;1;9dc2d18825a682f48bbca186d0eb3c42;2,115,0,106,1;9;121;FLOAT2;0,0;False;60;FLOAT;0.1;False;61;FLOAT;1;False;62;FLOAT;1;False;112;FLOAT;1;False;113;FLOAT;1;False;109;FLOAT;0.3;False;58;FLOAT;0.3;False;59;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-223.5419,-270.0778;Inherit;False;Property;_Falloff;Falloff;6;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;22;-3128.638,-347.0902;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-3903.5,-207.3896;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;63;2665.434,-954.2655;Inherit;False;Constant;_Color2;Color 2;14;0;Create;True;0;0;False;0;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;4;-4101.638,-283.2122;Inherit;False;Property;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;0,0.07;-4.1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;30;1076.603,-488.5333;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinTimeNode;53;1392.665,-550.4279;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;2665.434,-586.2655;Inherit;False;Constant;_Color4;Color 4;14;0;Create;True;0;0;False;0;0,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;34;-361.8419,-717.8776;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;False;0;None;e280124c74dc03f42b90c2fefd900752;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-200.5419,-366.0778;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;70;2665.434,-766.2655;Inherit;False;Constant;_Color3;Color 3;14;0;Create;True;0;0;False;0;0,1,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-2020.794,-26.07225;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;66;2977.434,-998.2655;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;67;2981.434,-787.2655;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;69;2981.434,-570.2655;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;17;-1682.985,-183.6942;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;41;-47.34595,-503.824;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;16;-2273.638,445.5555;Inherit;False;Property;_Color1;Color 1;4;0;Create;True;0;0;False;0;0.8901961,0,0.1058824,1;1,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-4371.521,-268.2122;Inherit;False;Property;_Color0;Color 0;3;0;Create;True;0;0;False;0;1,0,1,1;0,0.3087335,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;273.8632,-470.936;Inherit;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;False;0;-1;None;e280124c74dc03f42b90c2fefd900752;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;31;1590.603,-230.5333;Inherit;False;Property;_ToggleSwitch0;Toggle Switch0;7;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TransformPositionNode;35;-281.3743,-513.0107;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCCompareWithRange;9;-3653.253,-303.996;Inherit;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;24;-2485.774,-171.2723;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;818.6027,-570.5333;Inherit;False;2;2;0;FLOAT;0.3301887;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;50;1391.633,-714.2884;Inherit;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;11;-2035.737,-158.7966;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;1450.182,-908.9249;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1845.937,-301.7967;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;14;-1299.068,-19.42691;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1811.716,-243.254;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ColourReplacer;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;75;0;60;2
WireConnection;58;0;55;0
WireConnection;58;1;56;0
WireConnection;58;2;60;1
WireConnection;59;0;58;0
WireConnection;59;1;57;0
WireConnection;59;2;75;0
WireConnection;61;0;59;0
WireConnection;42;0;29;1
WireConnection;42;1;43;0
WireConnection;45;0;42;0
WireConnection;5;0;17;0
WireConnection;5;1;4;1
WireConnection;21;1;9;0
WireConnection;20;0;22;0
WireConnection;8;0;2;0
WireConnection;7;0;2;0
WireConnection;46;0;29;1
WireConnection;13;0;12;0
WireConnection;13;1;10;0
WireConnection;47;121;48;0
WireConnection;47;60;49;0
WireConnection;47;61;50;0
WireConnection;47;62;51;0
WireConnection;47;58;53;4
WireConnection;22;0;21;0
WireConnection;6;0;4;2
WireConnection;6;1;8;0
WireConnection;30;0;32;0
WireConnection;30;1;28;0
WireConnection;30;2;29;1
WireConnection;37;0;36;0
WireConnection;37;1;36;0
WireConnection;10;0;24;0
WireConnection;10;1;16;0
WireConnection;66;0;63;0
WireConnection;67;0;70;0
WireConnection;69;0;71;0
WireConnection;17;0;7;0
WireConnection;31;0;62;0
WireConnection;31;1;29;0
WireConnection;9;0;1;0
WireConnection;9;1;5;0
WireConnection;9;2;6;0
WireConnection;24;0;20;0
WireConnection;32;0;33;0
WireConnection;32;1;28;0
WireConnection;11;0;24;0
WireConnection;12;0;1;0
WireConnection;12;1;11;0
WireConnection;14;0;13;0
WireConnection;0;0;31;0
WireConnection;0;5;45;0
ASEEND*/
//CHKSM=A271E2C27E617CB56E2F8F3E6F207CA989053809