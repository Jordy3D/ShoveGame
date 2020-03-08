// GENERATED AUTOMATICALLY FROM 'Assets/ShoveGame/PlayerControls.inputactions'

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;

public class @PlayerControls : IInputActionCollection, IDisposable
{
    public InputActionAsset asset { get; }
    public @PlayerControls()
    {
        asset = InputActionAsset.FromJson(@"{
    ""name"": ""PlayerControls"",
    ""maps"": [
        {
            ""name"": ""Gameplay"",
            ""id"": ""d3c87900-0550-4763-b601-f4997f5d9329"",
            ""actions"": [
                {
                    ""name"": ""Movement"",
                    ""type"": ""Value"",
                    ""id"": ""663cb94e-ede0-4f89-bced-e84277238a12"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Rotation"",
                    ""type"": ""Value"",
                    ""id"": ""f6e5a365-ddbe-4dad-b6d2-8a885a4b14b8"",
                    ""expectedControlType"": ""Stick"",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Jump"",
                    ""type"": ""Button"",
                    ""id"": ""bee5a223-5fcd-44b7-b033-b0ba43c3d8e3"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Fire"",
                    ""type"": ""Button"",
                    ""id"": ""47d56b16-f87d-455e-b26e-22ecfd2369a4"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Shield"",
                    ""type"": ""Button"",
                    ""id"": ""8e410bfc-7755-4585-b21f-61946d05beca"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""ShieldOff"",
                    ""type"": ""Button"",
                    ""id"": ""b02b2e09-4c94-400f-b190-dde74100e970"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                }
            ],
            ""bindings"": [
                {
                    ""name"": """",
                    ""id"": ""62291a7e-b6a0-4e3d-a9d0-97d46c7ea04c"",
                    ""path"": ""<Gamepad>/dpad"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Movement"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""4b60660b-ef2c-4595-8790-470c2562f239"",
                    ""path"": ""<Gamepad>/leftStick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Movement"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""37247136-7550-40d8-acbc-416a96f6ab7f"",
                    ""path"": ""<Gamepad>/rightStick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Rotation"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""5ab9338b-1df2-447e-abc0-97489c063980"",
                    ""path"": ""<Gamepad>/buttonSouth"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Jump"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""42df39e4-7747-4ff9-9a6f-6aae686f02e1"",
                    ""path"": ""<Gamepad>/rightTrigger"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Fire"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""1cfd2578-a05e-4cba-99f5-bf856ebf1512"",
                    ""path"": ""<Gamepad>/rightShoulder"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Fire"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""d2b30efb-3ce4-4bf2-b154-44ee5e142c7a"",
                    ""path"": ""<XInputController>/rightTrigger"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Fire"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""cb45d55c-36b8-475c-ad2f-4f6648e5313c"",
                    ""path"": ""<Gamepad>/leftTrigger"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Shield"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""cdad95d1-7b33-4d3b-9ce8-6dd7a0e0f63f"",
                    ""path"": ""<Gamepad>/leftShoulder"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Shield"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""ab6de9e9-8f0e-40d7-bb24-7f3e5b771839"",
                    ""path"": ""<XInputController>/leftTrigger"",
                    ""interactions"": ""Press"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Shield"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""ef6e9e5e-44c8-4dac-9405-66fd1f6e71cb"",
                    ""path"": ""<Gamepad>/leftTrigger"",
                    ""interactions"": ""Press(behavior=1)"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""ShieldOff"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""4b46f7e4-23e7-43a4-b788-fff6db6e3669"",
                    ""path"": ""<Gamepad>/leftShoulder"",
                    ""interactions"": ""Press(behavior=1)"",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""ShieldOff"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                }
            ]
        },
        {
            ""name"": ""Flight"",
            ""id"": ""c428f78d-0311-4b94-837b-78d27914aa44"",
            ""actions"": [
                {
                    ""name"": ""Stick"",
                    ""type"": ""Value"",
                    ""id"": ""adcf0b44-12d6-4e5f-bab1-912a75f9eb98"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""UnknownSlider"",
                    ""type"": ""Value"",
                    ""id"": ""63ca3438-838a-4152-a19c-412e6703ceb9"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""UpperThrottlePot"",
                    ""type"": ""Value"",
                    ""id"": ""8bb7c52f-54b3-4dd4-aae9-46fa07931e68"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""LowerThrottlePot"",
                    ""type"": ""Value"",
                    ""id"": ""db9cdaef-fc24-457a-b17c-c95de84b2215"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""StickTwist"",
                    ""type"": ""Value"",
                    ""id"": ""a2b8b295-8910-4322-828f-232af8884126"",
                    ""expectedControlType"": ""Axis"",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Throttle"",
                    ""type"": ""Button"",
                    ""id"": ""ff2116b7-03a8-40ee-83fd-8236b5d4063c"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Mode3"",
                    ""type"": ""Button"",
                    ""id"": ""909312be-e25f-4650-bbd1-02e8469555a5"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""Sensitivity"",
                    ""type"": ""Button"",
                    ""id"": ""d7b19a95-f058-454f-a43d-87fa61b66ec9"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""ButtonC"",
                    ""type"": ""Button"",
                    ""id"": ""2a91f55e-70ec-47c8-be59-9e424bc25ee9"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""ButtonB"",
                    ""type"": ""Button"",
                    ""id"": ""7f2e7929-c5dd-430d-b643-ea50ff483fad"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""ButtonA"",
                    ""type"": ""Button"",
                    ""id"": ""d353225e-a650-41ae-a884-5decc8ae8752"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""SafeFire"",
                    ""type"": ""Button"",
                    ""id"": ""8dae5975-500e-4eb2-b31f-1f403269de23"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""TriggerLight"",
                    ""type"": ""Button"",
                    ""id"": ""077fbbd8-dc37-4c06-b15f-566111bea4d9"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""TriggerHeavy"",
                    ""type"": ""Button"",
                    ""id"": ""b987aa69-be14-451c-ab6b-932dce5d8b3e"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""PinkySwitch"",
                    ""type"": ""Button"",
                    ""id"": ""ccc53df9-0706-4662-b684-6e8ed81ddabb"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""Mode2"",
                    ""type"": ""Button"",
                    ""id"": ""6f98eb31-8a36-4f26-8f74-38df43f71254"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""Mode1"",
                    ""type"": ""Button"",
                    ""id"": ""8a40bc13-2dd1-45fa-ba77-77624f539536"",
                    ""expectedControlType"": """",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""UpperDPadNorth"",
                    ""type"": ""Button"",
                    ""id"": ""b14ac3fd-f2b4-4dc6-90da-d55466760ab1"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""LowerDPadNorth"",
                    ""type"": ""Button"",
                    ""id"": ""fa2160f9-4d92-4387-b2fd-2030b28d628a"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""UpperDPadSouth"",
                    ""type"": ""Button"",
                    ""id"": ""e34e3020-0c9b-47ba-8819-19091c6ced68"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""LowerDPadSouth"",
                    ""type"": ""Button"",
                    ""id"": ""1c9c4753-f784-4d8d-8706-1bc7115001c8"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""UpperDPadEast"",
                    ""type"": ""Button"",
                    ""id"": ""ebc36fcc-c29a-41d4-a4fb-8b446154a118"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""LowerDPadEast"",
                    ""type"": ""Button"",
                    ""id"": ""628c425e-669d-47a0-a559-6a8dfa533f15"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""UpperDPadWest"",
                    ""type"": ""Button"",
                    ""id"": ""01558587-c5de-4b1c-a896-c203f0e25f60"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                },
                {
                    ""name"": ""LowerDPadWest"",
                    ""type"": ""Button"",
                    ""id"": ""2f21b355-0e4f-4acc-ace5-5d4b7b5717f7"",
                    ""expectedControlType"": ""Button"",
                    ""processors"": """",
                    ""interactions"": ""Press(behavior=2)""
                }
            ],
            ""bindings"": [
                {
                    ""name"": """",
                    ""id"": ""3cdd8267-931c-48e7-b500-10ab03e6ed52"",
                    ""path"": ""<Joystick>/stick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Stick"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""a6155ffa-5a10-4edf-b0fe-abb8aa8dc644"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/stick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Stick"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""ee422f74-21be-47d3-9509-dc2673716c3c"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/slider"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UnknownSlider"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""664e8899-a555-4f45-a7d6-20078e4dc4e9"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/ry"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UpperThrottlePot"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""eb36ad14-b218-495d-bfa8-e80da6740518"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/rx"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""LowerThrottlePot"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""d6bc0dcf-06df-41f4-b7cc-6f26a4fa22e7"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/rz"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""StickTwist"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""56e45112-cb4a-4055-b3c1-a1de0470d2fe"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/z"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Throttle"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""cc9669d2-467a-4502-92a0-8538b8c27ebe"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button26"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Mode3"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""b353e0ef-3b03-4b76-8101-ffc3c1bbfaca"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/slider"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Sensitivity"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""65380d7e-e33f-4e5a-8d99-4beed90c5083"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button5"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""ButtonC"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""051862a0-f69b-487b-8948-6417794395f8"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button4"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""ButtonB"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""a603c16e-2c35-44d8-868b-c7c77bcb6dc1"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button3"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""ButtonA"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""a1856d04-8629-4251-bffe-483f519a8e1f"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button2"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""SafeFire"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""191d5237-5617-4a4b-8dee-f3389a065ea8"",
                    ""path"": ""<Joystick>/trigger"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""TriggerLight"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""70de5dc5-d6ef-49db-9365-6f2fc97fb629"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button15"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""TriggerHeavy"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""a835a5db-7cb8-4a6e-9e43-6fd09e1f8924"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button6"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""PinkySwitch"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""7bb8c01a-c8fa-4a68-bee7-82fd71c2908a"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button25"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Mode2"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""71621d6f-8294-45f9-b10d-34a41a17f82f"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button24"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Mode1"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""68788065-f442-41ba-94ae-4f00d94c9d77"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button16"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UpperDPadNorth"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""985b3e57-450b-482d-afc1-f09dcb091055"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button18"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UpperDPadSouth"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""1aa4f0bb-29c6-4690-925f-54fa88933df9"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button17"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UpperDPadEast"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""6d66ea74-9adc-4baf-a450-3d167f6193a3"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/button19"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""UpperDPadWest"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""db22189d-a721-4fd6-ae76-839ef67cdb68"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/hat/left"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""LowerDPadWest"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""d15d7ce7-6855-4845-9e8e-d051b953d6ab"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/hat/right"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""LowerDPadEast"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""c76af69d-f6e7-4c75-b592-85362cbb584b"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/hat/down"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""LowerDPadSouth"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""02136e96-dc90-4d49-bf2e-b37edef60ebb"",
                    ""path"": ""<HID::Saitek Saitek X52 Flight Control System>/hat/up"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""LowerDPadNorth"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                }
            ]
        }
    ],
    ""controlSchemes"": []
}");
        // Gameplay
        m_Gameplay = asset.FindActionMap("Gameplay", throwIfNotFound: true);
        m_Gameplay_Movement = m_Gameplay.FindAction("Movement", throwIfNotFound: true);
        m_Gameplay_Rotation = m_Gameplay.FindAction("Rotation", throwIfNotFound: true);
        m_Gameplay_Jump = m_Gameplay.FindAction("Jump", throwIfNotFound: true);
        m_Gameplay_Fire = m_Gameplay.FindAction("Fire", throwIfNotFound: true);
        m_Gameplay_Shield = m_Gameplay.FindAction("Shield", throwIfNotFound: true);
        m_Gameplay_ShieldOff = m_Gameplay.FindAction("ShieldOff", throwIfNotFound: true);
        // Flight
        m_Flight = asset.FindActionMap("Flight", throwIfNotFound: true);
        m_Flight_Stick = m_Flight.FindAction("Stick", throwIfNotFound: true);
        m_Flight_UnknownSlider = m_Flight.FindAction("UnknownSlider", throwIfNotFound: true);
        m_Flight_UpperThrottlePot = m_Flight.FindAction("UpperThrottlePot", throwIfNotFound: true);
        m_Flight_LowerThrottlePot = m_Flight.FindAction("LowerThrottlePot", throwIfNotFound: true);
        m_Flight_StickTwist = m_Flight.FindAction("StickTwist", throwIfNotFound: true);
        m_Flight_Throttle = m_Flight.FindAction("Throttle", throwIfNotFound: true);
        m_Flight_Mode3 = m_Flight.FindAction("Mode3", throwIfNotFound: true);
        m_Flight_Sensitivity = m_Flight.FindAction("Sensitivity", throwIfNotFound: true);
        m_Flight_ButtonC = m_Flight.FindAction("ButtonC", throwIfNotFound: true);
        m_Flight_ButtonB = m_Flight.FindAction("ButtonB", throwIfNotFound: true);
        m_Flight_ButtonA = m_Flight.FindAction("ButtonA", throwIfNotFound: true);
        m_Flight_SafeFire = m_Flight.FindAction("SafeFire", throwIfNotFound: true);
        m_Flight_TriggerLight = m_Flight.FindAction("TriggerLight", throwIfNotFound: true);
        m_Flight_TriggerHeavy = m_Flight.FindAction("TriggerHeavy", throwIfNotFound: true);
        m_Flight_PinkySwitch = m_Flight.FindAction("PinkySwitch", throwIfNotFound: true);
        m_Flight_Mode2 = m_Flight.FindAction("Mode2", throwIfNotFound: true);
        m_Flight_Mode1 = m_Flight.FindAction("Mode1", throwIfNotFound: true);
        m_Flight_UpperDPadNorth = m_Flight.FindAction("UpperDPadNorth", throwIfNotFound: true);
        m_Flight_LowerDPadNorth = m_Flight.FindAction("LowerDPadNorth", throwIfNotFound: true);
        m_Flight_UpperDPadSouth = m_Flight.FindAction("UpperDPadSouth", throwIfNotFound: true);
        m_Flight_LowerDPadSouth = m_Flight.FindAction("LowerDPadSouth", throwIfNotFound: true);
        m_Flight_UpperDPadEast = m_Flight.FindAction("UpperDPadEast", throwIfNotFound: true);
        m_Flight_LowerDPadEast = m_Flight.FindAction("LowerDPadEast", throwIfNotFound: true);
        m_Flight_UpperDPadWest = m_Flight.FindAction("UpperDPadWest", throwIfNotFound: true);
        m_Flight_LowerDPadWest = m_Flight.FindAction("LowerDPadWest", throwIfNotFound: true);
    }

    public void Dispose()
    {
        UnityEngine.Object.Destroy(asset);
    }

    public InputBinding? bindingMask
    {
        get => asset.bindingMask;
        set => asset.bindingMask = value;
    }

    public ReadOnlyArray<InputDevice>? devices
    {
        get => asset.devices;
        set => asset.devices = value;
    }

    public ReadOnlyArray<InputControlScheme> controlSchemes => asset.controlSchemes;

    public bool Contains(InputAction action)
    {
        return asset.Contains(action);
    }

    public IEnumerator<InputAction> GetEnumerator()
    {
        return asset.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

    public void Enable()
    {
        asset.Enable();
    }

    public void Disable()
    {
        asset.Disable();
    }

    // Gameplay
    private readonly InputActionMap m_Gameplay;
    private IGameplayActions m_GameplayActionsCallbackInterface;
    private readonly InputAction m_Gameplay_Movement;
    private readonly InputAction m_Gameplay_Rotation;
    private readonly InputAction m_Gameplay_Jump;
    private readonly InputAction m_Gameplay_Fire;
    private readonly InputAction m_Gameplay_Shield;
    private readonly InputAction m_Gameplay_ShieldOff;
    public struct GameplayActions
    {
        private @PlayerControls m_Wrapper;
        public GameplayActions(@PlayerControls wrapper) { m_Wrapper = wrapper; }
        public InputAction @Movement => m_Wrapper.m_Gameplay_Movement;
        public InputAction @Rotation => m_Wrapper.m_Gameplay_Rotation;
        public InputAction @Jump => m_Wrapper.m_Gameplay_Jump;
        public InputAction @Fire => m_Wrapper.m_Gameplay_Fire;
        public InputAction @Shield => m_Wrapper.m_Gameplay_Shield;
        public InputAction @ShieldOff => m_Wrapper.m_Gameplay_ShieldOff;
        public InputActionMap Get() { return m_Wrapper.m_Gameplay; }
        public void Enable() { Get().Enable(); }
        public void Disable() { Get().Disable(); }
        public bool enabled => Get().enabled;
        public static implicit operator InputActionMap(GameplayActions set) { return set.Get(); }
        public void SetCallbacks(IGameplayActions instance)
        {
            if (m_Wrapper.m_GameplayActionsCallbackInterface != null)
            {
                @Movement.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnMovement;
                @Movement.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnMovement;
                @Movement.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnMovement;
                @Rotation.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnRotation;
                @Rotation.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnRotation;
                @Rotation.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnRotation;
                @Jump.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnJump;
                @Jump.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnJump;
                @Jump.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnJump;
                @Fire.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnFire;
                @Fire.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnFire;
                @Fire.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnFire;
                @Shield.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShield;
                @Shield.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShield;
                @Shield.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShield;
                @ShieldOff.started -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShieldOff;
                @ShieldOff.performed -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShieldOff;
                @ShieldOff.canceled -= m_Wrapper.m_GameplayActionsCallbackInterface.OnShieldOff;
            }
            m_Wrapper.m_GameplayActionsCallbackInterface = instance;
            if (instance != null)
            {
                @Movement.started += instance.OnMovement;
                @Movement.performed += instance.OnMovement;
                @Movement.canceled += instance.OnMovement;
                @Rotation.started += instance.OnRotation;
                @Rotation.performed += instance.OnRotation;
                @Rotation.canceled += instance.OnRotation;
                @Jump.started += instance.OnJump;
                @Jump.performed += instance.OnJump;
                @Jump.canceled += instance.OnJump;
                @Fire.started += instance.OnFire;
                @Fire.performed += instance.OnFire;
                @Fire.canceled += instance.OnFire;
                @Shield.started += instance.OnShield;
                @Shield.performed += instance.OnShield;
                @Shield.canceled += instance.OnShield;
                @ShieldOff.started += instance.OnShieldOff;
                @ShieldOff.performed += instance.OnShieldOff;
                @ShieldOff.canceled += instance.OnShieldOff;
            }
        }
    }
    public GameplayActions @Gameplay => new GameplayActions(this);

    // Flight
    private readonly InputActionMap m_Flight;
    private IFlightActions m_FlightActionsCallbackInterface;
    private readonly InputAction m_Flight_Stick;
    private readonly InputAction m_Flight_UnknownSlider;
    private readonly InputAction m_Flight_UpperThrottlePot;
    private readonly InputAction m_Flight_LowerThrottlePot;
    private readonly InputAction m_Flight_StickTwist;
    private readonly InputAction m_Flight_Throttle;
    private readonly InputAction m_Flight_Mode3;
    private readonly InputAction m_Flight_Sensitivity;
    private readonly InputAction m_Flight_ButtonC;
    private readonly InputAction m_Flight_ButtonB;
    private readonly InputAction m_Flight_ButtonA;
    private readonly InputAction m_Flight_SafeFire;
    private readonly InputAction m_Flight_TriggerLight;
    private readonly InputAction m_Flight_TriggerHeavy;
    private readonly InputAction m_Flight_PinkySwitch;
    private readonly InputAction m_Flight_Mode2;
    private readonly InputAction m_Flight_Mode1;
    private readonly InputAction m_Flight_UpperDPadNorth;
    private readonly InputAction m_Flight_LowerDPadNorth;
    private readonly InputAction m_Flight_UpperDPadSouth;
    private readonly InputAction m_Flight_LowerDPadSouth;
    private readonly InputAction m_Flight_UpperDPadEast;
    private readonly InputAction m_Flight_LowerDPadEast;
    private readonly InputAction m_Flight_UpperDPadWest;
    private readonly InputAction m_Flight_LowerDPadWest;
    public struct FlightActions
    {
        private @PlayerControls m_Wrapper;
        public FlightActions(@PlayerControls wrapper) { m_Wrapper = wrapper; }
        public InputAction @Stick => m_Wrapper.m_Flight_Stick;
        public InputAction @UnknownSlider => m_Wrapper.m_Flight_UnknownSlider;
        public InputAction @UpperThrottlePot => m_Wrapper.m_Flight_UpperThrottlePot;
        public InputAction @LowerThrottlePot => m_Wrapper.m_Flight_LowerThrottlePot;
        public InputAction @StickTwist => m_Wrapper.m_Flight_StickTwist;
        public InputAction @Throttle => m_Wrapper.m_Flight_Throttle;
        public InputAction @Mode3 => m_Wrapper.m_Flight_Mode3;
        public InputAction @Sensitivity => m_Wrapper.m_Flight_Sensitivity;
        public InputAction @ButtonC => m_Wrapper.m_Flight_ButtonC;
        public InputAction @ButtonB => m_Wrapper.m_Flight_ButtonB;
        public InputAction @ButtonA => m_Wrapper.m_Flight_ButtonA;
        public InputAction @SafeFire => m_Wrapper.m_Flight_SafeFire;
        public InputAction @TriggerLight => m_Wrapper.m_Flight_TriggerLight;
        public InputAction @TriggerHeavy => m_Wrapper.m_Flight_TriggerHeavy;
        public InputAction @PinkySwitch => m_Wrapper.m_Flight_PinkySwitch;
        public InputAction @Mode2 => m_Wrapper.m_Flight_Mode2;
        public InputAction @Mode1 => m_Wrapper.m_Flight_Mode1;
        public InputAction @UpperDPadNorth => m_Wrapper.m_Flight_UpperDPadNorth;
        public InputAction @LowerDPadNorth => m_Wrapper.m_Flight_LowerDPadNorth;
        public InputAction @UpperDPadSouth => m_Wrapper.m_Flight_UpperDPadSouth;
        public InputAction @LowerDPadSouth => m_Wrapper.m_Flight_LowerDPadSouth;
        public InputAction @UpperDPadEast => m_Wrapper.m_Flight_UpperDPadEast;
        public InputAction @LowerDPadEast => m_Wrapper.m_Flight_LowerDPadEast;
        public InputAction @UpperDPadWest => m_Wrapper.m_Flight_UpperDPadWest;
        public InputAction @LowerDPadWest => m_Wrapper.m_Flight_LowerDPadWest;
        public InputActionMap Get() { return m_Wrapper.m_Flight; }
        public void Enable() { Get().Enable(); }
        public void Disable() { Get().Disable(); }
        public bool enabled => Get().enabled;
        public static implicit operator InputActionMap(FlightActions set) { return set.Get(); }
        public void SetCallbacks(IFlightActions instance)
        {
            if (m_Wrapper.m_FlightActionsCallbackInterface != null)
            {
                @Stick.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnStick;
                @Stick.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnStick;
                @Stick.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnStick;
                @UnknownSlider.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUnknownSlider;
                @UnknownSlider.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUnknownSlider;
                @UnknownSlider.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUnknownSlider;
                @UpperThrottlePot.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperThrottlePot;
                @UpperThrottlePot.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperThrottlePot;
                @UpperThrottlePot.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperThrottlePot;
                @LowerThrottlePot.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerThrottlePot;
                @LowerThrottlePot.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerThrottlePot;
                @LowerThrottlePot.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerThrottlePot;
                @StickTwist.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnStickTwist;
                @StickTwist.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnStickTwist;
                @StickTwist.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnStickTwist;
                @Throttle.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnThrottle;
                @Throttle.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnThrottle;
                @Throttle.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnThrottle;
                @Mode3.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode3;
                @Mode3.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode3;
                @Mode3.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode3;
                @Sensitivity.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnSensitivity;
                @Sensitivity.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnSensitivity;
                @Sensitivity.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnSensitivity;
                @ButtonC.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonC;
                @ButtonC.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonC;
                @ButtonC.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonC;
                @ButtonB.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonB;
                @ButtonB.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonB;
                @ButtonB.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonB;
                @ButtonA.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonA;
                @ButtonA.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonA;
                @ButtonA.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnButtonA;
                @SafeFire.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnSafeFire;
                @SafeFire.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnSafeFire;
                @SafeFire.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnSafeFire;
                @TriggerLight.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerLight;
                @TriggerLight.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerLight;
                @TriggerLight.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerLight;
                @TriggerHeavy.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerHeavy;
                @TriggerHeavy.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerHeavy;
                @TriggerHeavy.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnTriggerHeavy;
                @PinkySwitch.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnPinkySwitch;
                @PinkySwitch.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnPinkySwitch;
                @PinkySwitch.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnPinkySwitch;
                @Mode2.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode2;
                @Mode2.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode2;
                @Mode2.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode2;
                @Mode1.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode1;
                @Mode1.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode1;
                @Mode1.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnMode1;
                @UpperDPadNorth.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadNorth;
                @UpperDPadNorth.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadNorth;
                @UpperDPadNorth.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadNorth;
                @LowerDPadNorth.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadNorth;
                @LowerDPadNorth.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadNorth;
                @LowerDPadNorth.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadNorth;
                @UpperDPadSouth.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadSouth;
                @UpperDPadSouth.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadSouth;
                @UpperDPadSouth.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadSouth;
                @LowerDPadSouth.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadSouth;
                @LowerDPadSouth.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadSouth;
                @LowerDPadSouth.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadSouth;
                @UpperDPadEast.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadEast;
                @UpperDPadEast.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadEast;
                @UpperDPadEast.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadEast;
                @LowerDPadEast.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadEast;
                @LowerDPadEast.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadEast;
                @LowerDPadEast.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadEast;
                @UpperDPadWest.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadWest;
                @UpperDPadWest.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadWest;
                @UpperDPadWest.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnUpperDPadWest;
                @LowerDPadWest.started -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadWest;
                @LowerDPadWest.performed -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadWest;
                @LowerDPadWest.canceled -= m_Wrapper.m_FlightActionsCallbackInterface.OnLowerDPadWest;
            }
            m_Wrapper.m_FlightActionsCallbackInterface = instance;
            if (instance != null)
            {
                @Stick.started += instance.OnStick;
                @Stick.performed += instance.OnStick;
                @Stick.canceled += instance.OnStick;
                @UnknownSlider.started += instance.OnUnknownSlider;
                @UnknownSlider.performed += instance.OnUnknownSlider;
                @UnknownSlider.canceled += instance.OnUnknownSlider;
                @UpperThrottlePot.started += instance.OnUpperThrottlePot;
                @UpperThrottlePot.performed += instance.OnUpperThrottlePot;
                @UpperThrottlePot.canceled += instance.OnUpperThrottlePot;
                @LowerThrottlePot.started += instance.OnLowerThrottlePot;
                @LowerThrottlePot.performed += instance.OnLowerThrottlePot;
                @LowerThrottlePot.canceled += instance.OnLowerThrottlePot;
                @StickTwist.started += instance.OnStickTwist;
                @StickTwist.performed += instance.OnStickTwist;
                @StickTwist.canceled += instance.OnStickTwist;
                @Throttle.started += instance.OnThrottle;
                @Throttle.performed += instance.OnThrottle;
                @Throttle.canceled += instance.OnThrottle;
                @Mode3.started += instance.OnMode3;
                @Mode3.performed += instance.OnMode3;
                @Mode3.canceled += instance.OnMode3;
                @Sensitivity.started += instance.OnSensitivity;
                @Sensitivity.performed += instance.OnSensitivity;
                @Sensitivity.canceled += instance.OnSensitivity;
                @ButtonC.started += instance.OnButtonC;
                @ButtonC.performed += instance.OnButtonC;
                @ButtonC.canceled += instance.OnButtonC;
                @ButtonB.started += instance.OnButtonB;
                @ButtonB.performed += instance.OnButtonB;
                @ButtonB.canceled += instance.OnButtonB;
                @ButtonA.started += instance.OnButtonA;
                @ButtonA.performed += instance.OnButtonA;
                @ButtonA.canceled += instance.OnButtonA;
                @SafeFire.started += instance.OnSafeFire;
                @SafeFire.performed += instance.OnSafeFire;
                @SafeFire.canceled += instance.OnSafeFire;
                @TriggerLight.started += instance.OnTriggerLight;
                @TriggerLight.performed += instance.OnTriggerLight;
                @TriggerLight.canceled += instance.OnTriggerLight;
                @TriggerHeavy.started += instance.OnTriggerHeavy;
                @TriggerHeavy.performed += instance.OnTriggerHeavy;
                @TriggerHeavy.canceled += instance.OnTriggerHeavy;
                @PinkySwitch.started += instance.OnPinkySwitch;
                @PinkySwitch.performed += instance.OnPinkySwitch;
                @PinkySwitch.canceled += instance.OnPinkySwitch;
                @Mode2.started += instance.OnMode2;
                @Mode2.performed += instance.OnMode2;
                @Mode2.canceled += instance.OnMode2;
                @Mode1.started += instance.OnMode1;
                @Mode1.performed += instance.OnMode1;
                @Mode1.canceled += instance.OnMode1;
                @UpperDPadNorth.started += instance.OnUpperDPadNorth;
                @UpperDPadNorth.performed += instance.OnUpperDPadNorth;
                @UpperDPadNorth.canceled += instance.OnUpperDPadNorth;
                @LowerDPadNorth.started += instance.OnLowerDPadNorth;
                @LowerDPadNorth.performed += instance.OnLowerDPadNorth;
                @LowerDPadNorth.canceled += instance.OnLowerDPadNorth;
                @UpperDPadSouth.started += instance.OnUpperDPadSouth;
                @UpperDPadSouth.performed += instance.OnUpperDPadSouth;
                @UpperDPadSouth.canceled += instance.OnUpperDPadSouth;
                @LowerDPadSouth.started += instance.OnLowerDPadSouth;
                @LowerDPadSouth.performed += instance.OnLowerDPadSouth;
                @LowerDPadSouth.canceled += instance.OnLowerDPadSouth;
                @UpperDPadEast.started += instance.OnUpperDPadEast;
                @UpperDPadEast.performed += instance.OnUpperDPadEast;
                @UpperDPadEast.canceled += instance.OnUpperDPadEast;
                @LowerDPadEast.started += instance.OnLowerDPadEast;
                @LowerDPadEast.performed += instance.OnLowerDPadEast;
                @LowerDPadEast.canceled += instance.OnLowerDPadEast;
                @UpperDPadWest.started += instance.OnUpperDPadWest;
                @UpperDPadWest.performed += instance.OnUpperDPadWest;
                @UpperDPadWest.canceled += instance.OnUpperDPadWest;
                @LowerDPadWest.started += instance.OnLowerDPadWest;
                @LowerDPadWest.performed += instance.OnLowerDPadWest;
                @LowerDPadWest.canceled += instance.OnLowerDPadWest;
            }
        }
    }
    public FlightActions @Flight => new FlightActions(this);
    public interface IGameplayActions
    {
        void OnMovement(InputAction.CallbackContext context);
        void OnRotation(InputAction.CallbackContext context);
        void OnJump(InputAction.CallbackContext context);
        void OnFire(InputAction.CallbackContext context);
        void OnShield(InputAction.CallbackContext context);
        void OnShieldOff(InputAction.CallbackContext context);
    }
    public interface IFlightActions
    {
        void OnStick(InputAction.CallbackContext context);
        void OnUnknownSlider(InputAction.CallbackContext context);
        void OnUpperThrottlePot(InputAction.CallbackContext context);
        void OnLowerThrottlePot(InputAction.CallbackContext context);
        void OnStickTwist(InputAction.CallbackContext context);
        void OnThrottle(InputAction.CallbackContext context);
        void OnMode3(InputAction.CallbackContext context);
        void OnSensitivity(InputAction.CallbackContext context);
        void OnButtonC(InputAction.CallbackContext context);
        void OnButtonB(InputAction.CallbackContext context);
        void OnButtonA(InputAction.CallbackContext context);
        void OnSafeFire(InputAction.CallbackContext context);
        void OnTriggerLight(InputAction.CallbackContext context);
        void OnTriggerHeavy(InputAction.CallbackContext context);
        void OnPinkySwitch(InputAction.CallbackContext context);
        void OnMode2(InputAction.CallbackContext context);
        void OnMode1(InputAction.CallbackContext context);
        void OnUpperDPadNorth(InputAction.CallbackContext context);
        void OnLowerDPadNorth(InputAction.CallbackContext context);
        void OnUpperDPadSouth(InputAction.CallbackContext context);
        void OnLowerDPadSouth(InputAction.CallbackContext context);
        void OnUpperDPadEast(InputAction.CallbackContext context);
        void OnLowerDPadEast(InputAction.CallbackContext context);
        void OnUpperDPadWest(InputAction.CallbackContext context);
        void OnLowerDPadWest(InputAction.CallbackContext context);
    }
}
