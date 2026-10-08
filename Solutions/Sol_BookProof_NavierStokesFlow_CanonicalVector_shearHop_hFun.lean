-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.shearHop_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_hFun_eq_of_incoming
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    (shearHop A c i).hFun X γ
      = Complex.I * (((c i / Real.sqrt 2 : ℝ) : ℂ) * (cFun i X γ - aFun i X γ)) := by

  have key := hFun_eq_of_incoming (shearHop A c i) X
    (fun δ => ((c i / Real.sqrt 2 : ℝ) : ℂ) * cFun i X δ) ?_ ?_ γ
  · rw [key]
    congr 1
    have hout : ((shearHop A c i).amp γ : ℂ) * X ((shearHop A c i).shift γ)
        = ((c i / Real.sqrt 2 : ℝ) : ℂ) * aFun i X γ := by
      simp only [shearHop_amp, shearHop_shift, ampShear, aFun, shShear]
      push_cast
      ring
    rw [hout]
    ring
  · intro β
    simp only [shearHop_amp, shearHop_shift, ampShear, cFun, shShear, raise_self, lower_raise]
    push_cast
    ring
  · intro δ hno
    have hz : δ i = 0 := by
      by_contra hcon
      exact hno ⟨lower i δ, by
        simp only [shearHop_shift, shShear]
        exact raise_lower i (Nat.one_le_iff_ne_zero.mpr hcon)⟩
    simp [cFun, hz]
