-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.codim_one
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_isInv_ker_cas
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_ops_zero_of_trivial
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_ops_zero_of_minimal_cas_zero
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_IsInv_inf
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_cas_apply_eq
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) {V : Type u} [AddCommGroup V] [Module ℂ V]
    [FiniteDimensional ℂ V] (R : Sl2Rep V) (phi : V →ₗ[ℂ] ℂ) (v0 : V), phi v0 = 1 →
    (∀ v, phi (R.E v) = 0) → (∀ v, phi (R.F v) = 0) → (∀ v, phi (R.H v) = 0) →
    Module.finrank ℂ (LinearMap.ker phi) ≤ n →
    ∃ v : V, phi v = 1 ∧ R.E v = 0 ∧ R.F v = 0 ∧ R.H v = 0 := by

  intro n
  induction n with
  | zero =>
      intro V _ _ _ R phi v0 hv0 hE hF hH hrank
      have hker : LinearMap.ker phi = ⊥ := by
        rw [← Submodule.finrank_eq_zero]
        omega
      have hz : ∀ x : V, phi x = 0 → x = 0 := by
        intro x hx
        have hmem : x ∈ LinearMap.ker phi := hx
        rw [hker, Submodule.mem_bot] at hmem
        exact hmem
      exact ⟨v0, hv0, hz _ (hE v0), hz _ (hF v0), hz _ (hH v0)⟩
  | succ n ih =>
      intro V _ _ _ R phi v0 hv0 hE hF hH hrank
      classical
      have hmapE : ∀ v : V, R.E v ∈ LinearMap.ker phi := fun v => hE v
      have hmapF : ∀ v : V, R.F v ∈ LinearMap.ker phi := fun v => hF v
      have hmapH : ∀ v : V, R.H v ∈ LinearMap.ker phi := fun v => hH v
      have hWinv : R.IsInv (LinearMap.ker phi) :=
        ⟨fun x _ => hmapE x, fun x _ => hmapF x, fun x _ => hmapH x⟩
      -- the hyperplane has codimension one
      have hrangetop : LinearMap.range phi = ⊤ :=
        LinearMap.range_eq_top.mpr fun c => ⟨c • v0, by rw [map_smul, hv0, smul_eq_mul, mul_one]⟩
      have hWrank : Module.finrank ℂ (LinearMap.ker phi) + 1 = Module.finrank ℂ V := by
        have h := LinearMap.finrank_range_add_finrank_ker phi
        rw [hrangetop, finrank_top, Module.finrank_self] at h
        omega
      by_cases hsub : ∃ W' : Submodule ℂ V, R.IsInv W' ∧ W' ≠ ⊥ ∧ W' < LinearMap.ker phi
      · obtain ⟨W', hW'inv, hW'ne, hW'lt⟩ := hsub
        have hW'le : W' ≤ LinearMap.ker phi := le_of_lt hW'lt
        have hW'pos : 0 < Module.finrank ℂ ↥W' := by
          have := Submodule.finrank_lt_finrank_of_lt (bot_lt_iff_ne_bot.mpr hW'ne)
          simpa using this
        -- Step 1: pass to the quotient by `W'`
        set R' := R.quot W' hW'inv with hR'
        set phi' : (V ⧸ W') →ₗ[ℂ] ℂ := W'.liftQ phi hW'le with hphi'
        have hv0' : phi' (Submodule.Quotient.mk v0) = 1 := hv0
        have hE' : ∀ x, phi' (R'.E x) = 0 := by
          refine fun x => Quotient.inductionOn' x fun v => ?_
          exact hE v
        have hF' : ∀ x, phi' (R'.F x) = 0 := by
          refine fun x => Quotient.inductionOn' x fun v => ?_
          exact hF v
        have hH' : ∀ x, phi' (R'.H x) = 0 := by
          refine fun x => Quotient.inductionOn' x fun v => ?_
          exact hH v
        have hquot : Module.finrank ℂ (V ⧸ W') + Module.finrank ℂ ↥W' = Module.finrank ℂ V :=
          Submodule.finrank_quotient_add_finrank W'
        have hkerlt : Module.finrank ℂ ↥(LinearMap.ker phi') < Module.finrank ℂ (V ⧸ W') := by
          have hne : LinearMap.ker phi' ≠ ⊤ := by
            intro hc
            have : (Submodule.Quotient.mk v0 : V ⧸ W') ∈ LinearMap.ker phi' := by rw [hc]; trivial
            rw [LinearMap.mem_ker, hv0'] at this
            exact one_ne_zero this
          have := Submodule.finrank_lt_finrank_of_lt (lt_top_iff_ne_top.mpr hne)
          simpa using this
        have hrank' : Module.finrank ℂ (LinearMap.ker phi') ≤ n := by omega
        obtain ⟨u, hu1, huE, huF, huH⟩ :=
          ih R' phi' (Submodule.Quotient.mk v0) hv0' hE' hF' hH' hrank'
        obtain ⟨v, rfl⟩ := W'.mkQ_surjective u
        have hv1 : phi v = 1 := hu1
        have hvE : R.E v ∈ W' := by
          have : (Submodule.Quotient.mk (R.E v) : V ⧸ W') = 0 := huE
          rwa [Submodule.Quotient.mk_eq_zero] at this
        have hvF : R.F v ∈ W' := by
          have : (Submodule.Quotient.mk (R.F v) : V ⧸ W') = 0 := huF
          rwa [Submodule.Quotient.mk_eq_zero] at this
        have hvH : R.H v ∈ W' := by
          have : (Submodule.Quotient.mk (R.H v) : V ⧸ W') = 0 := huH
          rwa [Submodule.Quotient.mk_eq_zero] at this
        -- Step 2: work inside `U = W' + ℂ v`
        set U : Submodule ℂ V := W' ⊔ Submodule.span ℂ {v} with hU
        have hW'leU : W' ≤ U := le_sup_left
        have hvU : v ∈ U :=
          (le_sup_right : Submodule.span ℂ {v} ≤ U) (Submodule.mem_span_singleton_self v)
        have hUinv : R.IsInv U := by
          refine ⟨fun x hx => ?_, fun x hx => ?_, fun x hx => ?_⟩ <;>
            obtain ⟨a, ha, b, hb, rfl⟩ := Submodule.mem_sup.mp hx <;>
            obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hb <;>
            rw [map_add, map_smul]
          · exact U.add_mem (hW'leU (hW'inv.1 a ha)) (U.smul_mem c (hW'leU hvE))
          · exact U.add_mem (hW'leU (hW'inv.2.1 a ha)) (U.smul_mem c (hW'leU hvF))
          · exact U.add_mem (hW'leU (hW'inv.2.2 a ha)) (U.smul_mem c (hW'leU hvH))
        set RU := R.restr U hUinv with hRU
        set phiU : ↥U →ₗ[ℂ] ℂ := phi.comp U.subtype with hphiU
        have hkerU : LinearMap.ker phiU = Submodule.comap U.subtype W' := by
          apply le_antisymm
          · intro x hx
            have hx0 : phi (x : V) = 0 := hx
            obtain ⟨a, ha, b, hb, hab⟩ := Submodule.mem_sup.mp x.2
            obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hb
            have hphia : phi a = 0 := hW'le ha
            have : c = 0 := by
              have := congrArg phi hab
              rw [map_add, map_smul, hphia, hv1, zero_add, smul_eq_mul, mul_one, hx0] at this
              exact this
            rw [this, zero_smul, add_zero] at hab
            change (x : V) ∈ W'
            rw [← hab]
            exact ha
          · intro x hx
            change phi (x : V) = 0
            exact hW'le hx
        have hrankU : Module.finrank ℂ (LinearMap.ker phiU) ≤ n := by
          rw [hkerU]
          have hequiv := Submodule.comapSubtypeEquivOfLe hW'leU
          rw [hequiv.finrank_eq]
          have := Submodule.finrank_lt_finrank_of_lt hW'lt
          omega
        obtain ⟨x, hx1, hxE, hxF, hxH⟩ :=
          ih RU phiU ⟨v, hvU⟩ (by exact hv1) (fun y => hE _) (fun y => hF _) (fun y => hH _) hrankU
        refine ⟨(x : V), hx1, ?_, ?_, ?_⟩
        · have := congrArg (fun y : ↥U => (y : V)) hxE
          simpa [hRU] using this
        · have := congrArg (fun y : ↥U => (y : V)) hxF
          simpa [hRU] using this
        · have := congrArg (fun y : ↥U => (y : V)) hxH
          simpa [hRU] using this
      · -- `ker phi` is minimal
        push_neg at hsub
        have hmin : ∀ U ≤ LinearMap.ker phi, R.IsInv U → U = ⊥ ∨ U = LinearMap.ker phi := by
          intro U hle hinv
          by_cases h0 : U = ⊥
          · exact Or.inl h0
          · refine Or.inr ?_
            by_contra hne
            exact absurd (lt_of_le_of_ne hle hne) (hsub U hinv h0)
        have hKW : R.IsInv (LinearMap.ker R.cas ⊓ LinearMap.ker phi) :=
          (isInv_ker_cas R).inf hWinv
        rcases hmin _ inf_le_right hKW with hcase | hcase
        · -- the Casimir is injective on the hyperplane: split off its kernel
          have hcasW : ∀ v : V, R.cas v ∈ LinearMap.ker phi := by
            intro v
            rw [cas_apply_eq, two_nsmul]
            exact Submodule.add_mem _ (Submodule.add_mem _
              (Submodule.add_mem _ (hmapE _) (hmapF _))
              (Submodule.add_mem _ (hmapE _) (hmapF _))) (hmapH _)
          have hnotinj : ¬ Function.Injective R.cas := by
            intro hinj
            obtain ⟨u, hu⟩ := (LinearMap.injective_iff_surjective).mp hinj v0
            have hmem : v0 ∈ LinearMap.ker phi := hu ▸ hcasW u
            rw [LinearMap.mem_ker, hv0] at hmem
            exact one_ne_zero hmem
          have hkerne : LinearMap.ker R.cas ≠ ⊥ := by
            intro hc
            exact hnotinj (LinearMap.ker_eq_bot.mp hc)
          obtain ⟨u, hu, hune⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hkerne
          have hphiu : phi u ≠ 0 := by
            intro h0
            apply hune
            have hmem : u ∈ LinearMap.ker R.cas ⊓ LinearMap.ker phi := ⟨hu, h0⟩
            rw [hcase, Submodule.mem_bot] at hmem
            exact hmem
          have hzero : ∀ y : V, y ∈ LinearMap.ker R.cas → y ∈ LinearMap.ker phi → y = 0 := by
            intro y h1 h2
            have hmem : y ∈ LinearMap.ker R.cas ⊓ LinearMap.ker phi := ⟨h1, h2⟩
            rwa [hcase, Submodule.mem_bot] at hmem
          refine ⟨(phi u)⁻¹ • u, ?_, ?_, ?_, ?_⟩
          · rw [map_smul, smul_eq_mul, inv_mul_cancel₀ hphiu]
          · rw [map_smul, hzero _ ((isInv_ker_cas R).1 u hu) (hmapE u), smul_zero]
          · rw [map_smul, hzero _ ((isInv_ker_cas R).2.1 u hu) (hmapF u), smul_zero]
          · rw [map_smul, hzero _ ((isInv_ker_cas R).2.2 u hu) (hmapH u), smul_zero]
        · -- the Casimir vanishes on the hyperplane, which is therefore a trivial module
          have hWK : ∀ x ∈ LinearMap.ker phi, R.cas x = 0 := by
            intro x hx
            have hmem : x ∈ LinearMap.ker R.cas ⊓ LinearMap.ker phi := by rw [hcase]; exact hx
            exact hmem.1
          have htriv : ∀ x ∈ LinearMap.ker phi, R.E x = 0 ∧ R.F x = 0 ∧ R.H x = 0 := by
            by_cases hWbot : LinearMap.ker phi = ⊥
            · intro x hx
              rw [hWbot, Submodule.mem_bot] at hx
              subst hx
              simp
            · exact ops_zero_of_minimal_cas_zero hWinv hWbot hmin hWK
          have hall := ops_zero_of_trivial (fun v => ⟨hmapE v, hmapF v, hmapH v⟩) htriv
          exact ⟨v0, hv0, (hall v0).1, (hall v0).2.1, (hall v0).2.2⟩
