-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.ops_zero_of_minimal_cas_zero
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_exists_highestWeight
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_highestWeight_nat
import Theorems.Thm_BookProof_ChapterWeylSl2_Sl2Rep_cas_highestWeight
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] {W : Submodule ℂ V}
    (hW : R.IsInv W) (hne : W ≠ ⊥) (hmin : ∀ U ≤ W, R.IsInv U → U = ⊥ ∨ U = W)
    (hcas : ∀ x ∈ W, R.cas x = 0) : ∀ x ∈ W, R.E x = 0 ∧ R.F x = 0 ∧ R.H x = 0 := by

  haveI : Nontrivial ↥W := Submodule.nontrivial_iff_ne_bot.mpr hne
  obtain ⟨ws, lam, hws0, hwsE, hwsH⟩ := (R.restr W hW).exists_highestWeight
  set w : V := (ws : V) with hwdef
  have hw0 : w ≠ 0 := by
    simpa [hwdef, Submodule.coe_eq_zero] using hws0
  have hwW : w ∈ W := ws.2
  have hwE : R.E w = 0 := by
    have := congrArg (fun y : ↥W => (y : V)) hwsE
    simpa [hwdef] using this
  have hwH : R.H w = lam • w := by
    have := congrArg (fun y : ↥W => (y : V)) hwsH
    simpa [hwdef] using this
  obtain ⟨m, hlam, hFm⟩ := highestWeight_nat hw0 hwE hwH
  have hcw : R.cas w = 0 := hcas w hwW
  have hval : (lam ^ 2 + 2 * lam) • w = 0 := by rw [← cas_highestWeight hwE hwH, hcw]
  have hzero : lam ^ 2 + 2 * lam = 0 := by
    rcases smul_eq_zero.mp hval with h | h
    · exact h
    · exact absurd h hw0
  have hm0 : m = 0 := by
    rw [hlam] at hzero
    have hfac : (m : ℂ) * ((m : ℂ) + 2) = 0 := by linear_combination hzero
    rcases mul_eq_zero.mp hfac with h | h
    · exact_mod_cast h
    · exfalso
      have : ((m : ℂ) + 2) ≠ 0 := by
        intro hc
        have hre : ((m : ℝ) + 2) = 0 := by
          have := congrArg Complex.re hc
          simpa using this
        have : (0 : ℝ) ≤ (m : ℝ) := Nat.cast_nonneg m
        linarith
      exact this h
  have hlam0 : lam = 0 := by rw [hlam, hm0]; simp
  have hwF : R.F w = 0 := by
    rw [hm0, zero_add, pow_one] at hFm
    exact hFm
  have hwH0 : R.H w = 0 := by rw [hwH, hlam0, zero_smul]
  have hspan : (Submodule.span ℂ {w} : Submodule ℂ V) = W := by
    have hle : (Submodule.span ℂ {w} : Submodule ℂ V) ≤ W := by
      rw [Submodule.span_le, Set.singleton_subset_iff]
      exact hwW
    have hinv : R.IsInv (Submodule.span ℂ {w}) := by
      refine ⟨fun x hx => ?_, fun x hx => ?_, fun x hx => ?_⟩ <;>
        obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hx
      · rw [map_smul, hwE, smul_zero]; exact Submodule.zero_mem _
      · rw [map_smul, hwF, smul_zero]; exact Submodule.zero_mem _
      · rw [map_smul, hwH0, smul_zero]; exact Submodule.zero_mem _
    rcases hmin _ hle hinv with h | h
    · exact absurd h (by
        intro hc
        rw [Submodule.span_singleton_eq_bot] at hc
        exact hw0 hc)
    · exact h
  intro x hx
  rw [← hspan] at hx
  obtain ⟨c, rfl⟩ := Submodule.mem_span_singleton.mp hx
  refine ⟨?_, ?_, ?_⟩ <;> rw [map_smul]
  · rw [hwE, smul_zero]
  · rw [hwF, smul_zero]
  · rw [hwH0, smul_zero]
