declare extern type EnumItem with
    read Name: string
    read FullName: string
    read EnumType: string
end

declare extern type EnumControllerKeyCode extends EnumItem with end

declare extern type EnumControllerKeyCodeItems with
    function GetEnumItems(self): {EnumControllerKeyCode}
    read CraftspersonKey1: EnumControllerKeyCode
    read CraftspersonKey2: EnumControllerKeyCode
    read CraftspersonKey3: EnumControllerKeyCode
    read CraftspersonKey4: EnumControllerKeyCode
    read CraftspersonKey5: EnumControllerKeyCode
    read CraftspersonKey6: EnumControllerKeyCode
    read CraftspersonKey7: EnumControllerKeyCode
    read CraftspersonKey8: EnumControllerKeyCode
    read CraftspersonKey9: EnumControllerKeyCode
    read CraftspersonKey10: EnumControllerKeyCode
    read CraftspersonKey11: EnumControllerKeyCode
    read CraftspersonKey12: EnumControllerKeyCode
    read CraftspersonKey13: EnumControllerKeyCode
    read CraftspersonKey14: EnumControllerKeyCode
    read SprintKey: EnumControllerKeyCode
    read JumpKey: EnumControllerKeyCode
    read InteractKey: EnumControllerKeyCode
    read NormalAttackKey: EnumControllerKeyCode
    read CharacterSkill1Key: EnumControllerKeyCode
    read CharacterSkill2Key: EnumControllerKeyCode
    read CharacterSkill3Key: EnumControllerKeyCode
    read CharacterSkill4Key: EnumControllerKeyCode
    read MenuConfirmKey: EnumControllerKeyCode
    read MenuBackKey: EnumControllerKeyCode
    read None: EnumControllerKeyCode
end

declare extern type EnumControllerNavigationDir extends EnumItem with end

declare extern type EnumControllerNavigationDirItems with
    function GetEnumItems(self): {EnumControllerNavigationDir}
    read Up: EnumControllerNavigationDir
    read Down: EnumControllerNavigationDir
    read Left: EnumControllerNavigationDir
    read Right: EnumControllerNavigationDir
end

declare extern type EnumControllerNavigationEventType extends EnumItem with end

declare extern type EnumControllerNavigationEventTypeItems with
    function GetEnumItems(self): {EnumControllerNavigationEventType}
    read Confirm: EnumControllerNavigationEventType
    read Cancel: EnumControllerNavigationEventType
    read Focus: EnumControllerNavigationEventType
    read LostFocus: EnumControllerNavigationEventType
    read RightStickUp: EnumControllerNavigationEventType
    read RightStickDown: EnumControllerNavigationEventType
    read RightStickRight: EnumControllerNavigationEventType
    read RightStickLeft: EnumControllerNavigationEventType
    read LeftStickUp: EnumControllerNavigationEventType
    read LeftStickDown: EnumControllerNavigationEventType
    read LeftStickRight: EnumControllerNavigationEventType
    read LeftStickLeft: EnumControllerNavigationEventType
end

declare extern type EnumControllerNavigationMode extends EnumItem with end

declare extern type EnumControllerNavigationModeItems with
    function GetEnumItems(self): {EnumControllerNavigationMode}
    read None: EnumControllerNavigationMode
    read NearestControl: EnumControllerNavigationMode
    read Specified: EnumControllerNavigationMode
end

declare extern type EnumCursorEventType extends EnumItem with end

declare extern type EnumCursorEventTypeItems with
    function GetEnumItems(self): {EnumCursorEventType}
    read CursorDown: EnumCursorEventType
    read CursorUp: EnumCursorEventType
    read CursorEnter: EnumCursorEventType
    read CursorExit: EnumCursorEventType
    read CursorDrag: EnumCursorEventType
    read CursorBeginDrag: EnumCursorEventType
    read CursorEndDrag: EnumCursorEventType
    read CursorClick: EnumCursorEventType
end

declare extern type EnumCustomVariableEntityType extends EnumItem with end

declare extern type EnumCustomVariableEntityTypeItems with
    function GetEnumItems(self): {EnumCustomVariableEntityType}
    read Level: EnumCustomVariableEntityType
    read PlayerSelf: EnumCustomVariableEntityType
    read AvatarSelf: EnumCustomVariableEntityType
end

declare extern type EnumDevice extends EnumItem with end

declare extern type EnumDeviceItems with
    function GetEnumItems(self): {EnumDevice}
    read KeyboardAndMouse: EnumDevice
    read Mobile: EnumDevice
    read Controller: EnumDevice
    read MobileController: EnumDevice
end

declare extern type EnumEaseType extends EnumItem with end

declare extern type EnumEaseTypeItems with
    function GetEnumItems(self): {EnumEaseType}
    read Linear: EnumEaseType
    read InSine: EnumEaseType
    read OutSine: EnumEaseType
    read InOutSine: EnumEaseType
    read InQuad: EnumEaseType
    read OutQuad: EnumEaseType
    read InOutQuad: EnumEaseType
    read InCubic: EnumEaseType
    read OutCubic: EnumEaseType
    read InOutCubic: EnumEaseType
    read InQuart: EnumEaseType
    read OutQuart: EnumEaseType
    read InOutQuart: EnumEaseType
    read InQuint: EnumEaseType
    read OutQuint: EnumEaseType
    read InOutQuint: EnumEaseType
    read InExpo: EnumEaseType
    read OutExpo: EnumEaseType
    read InOutExpo: EnumEaseType
    read InCirc: EnumEaseType
    read OutCirc: EnumEaseType
    read InOutCirc: EnumEaseType
    read InBack: EnumEaseType
    read OutBack: EnumEaseType
    read InOutBack: EnumEaseType
    read InElastic: EnumEaseType
    read OutElastic: EnumEaseType
    read InOutElastic: EnumEaseType
    read InBounce: EnumEaseType
    read OutBounce: EnumEaseType
    read InOutBounce: EnumEaseType
end

declare extern type EnumImageFillHorizontalType extends EnumItem with end

declare extern type EnumImageFillHorizontalTypeItems with
    function GetEnumItems(self): {EnumImageFillHorizontalType}
    read Left: EnumImageFillHorizontalType
    read Right: EnumImageFillHorizontalType
end

declare extern type EnumImageFillRadial90Type extends EnumItem with end

declare extern type EnumImageFillRadial90TypeItems with
    function GetEnumItems(self): {EnumImageFillRadial90Type}
    read BottomLeft: EnumImageFillRadial90Type
    read TopLeft: EnumImageFillRadial90Type
    read TopRight: EnumImageFillRadial90Type
    read BottomRight: EnumImageFillRadial90Type
end

declare extern type EnumImageFillRadialType extends EnumItem with end

declare extern type EnumImageFillRadialTypeItems with
    function GetEnumItems(self): {EnumImageFillRadialType}
    read Bottom: EnumImageFillRadialType
    read Left: EnumImageFillRadialType
    read Top: EnumImageFillRadialType
    read Right: EnumImageFillRadialType
end

declare extern type EnumImageFillType extends EnumItem with end

declare extern type EnumImageFillTypeItems with
    function GetEnumItems(self): {EnumImageFillType}
    read Unused: EnumImageFillType
    read Horizontal: EnumImageFillType
    read Vertical: EnumImageFillType
    read Radial90: EnumImageFillType
    read Radial180: EnumImageFillType
    read Radial360: EnumImageFillType
end

declare extern type EnumImageFillVerticalType extends EnumItem with end

declare extern type EnumImageFillVerticalTypeItems with
    function GetEnumItems(self): {EnumImageFillVerticalType}
    read Bottom: EnumImageFillVerticalType
    read Top: EnumImageFillVerticalType
end

declare extern type EnumImageMaskSoftEdgeMode extends EnumItem with end

declare extern type EnumImageMaskSoftEdgeModeItems with
    function GetEnumItems(self): {EnumImageMaskSoftEdgeMode}
    read Percentage: EnumImageMaskSoftEdgeMode
    read Pixel: EnumImageMaskSoftEdgeMode
end

declare extern type EnumImageSource extends EnumItem with end

declare extern type EnumImageSourceItems with
    function GetEnumItems(self): {EnumImageSource}
    read StaticReference: EnumImageSource
    read Item: EnumImageSource
    read Equipment: EnumImageSource
    read Skill: EnumImageSource
    read UnitStatus: EnumImageSource
    read Faction: EnumImageSource
    read Currency: EnumImageSource
    read Prefab: EnumImageSource
end

declare extern type EnumImageType extends EnumItem with end

declare extern type EnumImageTypeItems with
    function GetEnumItems(self): {EnumImageType}
    read Basic: EnumImageType
    read Stretch: EnumImageType
end

declare extern type EnumKeyEventType extends EnumItem with end

declare extern type EnumKeyEventTypeItems with
    function GetEnumItems(self): {EnumKeyEventType}
    read KeyboardCraftspersonKey1Down: EnumKeyEventType
    read KeyboardCraftspersonKey1Up: EnumKeyEventType
    read KeyboardCraftspersonKey2Down: EnumKeyEventType
    read KeyboardCraftspersonKey2Up: EnumKeyEventType
    read KeyboardCraftspersonKey3Down: EnumKeyEventType
    read KeyboardCraftspersonKey3Up: EnumKeyEventType
    read KeyboardCraftspersonKey4Down: EnumKeyEventType
    read KeyboardCraftspersonKey4Up: EnumKeyEventType
    read KeyboardCraftspersonKey5Down: EnumKeyEventType
    read KeyboardCraftspersonKey5Up: EnumKeyEventType
    read KeyboardCraftspersonKey6Down: EnumKeyEventType
    read KeyboardCraftspersonKey6Up: EnumKeyEventType
    read KeyboardCraftspersonKey7Down: EnumKeyEventType
    read KeyboardCraftspersonKey7Up: EnumKeyEventType
    read KeyboardCraftspersonKey8Down: EnumKeyEventType
    read KeyboardCraftspersonKey8Up: EnumKeyEventType
    read KeyboardCraftspersonKey9Down: EnumKeyEventType
    read KeyboardCraftspersonKey9Up: EnumKeyEventType
    read KeyboardCraftspersonKey10Down: EnumKeyEventType
    read KeyboardCraftspersonKey10Up: EnumKeyEventType
    read KeyboardCraftspersonKey11Down: EnumKeyEventType
    read KeyboardCraftspersonKey11Up: EnumKeyEventType
    read KeyboardCraftspersonKey12Down: EnumKeyEventType
    read KeyboardCraftspersonKey12Up: EnumKeyEventType
    read KeyboardCraftspersonKey13Down: EnumKeyEventType
    read KeyboardCraftspersonKey13Up: EnumKeyEventType
    read KeyboardCraftspersonKey14Down: EnumKeyEventType
    read KeyboardCraftspersonKey14Up: EnumKeyEventType
    read KeyboardCraftspersonKey15Down: EnumKeyEventType
    read KeyboardCraftspersonKey15Up: EnumKeyEventType
    read KeyboardCraftspersonKey16Down: EnumKeyEventType
    read KeyboardCraftspersonKey16Up: EnumKeyEventType
    read KeyboardCraftspersonKey17Down: EnumKeyEventType
    read KeyboardCraftspersonKey17Up: EnumKeyEventType
    read KeyboardCraftspersonKey18Down: EnumKeyEventType
    read KeyboardCraftspersonKey18Up: EnumKeyEventType
    read KeyboardCraftspersonKey19Down: EnumKeyEventType
    read KeyboardCraftspersonKey19Up: EnumKeyEventType
    read KeyboardCraftspersonKey20Down: EnumKeyEventType
    read KeyboardCraftspersonKey20Up: EnumKeyEventType
    read KeyboardCraftspersonKey21Down: EnumKeyEventType
    read KeyboardCraftspersonKey21Up: EnumKeyEventType
    read KeyboardCraftspersonKey22Down: EnumKeyEventType
    read KeyboardCraftspersonKey22Up: EnumKeyEventType
    read KeyboardCraftspersonKey23Down: EnumKeyEventType
    read KeyboardCraftspersonKey23Up: EnumKeyEventType
    read KeyboardCraftspersonKey24Down: EnumKeyEventType
    read KeyboardCraftspersonKey24Up: EnumKeyEventType
    read KeyboardCraftspersonKey25Down: EnumKeyEventType
    read KeyboardCraftspersonKey25Up: EnumKeyEventType
    read KeyboardCraftspersonKey26Down: EnumKeyEventType
    read KeyboardCraftspersonKey26Up: EnumKeyEventType
    read KeyboardCraftspersonKey27Down: EnumKeyEventType
    read KeyboardCraftspersonKey27Up: EnumKeyEventType
    read KeyboardCraftspersonKey28Down: EnumKeyEventType
    read KeyboardCraftspersonKey28Up: EnumKeyEventType
    read KeyboardCraftspersonKey29Down: EnumKeyEventType
    read KeyboardCraftspersonKey29Up: EnumKeyEventType
    read KeyboardCraftspersonKey30Down: EnumKeyEventType
    read KeyboardCraftspersonKey30Up: EnumKeyEventType
    read KeyboardCraftspersonKey31Down: EnumKeyEventType
    read KeyboardCraftspersonKey31Up: EnumKeyEventType
    read KeyboardCraftspersonKey32Down: EnumKeyEventType
    read KeyboardCraftspersonKey32Up: EnumKeyEventType
    read KeyboardCraftspersonKey33Down: EnumKeyEventType
    read KeyboardCraftspersonKey33Up: EnumKeyEventType
    read KeyboardCraftspersonKey34Down: EnumKeyEventType
    read KeyboardCraftspersonKey34Up: EnumKeyEventType
    read KeyboardCraftspersonKey35Down: EnumKeyEventType
    read KeyboardCraftspersonKey35Up: EnumKeyEventType
    read KeyboardCraftspersonKey36Down: EnumKeyEventType
    read KeyboardCraftspersonKey36Up: EnumKeyEventType
    read KeyboardCraftspersonKey37Down: EnumKeyEventType
    read KeyboardCraftspersonKey37Up: EnumKeyEventType
    read KeyboardCraftspersonKey38Down: EnumKeyEventType
    read KeyboardCraftspersonKey38Up: EnumKeyEventType
    read KeyboardCraftspersonKey39Down: EnumKeyEventType
    read KeyboardCraftspersonKey39Up: EnumKeyEventType
    read KeyboardCraftspersonKey40Down: EnumKeyEventType
    read KeyboardCraftspersonKey40Up: EnumKeyEventType
    read KeyboardCraftspersonKey41Down: EnumKeyEventType
    read KeyboardCraftspersonKey41Up: EnumKeyEventType
    read KeyboardCraftspersonKey42Down: EnumKeyEventType
    read KeyboardCraftspersonKey42Up: EnumKeyEventType
    read KeyboardCraftspersonKey43Down: EnumKeyEventType
    read KeyboardCraftspersonKey43Up: EnumKeyEventType
    read KeyboardMoveForwardKeyDown: EnumKeyEventType
    read KeyboardMoveForwardKeyUp: EnumKeyEventType
    read KeyboardMoveBackwardKeyDown: EnumKeyEventType
    read KeyboardMoveBackwardKeyUp: EnumKeyEventType
    read KeyboardMoveLeftKeyDown: EnumKeyEventType
    read KeyboardMoveLeftKeyUp: EnumKeyEventType
    read KeyboardMoveRightKeyDown: EnumKeyEventType
    read KeyboardMoveRightKeyUp: EnumKeyEventType
    read KeyboardSwitchToWalkOrRunKeyDown: EnumKeyEventType
    read KeyboardSwitchToWalkOrRunKeyUp: EnumKeyEventType
    read KeyboardSprintKeyDown: EnumKeyEventType
    read KeyboardSprintKeyUp: EnumKeyEventType
    read KeyboardJumpKeyDown: EnumKeyEventType
    read KeyboardJumpKeyUp: EnumKeyEventType
    read KeyboardDropKeyDown: EnumKeyEventType
    read KeyboardDropKeyUp: EnumKeyEventType
    read KeyboardOpenShortcutWheelKeyDown: EnumKeyEventType
    read KeyboardOpenShortcutWheelKeyUp: EnumKeyEventType
    read KeyboardInteractKeyDown: EnumKeyEventType
    read KeyboardInteractKeyUp: EnumKeyEventType
    read KeyboardNormalAttackKeyDown: EnumKeyEventType
    read KeyboardNormalAttackKeyUp: EnumKeyEventType
    read KeyboardCharacterSkill1KeyDown: EnumKeyEventType
    read KeyboardCharacterSkill1KeyUp: EnumKeyEventType
    read KeyboardCharacterSkill2KeyDown: EnumKeyEventType
    read KeyboardCharacterSkill2KeyUp: EnumKeyEventType
    read KeyboardCharacterSkill3KeyDown: EnumKeyEventType
    read KeyboardCharacterSkill3KeyUp: EnumKeyEventType
    read KeyboardCharacterSkill4KeyDown: EnumKeyEventType
    read KeyboardCharacterSkill4KeyUp: EnumKeyEventType
    read KeyboardNoneDown: EnumKeyEventType
    read KeyboardNoneUp: EnumKeyEventType
    read ControllerCraftspersonKey1Down: EnumKeyEventType
    read ControllerCraftspersonKey1Up: EnumKeyEventType
    read ControllerCraftspersonKey2Down: EnumKeyEventType
    read ControllerCraftspersonKey2Up: EnumKeyEventType
    read ControllerCraftspersonKey3Down: EnumKeyEventType
    read ControllerCraftspersonKey3Up: EnumKeyEventType
    read ControllerCraftspersonKey4Down: EnumKeyEventType
    read ControllerCraftspersonKey4Up: EnumKeyEventType
    read ControllerCraftspersonKey5Down: EnumKeyEventType
    read ControllerCraftspersonKey5Up: EnumKeyEventType
    read ControllerCraftspersonKey6Down: EnumKeyEventType
    read ControllerCraftspersonKey6Up: EnumKeyEventType
    read ControllerCraftspersonKey7Down: EnumKeyEventType
    read ControllerCraftspersonKey7Up: EnumKeyEventType
    read ControllerCraftspersonKey8Down: EnumKeyEventType
    read ControllerCraftspersonKey8Up: EnumKeyEventType
    read ControllerCraftspersonKey9Down: EnumKeyEventType
    read ControllerCraftspersonKey9Up: EnumKeyEventType
    read ControllerCraftspersonKey10Down: EnumKeyEventType
    read ControllerCraftspersonKey10Up: EnumKeyEventType
    read ControllerCraftspersonKey11Down: EnumKeyEventType
    read ControllerCraftspersonKey11Up: EnumKeyEventType
    read ControllerCraftspersonKey12Down: EnumKeyEventType
    read ControllerCraftspersonKey12Up: EnumKeyEventType
    read ControllerCraftspersonKey13Down: EnumKeyEventType
    read ControllerCraftspersonKey13Up: EnumKeyEventType
    read ControllerCraftspersonKey14Down: EnumKeyEventType
    read ControllerCraftspersonKey14Up: EnumKeyEventType
    read ControllerSprintKeyDown: EnumKeyEventType
    read ControllerSprintKeyUp: EnumKeyEventType
    read ControllerJumpKeyDown: EnumKeyEventType
    read ControllerJumpKeyUp: EnumKeyEventType
    read ControllerInteractKeyDown: EnumKeyEventType
    read ControllerInteractKeyUp: EnumKeyEventType
    read ControllerNormalAttackKeyDown: EnumKeyEventType
    read ControllerNormalAttackKeyUp: EnumKeyEventType
    read ControllerCharacterSkill1KeyDown: EnumKeyEventType
    read ControllerCharacterSkill1KeyUp: EnumKeyEventType
    read ControllerCharacterSkill2KeyDown: EnumKeyEventType
    read ControllerCharacterSkill2KeyUp: EnumKeyEventType
    read ControllerCharacterSkill3KeyDown: EnumKeyEventType
    read ControllerCharacterSkill3KeyUp: EnumKeyEventType
    read ControllerCharacterSkill4KeyDown: EnumKeyEventType
    read ControllerCharacterSkill4KeyUp: EnumKeyEventType
    read ControllerMenuConfirmKeyDown: EnumKeyEventType
    read ControllerMenuConfirmKeyUp: EnumKeyEventType
    read ControllerMenuBackKeyDown: EnumKeyEventType
    read ControllerMenuBackKeyUp: EnumKeyEventType
    read ControllerNoneDown: EnumKeyEventType
    read ControllerNoneUp: EnumKeyEventType
end

declare extern type EnumKeyboardKeyCode extends EnumItem with end

declare extern type EnumKeyboardKeyCodeItems with
    function GetEnumItems(self): {EnumKeyboardKeyCode}
    read CraftspersonKey1: EnumKeyboardKeyCode
    read CraftspersonKey2: EnumKeyboardKeyCode
    read CraftspersonKey3: EnumKeyboardKeyCode
    read CraftspersonKey4: EnumKeyboardKeyCode
    read CraftspersonKey5: EnumKeyboardKeyCode
    read CraftspersonKey6: EnumKeyboardKeyCode
    read CraftspersonKey7: EnumKeyboardKeyCode
    read CraftspersonKey8: EnumKeyboardKeyCode
    read CraftspersonKey9: EnumKeyboardKeyCode
    read CraftspersonKey10: EnumKeyboardKeyCode
    read CraftspersonKey11: EnumKeyboardKeyCode
    read CraftspersonKey12: EnumKeyboardKeyCode
    read CraftspersonKey13: EnumKeyboardKeyCode
    read CraftspersonKey14: EnumKeyboardKeyCode
    read CraftspersonKey15: EnumKeyboardKeyCode
    read CraftspersonKey16: EnumKeyboardKeyCode
    read CraftspersonKey17: EnumKeyboardKeyCode
    read CraftspersonKey18: EnumKeyboardKeyCode
    read CraftspersonKey19: EnumKeyboardKeyCode
    read CraftspersonKey20: EnumKeyboardKeyCode
    read CraftspersonKey21: EnumKeyboardKeyCode
    read CraftspersonKey22: EnumKeyboardKeyCode
    read CraftspersonKey23: EnumKeyboardKeyCode
    read CraftspersonKey24: EnumKeyboardKeyCode
    read CraftspersonKey25: EnumKeyboardKeyCode
    read CraftspersonKey26: EnumKeyboardKeyCode
    read CraftspersonKey27: EnumKeyboardKeyCode
    read CraftspersonKey28: EnumKeyboardKeyCode
    read CraftspersonKey29: EnumKeyboardKeyCode
    read CraftspersonKey30: EnumKeyboardKeyCode
    read CraftspersonKey31: EnumKeyboardKeyCode
    read CraftspersonKey32: EnumKeyboardKeyCode
    read CraftspersonKey33: EnumKeyboardKeyCode
    read CraftspersonKey34: EnumKeyboardKeyCode
    read CraftspersonKey35: EnumKeyboardKeyCode
    read CraftspersonKey36: EnumKeyboardKeyCode
    read CraftspersonKey37: EnumKeyboardKeyCode
    read CraftspersonKey38: EnumKeyboardKeyCode
    read CraftspersonKey39: EnumKeyboardKeyCode
    read CraftspersonKey40: EnumKeyboardKeyCode
    read CraftspersonKey41: EnumKeyboardKeyCode
    read CraftspersonKey42: EnumKeyboardKeyCode
    read CraftspersonKey43: EnumKeyboardKeyCode
    read MoveForwardKey: EnumKeyboardKeyCode
    read MoveBackwardKey: EnumKeyboardKeyCode
    read MoveLeftKey: EnumKeyboardKeyCode
    read MoveRightKey: EnumKeyboardKeyCode
    read SwitchToWalkOrRunKey: EnumKeyboardKeyCode
    read SprintKey: EnumKeyboardKeyCode
    read JumpKey: EnumKeyboardKeyCode
    read DropKey: EnumKeyboardKeyCode
    read OpenShortcutWheelKey: EnumKeyboardKeyCode
    read InteractKey: EnumKeyboardKeyCode
    read NormalAttackKey: EnumKeyboardKeyCode
    read CharacterSkill1Key: EnumKeyboardKeyCode
    read CharacterSkill2Key: EnumKeyboardKeyCode
    read CharacterSkill3Key: EnumKeyboardKeyCode
    read CharacterSkill4Key: EnumKeyboardKeyCode
    read None: EnumKeyboardKeyCode
end

declare extern type EnumLanguageType extends EnumItem with end

declare extern type EnumLanguageTypeItems with
    function GetEnumItems(self): {EnumLanguageType}
    read LanguageNone: EnumLanguageType
    read LanguageEng: EnumLanguageType
    read LanguageChs: EnumLanguageType
    read LanguageCht: EnumLanguageType
    read LanguageFra: EnumLanguageType
    read LanguageDeu: EnumLanguageType
    read LanguageSpa: EnumLanguageType
    read LanguagePor: EnumLanguageType
    read LanguageRus: EnumLanguageType
    read LanguageJpn: EnumLanguageType
    read LanguageKor: EnumLanguageType
    read LanguageTha: EnumLanguageType
    read LanguageVie: EnumLanguageType
    read LanguageInd: EnumLanguageType
    read LanguageTur: EnumLanguageType
    read LanguageIta: EnumLanguageType
end

declare extern type EnumParamType extends EnumItem with end

declare extern type EnumParamTypeItems with
    function GetEnumItems(self): {EnumParamType}
    read Entity: EnumParamType
    read EntityList: EnumParamType
    read Int: EnumParamType
    read IntList: EnumParamType
    read Bool: EnumParamType
    read BoolList: EnumParamType
    read Float: EnumParamType
    read FloatList: EnumParamType
    read String: EnumParamType
    read StringList: EnumParamType
    read Vector3: EnumParamType
    read Vector3List: EnumParamType
    read Guid: EnumParamType
    read GuidList: EnumParamType
    read ConfigId: EnumParamType
    read ConfigIdList: EnumParamType
    read PrefabId: EnumParamType
    read PrefabIdList: EnumParamType
end

declare extern type EnumScrollAlignType extends EnumItem with end

declare extern type EnumScrollAlignTypeItems with
    function GetEnumItems(self): {EnumScrollAlignType}
    read Bottom: EnumScrollAlignType
    read Center: EnumScrollAlignType
    read Top: EnumScrollAlignType
end

declare extern type EnumScrollDirection extends EnumItem with end

declare extern type EnumScrollDirectionItems with
    function GetEnumItems(self): {EnumScrollDirection}
    read Horizontal: EnumScrollDirection
    read Vertical: EnumScrollDirection
end

declare extern type EnumScrollLayoutConstraint extends EnumItem with end

declare extern type EnumScrollLayoutConstraintItems with
    function GetEnumItems(self): {EnumScrollLayoutConstraint}
    read AutoWrap: EnumScrollLayoutConstraint
    read Fixed: EnumScrollLayoutConstraint
end

declare extern type EnumStageMode extends EnumItem with end

declare extern type EnumStageModeItems with
    function GetEnumItems(self): {EnumStageMode}
    read Beyond: EnumStageMode
    read Classic: EnumStageMode
end

declare extern type EnumTextHorizontalAlignment extends EnumItem with end

declare extern type EnumTextHorizontalAlignmentItems with
    function GetEnumItems(self): {EnumTextHorizontalAlignment}
    read Left: EnumTextHorizontalAlignment
    read Middle: EnumTextHorizontalAlignment
    read Right: EnumTextHorizontalAlignment
end

declare extern type EnumTextVerticalAlignment extends EnumItem with end

declare extern type EnumTextVerticalAlignmentItems with
    function GetEnumItems(self): {EnumTextVerticalAlignment}
    read Top: EnumTextVerticalAlignment
    read Middle: EnumTextVerticalAlignment
    read Bottom: EnumTextVerticalAlignment
end

declare extern type EnumUIAnimationLayer extends EnumItem with end

declare extern type EnumUIAnimationLayerItems with
    function GetEnumItems(self): {EnumUIAnimationLayer}
    read AboveAllControls: EnumUIAnimationLayer
    read BelowAllControls: EnumUIAnimationLayer
end

declare extern type Enums with
    read ControllerKeyCode: EnumControllerKeyCodeItems
    read ControllerNavigationDir: EnumControllerNavigationDirItems
    read ControllerNavigationEventType: EnumControllerNavigationEventTypeItems
    read ControllerNavigationMode: EnumControllerNavigationModeItems
    read CursorEventType: EnumCursorEventTypeItems
    read CustomVariableEntityType: EnumCustomVariableEntityTypeItems
    read Device: EnumDeviceItems
    read EaseType: EnumEaseTypeItems
    read ImageFillHorizontalType: EnumImageFillHorizontalTypeItems
    read ImageFillRadial90Type: EnumImageFillRadial90TypeItems
    read ImageFillRadialType: EnumImageFillRadialTypeItems
    read ImageFillType: EnumImageFillTypeItems
    read ImageFillVerticalType: EnumImageFillVerticalTypeItems
    read ImageMaskSoftEdgeMode: EnumImageMaskSoftEdgeModeItems
    read ImageSource: EnumImageSourceItems
    read ImageType: EnumImageTypeItems
    read KeyEventType: EnumKeyEventTypeItems
    read KeyboardKeyCode: EnumKeyboardKeyCodeItems
    read LanguageType: EnumLanguageTypeItems
    read ParamType: EnumParamTypeItems
    read ScrollAlignType: EnumScrollAlignTypeItems
    read ScrollDirection: EnumScrollDirectionItems
    read ScrollLayoutConstraint: EnumScrollLayoutConstraintItems
    read StageMode: EnumStageModeItems
    read TextHorizontalAlignment: EnumTextHorizontalAlignmentItems
    read TextVerticalAlignment: EnumTextVerticalAlignmentItems
    read UIAnimationLayer: EnumUIAnimationLayerItems
end

declare extern type ClientUIBaseControl with
    read alive: boolean
    read id: number
    read prefabId: number
    read active: boolean
    read activeInHierarchy: boolean
    read visible: boolean
    name: string
    parent: ClientUIBaseControl
    anchoredPositionX: number
    anchoredPositionY: number
    sizeDeltaX: number
    sizeDeltaY: number
    anchorMinX: number
    anchorMinY: number
    anchorMaxX: number
    anchorMaxY: number
    pivotX: number
    pivotY: number
    localScaleX: number
    localScaleY: number
    localScaleZ: number
    localRotationX: number
    localRotationY: number
    localRotationZ: number
    canControllerFocus: boolean
    function GetChildren(self): {ClientUIBaseControl}
    function GetChild(self, name: string): ClientUIBaseControl
    function FindChild(self, path: string): ClientUIBaseControl
    function SetActive(self, active: boolean): ()
    function SetVisible(self, visible: boolean): ()
    function GetSiblingIndex(self): number
    function SetSiblingIndex(self, index: number): boolean
    function SetAsFirstSibling(self): boolean
    function SetAsLastSibling(self): boolean
    function GetAnchoredPosition(self): (number, number)
    function SetAnchoredPosition(self, x: number, y: number): ()
    function GetSizeDelta(self): (number, number)
    function SetSizeDelta(self, x: number, y: number): ()
    function GetAnchorMin(self): (number, number)
    function SetAnchorMin(self, x: number, y: number): ()
    function GetAnchorMax(self): (number, number)
    function SetAnchorMax(self, x: number, y: number): ()
    function GetPivot(self): (number, number)
    function SetPivot(self, x: number, y: number): ()
    function GetLocalScale(self): (number, number, number)
    function SetLocalScale(self, x: number, y: number, z: number): ()
    function GetLocalRotation(self): (number, number, number)
    function SetLocalRotation(self, x: number, y: number, z: number): ()
    function GetScriptByPath(self, scriptPath: string): Script
    function GetScript(self, scriptPrefabId: number): Script
    function GetScripts(self): {Script}
    function AddKeyEventListener(self, eventType: EnumKeyEventType, callback: () -> ()): ()
    function RemoveKeyEventListener(self, eventType: EnumKeyEventType, callback: () -> ()): ()
    function RemoveKeyEventListeners(self, eventType: EnumKeyEventType): ()
    function RemoveAllKeyEventListeners(self): ()
    function AddNavigationEventListener(self, eventType: EnumControllerNavigationEventType, callback: () -> ()): ()
    function RemoveNavigationEventListener(self, eventType: EnumControllerNavigationEventType, callback: () -> ()): ()
    function RemoveNavigationEventListeners(self, eventType: EnumControllerNavigationEventType): ()
    function RemoveAllNavigationEventListeners(self): ()
    function SetControllerNavigation(self, navigationDir: EnumControllerNavigationDir, navigationMode: EnumControllerNavigationMode, navigationTarget: ClientUIBaseControl?): ()
    function GetControllerNavigation(self, navigationDir: EnumControllerNavigationDir): (EnumControllerNavigationMode, ClientUIBaseControl)
end

declare extern type ColorValue with end

declare extern type CursorEventData with
    read dragging: boolean
    read touchId: number
    function GetUIPos(self): (number, number)
    function GetPressUIPos(self): (number, number)
    function GetUIPosDelta(self): (number, number)
end

declare extern type Game with
    read InstantiateClientUIControl: (uiPrefabId: number, parent: ClientUIBaseControl) -> ClientUIBaseControl
    read DestroyClientUIControl: (control: ClientUIBaseControl) -> ()
    read GetClientUIControl: (controlId: number) -> ClientUIBaseControl
    read FindClientUIRoot: (nodeName: string) -> ClientUIBaseControl
    read GetClientUIRoots: () -> {ClientUIBaseControl}
    read GetUICanvasSize: () -> (number, number)
    read GetCursorUIPos: () -> (number, number)
    read GetDevice: () -> EnumDevice
    read SetControllerFocus: (control: ClientUIBaseControl) -> ()
    read GetControllerFocus: () -> ClientUIBaseControl
    read GetControllerLeftStickAxis: () -> (number, number)
    read GetControllerRightStickAxis: () -> (number, number)
    read Tween: (object: any, tweenDataTable: {[any]: any}, duration: number) -> Tween
    read TweenSequence: () -> TweenSequence
    read ServerSignal: (signalName: string) -> ServerSignal
    read GetGlobalCustomVariableValue: (entityType: EnumCustomVariableEntityType, customVariableName: string) -> any
    read PauseLevelTime: (pause: boolean) -> ()
    read IsLevelTimePaused: () -> boolean
    read PlayAudio2D: (audioId: number) -> number
    read StopAudio: (audioInstanceId: number) -> ()
    read IsAudioAlive: (audioInstanceId: number) -> boolean
    read GetLanguageType: () -> EnumLanguageType
    read GetStageMode: () -> EnumStageMode
    read IsTestPlay: () -> boolean
    read GetText: (textMapId: string) -> string
    read PrintClientUITree: () -> ()
end

declare extern type Script with
    read alive: boolean
    read id: number
    read prefabId: number
    read object: any
    read path: string
    enabled: boolean
    function GetParam(self, paramName: string): any
    function Invoke(self, funcName: string, ...: any): ()
    function EnableUpdate(self, enabled: boolean): ()
    function RegisterServerSignalHandler(self, signalName: string, callback: () -> ()): ()
    function UnregisterServerSignalHandler(self, signalName: string): ()
    function RegisterCustomVariableChangedHandler(self, entityType: EnumCustomVariableEntityType, customVariableName: string, callback: () -> ()): ()
    function UnregisterCustomVariableChangedHandler(self, entityType: EnumCustomVariableEntityType, customVariableName: string): ()
end

declare extern type ServerSignal with
    function AddParam(self, paramType: EnumParamType, paramValue: any): ()
    function SendSignal(self): ()
    function AddFloatList(self, floatListValue: number): ()
    function AddVector3(self, vector3Value: {[any]: any}): ()
    function AddIntList(self, intListValue: number): ()
    function AddBoolList(self, boolListValue: boolean): ()
    function AddPrefabIdList(self, prefabIdListValue: number): ()
    function AddConfigId(self, configIdValue: number): ()
    function AddVector3List(self, vector3ListValue: {[any]: any}): ()
    function AddString(self, stringValue: string): ()
    function AddGuidList(self, guidListValue: number): ()
    function AddEntityList(self, entityListValue: number): ()
    function AddEntity(self, entityValue: number): ()
    function AddConfigIdList(self, configIdListValue: number): ()
    function AddPrefabId(self, prefabIdValue: number): ()
    function AddInt(self, intValue: number): ()
    function AddFloat(self, floatValue: number): ()
    function AddBool(self, boolValue: boolean): ()
    function AddStringList(self, stringListValue: string): ()
    function AddGuid(self, guidValue: number): ()
end

declare extern type Tween with
    function Play(self): Tween
    function Pause(self): Tween
    function Resume(self): Tween
    function Restart(self): Tween
    function Complete(self): Tween
    function Kill(self, complete: boolean): Tween
    function SetOnStepComplete(self, onStepComplete: () -> ()): Tween
    function SetLoops(self, times: number): Tween
    function SetEase(self, easeType: EnumEaseType): Tween
    function SetOnComplete(self, onComplete: () -> ()): Tween
    function SetRelative(self, relative: boolean): Tween
end

declare extern type TweenSequence with
    function Append(self, tween: Tween): TweenSequence
    function AppendInterval(self, interval: number): TweenSequence
    function AppendCallback(self, callback: () -> ()): TweenSequence
    function Join(self, tween: Tween): TweenSequence
    function Insert(self, time: number, tween: Tween): TweenSequence
    function InsertCallback(self, time: number, callback: () -> ()): TweenSequence
    function Play(self): TweenSequence
    function Pause(self): TweenSequence
    function Resume(self): TweenSequence
    function Restart(self): TweenSequence
    function Complete(self): TweenSequence
    function Kill(self, complete: boolean): TweenSequence
    function SetOnComplete(self, onComplete: () -> ()): TweenSequence
    function SetOnStepComplete(self, onStepComplete: () -> ()): TweenSequence
    function SetLoops(self, times: number): TweenSequence
end

declare extern type ClientUIAnimationControl extends ClientUIBaseControl with
    animationId: number
    playSoundEffect: boolean
    layer: EnumUIAnimationLayer
    function PlayAnimation(self): ()
    function StopAnimation(self): ()
end

declare extern type ClientUIContainerControl extends ClientUIBaseControl with
    isolateNavigation: boolean
    disableKeyEventPassthrough: boolean
    disableCursorEventPassthrough: boolean
    showCursor: boolean
end

declare extern type ClientUICursorEventAreaControl extends ClientUIBaseControl with
    raycastTarget: boolean
    function AddCursorEventListener(self, eventType: EnumCursorEventType, callback: (data: CursorEventData) -> ()): ()
    function RemoveCursorEventListener(self, eventType: EnumCursorEventType, callback: () -> ()): ()
    function RemoveCursorEventListeners(self, eventType: EnumCursorEventType): ()
    function RemoveAllCursorEventListeners(self): ()
    function SimulateCursorClick(self): CursorEventData
end

declare extern type ClientUIFullscreenAnimationControl extends ClientUIBaseControl with
    animationId: number
    playSoundEffect: boolean
end

declare extern type ClientUIGridScrollerControl extends ClientUIBaseControl with
    read itemCount: number
    itemPrefabId: number
    raycastTarget: boolean
    showScrollBar: boolean
    interactable: boolean
    read scrollDirection: EnumScrollDirection
    read layoutConstraint: EnumScrollLayoutConstraint
    read layoutConstraintFixedCount: number
    scrollProgress: number
    function RefreshItems(self, itemCount: number, refreshCallback: (control: ClientUIBaseControl, index: number) -> ()): ()
    function GetItemIndex(self, control: ClientUIBaseControl): number
    function GetItemSize(self): (number, number)
    function GetItemSpacing(self): (number, number)
    function GetPadding(self): (number, number, number, number)
    function ScrollToItemAt(self, index: number, scrollAlignType: EnumScrollAlignType): ()
    function GetContentLength(self): number
end

declare extern type ClientUIImageControl extends ClientUIBaseControl with
    read imageSource: EnumImageSource
    read imageId: number
    imageColor: ColorValue
    imageType: EnumImageType
    enableMask: boolean
    enableSoftEdge: boolean
    softEdgeMode: EnumImageMaskSoftEdgeMode
    softEdgeWidthX: number
    softEdgeWidthY: number
    horizontalSoftRange: number
    verticalSoftRange: number
    reverseMaskArea: boolean
    fillType: EnumImageFillType
    fillHorizontalType: EnumImageFillHorizontalType
    fillVerticalType: EnumImageFillVerticalType
    fillRadial90Type: EnumImageFillRadial90Type
    fillRadialType: EnumImageFillRadialType
    fillAmount: number
    function SetImage(self, imageSource: EnumImageSource, imageId: number): ()
    function SetSoftEdgeWidth(self, widthX: number, widthY: number): ()
    function SetFillUnused(self): ()
    function SetFillHorizontal(self, fillHorizontalType: EnumImageFillHorizontalType, fillAmount: number): ()
    function SetFillVertical(self, fillVerticalType: EnumImageFillVerticalType, fillAmount: number): ()
    function SetFillRadial90(self, fillRadial90Type: EnumImageFillRadial90Type, fillAmount: number): ()
    function SetFillRadial180(self, fillRadialType: EnumImageFillRadialType, fillAmount: number): ()
    function SetFillRadial360(self, fillRadialType: EnumImageFillRadialType, fillAmount: number): ()
end

declare extern type ClientUIKeyHintControl extends ClientUIBaseControl with
    keyboardKeyCode: EnumKeyboardKeyCode
    controllerKeyCode: EnumControllerKeyCode
end

declare extern type ClientUIPresetButtonControl extends ClientUIBaseControl with
    interactable: boolean
    clickAudioId: number
    raycastTarget: boolean
    function AddCursorEventListener(self, eventType: EnumCursorEventType, callback: (data: CursorEventData) -> ()): ()
    function RemoveCursorEventListener(self, eventType: EnumCursorEventType, callback: () -> ()): ()
    function RemoveCursorEventListeners(self, eventType: EnumCursorEventType): ()
    function RemoveAllCursorEventListeners(self): ()
    function SimulateCursorClick(self): CursorEventData
end

declare extern type ClientUIReferenceControl extends ClientUIBaseControl with
    read referencedPrefabId: number
end

declare extern type ClientUITextBoxControl extends ClientUIBaseControl with
    text: string
    fontSize: number
    fontColor: ColorValue
    bgColor: ColorValue
    enableOutline: boolean
    outlineColor: ColorValue
    horizontalAlignment: EnumTextHorizontalAlignment
    verticalAlignment: EnumTextVerticalAlignment
    adaptiveFontSize: boolean
    minimumFontSize: number
end

declare extern type ClientUITextWindowControl extends ClientUIBaseControl with
    text: string
    fontSize: number
    fontColor: ColorValue
    bgColor: ColorValue
    enableOutline: boolean
    outlineColor: ColorValue
    horizontalAlignment: EnumTextHorizontalAlignment
    verticalAlignment: EnumTextVerticalAlignment
    adaptiveFontSize: boolean
    minimumFontSize: number
    interactable: boolean
    showScrollBar: boolean
end

declare extern type ColorConstructor with
    function __call(self, r: number, g: number, b: number, a: number?): ColorValue
    read FromRGB: (r: number, g: number, b: number) -> ColorValue
    read FromRGBA: (r: number, g: number, b: number, a: number?) -> ColorValue
    read ToRGBA: (colorValue: ColorValue) -> (number, number, number, number)
end

declare Color: ColorConstructor
declare Enum: Enums
declare game: Game
declare script: Script
