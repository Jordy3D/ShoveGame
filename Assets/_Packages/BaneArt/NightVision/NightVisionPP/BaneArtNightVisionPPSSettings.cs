// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( BaneArtNightVisionPPSRenderer ), PostProcessEvent.AfterStack, "BaneArtNightVision", true )]
public sealed class BaneArtNightVisionPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "NightVisEnable" )]
  [Range(0,1)]
	public IntParameter _NightVisEnable = new IntParameter { value = 0 };
	[Tooltip( "Color 0" )]
	public ColorParameter _Color0 = new ColorParameter { value = new Color(0f,1f,0f,1f) };
}

public sealed class BaneArtNightVisionPPSRenderer : PostProcessEffectRenderer<BaneArtNightVisionPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "BaneArt/NightVision" ) );
		sheet.properties.SetInt( "_NightVisEnable", settings._NightVisEnable );
		sheet.properties.SetColor( "_Color0", settings._Color0 );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
