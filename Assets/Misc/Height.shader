// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Height"
{
	Properties
	{
		_TessPhongStrength( "Phong Tess Strength", Range( 0, 1 ) ) = 0.5
		_DiffuseTexture("Diffuse Texture", 2D) = "white" {}
		_Contrast("Contrast", Range( -10 , 0)) = -1.638255
		_HeightSharpness("Height Sharpness", Range( 0 , 10)) = 2
		_EmissionTexture("Emission Texture", 2D) = "white" {}
		_EmissionPanSpeed("Emission Pan Speed", Vector) = (0,0,0,0)
		_EmissionBrightnessSpeed("Emission Brightness Speed", Range( -1 , 10)) = 0
		_EmissionMinMaxBrightness("Emission Min/Max Brightness", Vector) = (0,0,0,0)
		_VertexDirection("Vertex Direction", Range( -1 , 1)) = 0
		_Tesselation("Tesselation", Range( 1 , 50)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction tessphong:_TessPhongStrength 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Contrast;
		uniform sampler2D _DiffuseTexture;
		uniform float4 _DiffuseTexture_ST;
		uniform float _HeightSharpness;
		uniform float _VertexDirection;
		uniform sampler2D _EmissionTexture;
		uniform float2 _EmissionPanSpeed;
		uniform float _EmissionBrightnessSpeed;
		uniform float2 _EmissionMinMaxBrightness;
		uniform float _Tesselation;
		uniform float _TessPhongStrength;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_1 = (_Tesselation).xxxx;
			return temp_cast_1;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 uv_DiffuseTexture = v.texcoord * _DiffuseTexture_ST.xy + _DiffuseTexture_ST.zw;
			float4 Diffuseg63 = tex2Dlod( _DiffuseTexture, float4( uv_DiffuseTexture, 0, 0.0) );
			float grayscale10_g4 = Luminance(( CalculateContrast((-10.0 + (1.0 - -1.0) * (20.0 - -10.0) / (1.0 - -1.0)),( 1.0 - CalculateContrast(_Contrast,Diffuseg63) )) * _HeightSharpness ).rgb);
			float clampResult11_g4 = clamp( grayscale10_g4 , 0.0 , 1.0 );
			float Height58 = clampResult11_g4;
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( Height58 * _VertexDirection * ase_vertexNormal );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_DiffuseTexture = i.uv_texcoord * _DiffuseTexture_ST.xy + _DiffuseTexture_ST.zw;
			float4 Diffuseg63 = tex2D( _DiffuseTexture, uv_DiffuseTexture );
			float2 panner50 = ( _Time.y * _EmissionPanSpeed + i.uv_texcoord);
			float4 EmissionTex56 = tex2D( _EmissionTexture, panner50 );
			float grayscale10_g4 = Luminance(( CalculateContrast((-10.0 + (1.0 - -1.0) * (20.0 - -10.0) / (1.0 - -1.0)),( 1.0 - CalculateContrast(_Contrast,Diffuseg63) )) * _HeightSharpness ).rgb);
			float clampResult11_g4 = clamp( grayscale10_g4 , 0.0 , 1.0 );
			float Height58 = clampResult11_g4;
			float temp_output_22_0 = ( 1.0 - Height58 );
			float4 temp_output_21_0 = ( EmissionTex56 * temp_output_22_0 );
			float4 lerpResult24 = lerp( Diffuseg63 , temp_output_21_0 , temp_output_22_0);
			o.Albedo = ( 1.0 * lerpResult24 ).rgb;
			o.Emission = ( temp_output_21_0 * (_EmissionMinMaxBrightness.x + (sin( ( _Time.y * _EmissionBrightnessSpeed ) ) - 0.0) * (_EmissionMinMaxBrightness.y - _EmissionMinMaxBrightness.x) / (1.0 - 0.0)) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
2073;116;1390;660;-209.9917;141.9077;1.261155;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-2045.655,-428.0587;Inherit;True;Property;_DiffuseTexture;Diffuse Texture;0;0;Create;True;0;0;False;0;-1;e280124c74dc03f42b90c2fefd900752;e280124c74dc03f42b90c2fefd900752;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;63;-1632.644,-344.5659;Inherit;False;Diffuseg;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1414.386,1014.933;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;53;-1411.946,1139.434;Inherit;False;Property;_EmissionPanSpeed;Emission Pan Speed;7;0;Create;True;0;0;False;0;0,0;0.04,0.06;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;51;-1407.781,1275.334;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1311.882,720.9995;Inherit;False;Property;_Contrast;Contrast;4;0;Create;True;0;0;False;0;-1.638255;-1.59;-10;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1315.248,800.8979;Inherit;False;Property;_HeightSharpness;Height Sharpness;5;0;Create;True;0;0;False;0;2;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;65;-1209.309,641.7039;Inherit;False;63;Diffuseg;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;50;-1127.725,1129.351;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;69;-952.2465,712.9761;Inherit;False;HeightFromTexture;1;;4;5212fa4bb062b9847bd4845fd9d7b7d6;0;3;15;COLOR;-1.6,0,0,0;False;14;FLOAT;-1.6;False;13;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;48;-879.2651,1132.617;Inherit;True;Property;_EmissionTexture;Emission Texture;6;0;Create;True;0;0;False;0;-1;None;f7e96904e8667e1439548f0f86389447;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-721.2666,712.0219;Inherit;False;Height;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-514.8684,1175.202;Inherit;False;EmissionTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;521.9207,199.9776;Inherit;False;58;Height;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;523.0295,345.6995;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;421.2173,419.7565;Inherit;False;Property;_EmissionBrightnessSpeed;Emission Brightness Speed;8;0;Create;True;0;0;False;0;0;1;-1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;22;699.0646,199.4405;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;637.7832,3.759193;Inherit;False;56;EmissionTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;693.5311,341.6657;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;35;821.3591,343.0171;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;64;905.3251,-71.15674;Inherit;False;63;Diffuseg;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;70;1054.1,197.7382;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;864.2221,10.15192;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;37;424.4183,495.794;Inherit;False;Property;_EmissionMinMaxBrightness;Emission Min/Max Brightness;9;0;Create;True;0;0;False;0;0,0;0.5,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NormalVertexDataNode;46;1164.404,625.1942;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;1096.661,-81.76191;Inherit;False;Constant;_Float4;Float 4;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1061.304,536.4941;Inherit;False;Property;_VertexDirection;Vertex Direction;10;0;Create;True;0;0;False;0;0;0.1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1170.765,455.5499;Inherit;False;58;Height;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;24;1139.448,0.388252;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;947.5878,336.7856;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;1165.994,222.7151;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;1401.404,412.1942;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;43;1333.804,685.394;Inherit;False;Property;_Tesselation;Tesselation;11;0;Create;True;0;0;False;0;0;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1431.782,-15.34119;Inherit;False;2;2;0;FLOAT;1;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1678.171,99.98318;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Height;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;True;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;63;0;1;0
WireConnection;50;0;49;0
WireConnection;50;2;53;0
WireConnection;50;1;51;0
WireConnection;69;15;65;0
WireConnection;69;14;5;0
WireConnection;69;13;55;0
WireConnection;48;1;50;0
WireConnection;58;0;69;0
WireConnection;56;0;48;0
WireConnection;22;0;59;0
WireConnection;33;0;32;0
WireConnection;33;1;30;0
WireConnection;35;0;33;0
WireConnection;70;0;22;0
WireConnection;21;0;57;0
WireConnection;21;1;22;0
WireConnection;24;0;64;0
WireConnection;24;1;21;0
WireConnection;24;2;70;0
WireConnection;36;0;35;0
WireConnection;36;3;37;1
WireConnection;36;4;37;2
WireConnection;29;0;21;0
WireConnection;29;1;36;0
WireConnection;44;0;60;0
WireConnection;44;1;45;0
WireConnection;44;2;46;0
WireConnection;39;0;38;0
WireConnection;39;1;24;0
WireConnection;0;0;39;0
WireConnection;0;2;29;0
WireConnection;0;11;44;0
WireConnection;0;14;43;0
ASEEND*/
//CHKSM=BE1157EC629D6FC6F4466EE54A9582EF0C8F05D9