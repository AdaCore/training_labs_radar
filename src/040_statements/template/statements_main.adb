with Radar_Internals; use Radar_Internals;

--  You should be able to remove these pragma at the end of the lab
pragma Warnings (Off, "assigned but never read");
pragma Warnings (Off, "useless assignment");
pragma Warnings (Off, "not referenced");

procedure Statements_Main is
   --  You are in charge of developing a rotating radar for the new T-1000
   --  Some of the radar code is already in place, it is just missing the
   --  high-level interface to handle incoming objects.
   --
   --  In this lab, you are provided with a richer Radar interface allowing you
   --  to select an active object with the radar, and to decide what to do
   --  depending on its status and your position.

   --  Distance to the active object
   Active_Object_Distance : Object_Distance_Km_T;

   --  Status of the active object
   Active_Object_Status : Object_Status_T := Selected;

   --  Current running speed
   Running_Speed : Speed_Kph_T;

   --  Number of seconds in an hour
   Seconds_Per_Hour : constant := 3600.0;

   --  Looping range
   type Radar_Scanning_Loop_T is range 1 .. 15;

   -----------------------
   --  Radar spec values --
   -----------------------
   --  Working distances
   Radar_Focus_Distance : constant Object_Distance_Km_T := 2.0;
   Radar_Scan_Distance : constant Object_Distance_Km_T := 4.0;
   Radar_Ping_Distance : constant Object_Distance_Km_T := 8.0;

   --  Internal clocks
   Radar_No_Scan_Delay : constant Duration := 0.1;
   Radar_Scan_Delay : constant Duration := 3.0;

begin

   --  QUESTION 1
   --
   --  Declare a loop for-in with Radar_Scanning_Loop_T to get the active
   --  object status and distance and to perform the appropriate action up to
   --  the Time_Step subprogram call.

   --$ begin answer
   for J in Radar_Scanning_Loop_T loop

   --$ end answer
      --  Get the status of the active object by a call
      --  to Get_Active_Object_Status
      Active_Object_Status := Get_Active_Object_Status;

      --  And its distance by a call to Get_Active_Object_Distance
      Active_Object_Distance := Get_Active_Object_Distance;

      --  QUESTION 2
      --
      --  We want the action to change depending on the object status
      --
      --  Perform the following actions using a case statement
      --  on Active_Object_Status:
      --  * Tracked, then call Walk_And_Scan
      --  * Cleared, then call Next_Object
      --  * Selected, then call Get_Closer (Fast)
      --  * Out_Of_Range, then call Get_Closer (Normal)
      --$ begin answer

      case Active_Object_Status is
      when Tracked =>
         Walk_And_Scan;
      when Cleared =>
         Next_Object;
      when Selected =>
         Get_Closer (Fast);
      when Out_Of_Range =>
         Get_Closer (Normal);
      end case;
      --$ end answer

      --  Get running speed by a call to Get_Running_Speed
      Running_Speed := Get_Running_Speed;

      --  QUESTION 3 - Part A
      --
      --  If Running_Speed is not 0 then update the E.T.A. by calling
      --
      --  Update_E_T_A with an estimated time of arrival (ETA) of
      --    Active_Object_Distance / Running_Speed * Seconds_Per_Hour
      --  Else, call Update_No_E_T_A

      --$ begin answer
      if Running_Speed /= 0.0 then
         --  Calculate new E.T.A. to object
         Update_E_T_A
            (Active_Object_Distance / Running_Speed * Seconds_Per_Hour);
      else
         Update_No_E_T_A;
      end if;

      --$ end answer
      --  QUESTION 3 - Part B
      --  Using `if` and `elsif`, implement the following:
      --
      --  If Active_Object_Distance is under Radar_Focus_Distance
      --  do not do anything, explicitly, using a null statement.
      --
      --  If Active_Object_Distance is
      --  between Radar_Focus_Distance and Radar_Scan_Distance:
      --          Rotate_Antenna (Slow)
      --  between Radar_Scan_Distance and Radar_Ping_Distance:
      --          Rotate_Antenna (Normal)
      --  over Radar_Ping_Distance:
      --           Rotate_Antenna (Fast)
      --$ begin answer

      if Active_Object_Distance <= Radar_Focus_Distance then
         null;
      elsif Active_Object_Distance <= Radar_Scan_Distance then
         Rotate_Antenna (Slow);
      elsif Active_Object_Distance <= Radar_Ping_Distance then
         Rotate_Antenna (Normal);
      else
         Rotate_Antenna (Fast);
      end if;
      --$ end answer

      --  QUESTION 4 - Part A
      --
      --  We want to modify the loop so that it exits as soon as the active
      --  object status is Selected.
      --
      --  Modify the loop to use a `while`.
      --  Note: Be careful about the loop entry condition.

      --  QUESTION 4 - Part B
      --
      --  Modify it again to use a conditional `exit when` statement.
      --$ line answer
      exit when Active_Object_Status = Selected;

      --  QUESTION 5
      --
      --  We want a Radar_Scan_Delay delay in case of scan, that is
      --  when Active_Object_Status = Tracked
      --  else and only else a Radar_No_Scan_Delay seconds delay.

      --$ line question
      delay Radar_No_Scan_Delay;
      --$ begin answer
      if Active_Object_Status = Tracked then
         delay Radar_Scan_Delay;
      else
         delay Radar_No_Scan_Delay;
      end if;
      --$ end answer

      Time_Step;
   --$ line answer
   end loop;

end Statements_Main;
