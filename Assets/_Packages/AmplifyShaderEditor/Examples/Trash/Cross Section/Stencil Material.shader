// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Stencil Material"
{
	Properties
	{
		_PlaneNormal("PlaneNormal", Vector) = (0,1,0,0)
		_Color0("Color 0", Color) = (0.1517085,0.4035856,0.8970588,0)
		_PlanePosition("PlanePosition", Vector) = (0,0,0,0)
		_Cutoff( "Mask Clip Value", Float ) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		Stencil
		{
			Ref 255
			CompFront Always
			PassFront Zero
			CompBack Always
			PassBack Replace
		}
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color0;
		uniform float3 _PlanePosition;
		uniform float3 _PlaneNormal;
		uniform float _Cutoff = 0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color0.rgb;
			o.Smoothness = 0.5;
			o.Alpha = 1;
			float3 ase_worldPos = i.worldPos;
			float dotResult60 = dot( ( ase_worldPos - _PlanePosition ) , _PlaneNormal );
			clip( dotResult60 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
1972;43;1049;728;849.6129;152.8209;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;56;-828.1932,68.65564;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;58;-814.0646,217.0081;Float;False;Property;_PlanePosition;PlanePosition;2;0;Create;True;0;0;False;0;0,0,0;0,0.997,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;59;-588.2866,109.3668;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;61;-751.5369,371.1167;Float;False;Property;_PlaneNormal;PlaneNormal;0;0;Create;True;0;0;False;0;0,1,0;-0.03853044,-0.9982362,0.04516783;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;60;-418.1093,190.8911;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;54;-424.7802,-38.51082;Float;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.1517085,0.4035856,0.8970588,0;0,0.06355508,0.1886792,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-182.6129,118.6791;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Stencil Material;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;255;False;-1;255;False;-1;255;False;-1;7;False;-1;2;False;-1;0;False;-1;0;False;-1;7;False;-1;3;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;3;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;59;0;56;0
WireConnection;59;1;58;0
WireConnection;60;0;59;0
WireConnection;60;1;61;0
WireConnection;0;0;54;0
WireConnection;0;4;62;0
WireConnection;0;10;60;0
ASEEND*/
//CHKSM=6E4F7CA1337BF1506203178FFECD906939F34803