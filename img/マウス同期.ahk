#NoEnv
#SingleInstance Force
SetBatchLines, -1
CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 0 ; マウス移動速度を最速に設定

; --- 設定エリア ---
MainX_Min := -1900
MainX_Max := -1300
MainY_Min := 0
MainY_Max := 340
; ----------------

f8::
    Suspend
    ToolTip, % (A_IsSuspended ? "Macro OFF" : "Macro ON")
    SetTimer, RemoveToolTip, -1000
return

RemoveToolTip:
    ToolTip
return

; 左クリックを監視
~LButton::
    MouseGetPos, curX, curY
    
    ; Main範囲内かチェック
    if (curX >= MainX_Min and curX <= MainX_Max and curY >= MainY_Min and curY <= MainY_Max)
    {
        ; ボタンを離した瞬間に開始
        KeyWait, LButton
        
        ; 発動までの待機（ここも短く設定）
        Sleep, 50 

        ; 2～7の相対座標データ
        xs := [600, 1200, 0, 600, 0, 600]
        ys := [0, 0, 340, 340, 680, 680]

        Loop, 6
        {
            targetX := curX + xs[A_Index]
            targetY := curY + ys[A_Index]

            ; クリック実行
            Click, %targetX%, %targetY%
            
            ; 次のクリックまでの間隔を50msに設定
            Sleep, 50 
        }
        
        ; 元の位置に瞬時に戻る
        MouseMove, %curX%, %curY%, 0
    }
return