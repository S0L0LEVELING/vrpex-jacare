-----------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RequestIpl("gabz_pillbox_milo_")
		local interiorID = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)
		local int = {
			"rc12b_fixed",
			"rc12b_destroyed",
			"rc12b_default",
			"rc12b_hospitalinterior_lod",
			"rc12b_hospitalinterior"
		}
		Wait(10000)
		for i = 1, #int, 1 do
			if IsIplActive(int[i]) then
				RemoveIpl(int[i])
			end
		end
		RefreshInterior(interiorID)
		LoadInterior(interiorID)
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RequestIpl("gabz_mrpd_milo_")
		interiorID = GetInteriorAtCoords(451.0129, -993.3741, 29.1718)	
			if IsValidInterior(interiorID) then      
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm1")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm2")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm3")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm4")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm5")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm6")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm7")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm8")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm9")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm10")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm11")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm12")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm13")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm14")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm15")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm16")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm17")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm18")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm19")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm20")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm21")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm22")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm23")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm24")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm25")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm26")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm27")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm28")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm29")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm30")
					EnableInteriorProp(interiorID, "v_gabz_mrpd_rm31")
				RefreshInterior(interiorID)
			end
		end)