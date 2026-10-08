-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.diagHop_hFun
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
    (diagHop A c i).hFun X γ
      = Complex.I * (((A i i / 2 : ℝ) : ℂ) * (cFun i (cFun i X) γ - aFun i (aFun i X) γ)) := by

  have key := hFun_eq_of_incoming (diagHop A c i) X
    (fun δ => ((A i i / 2 : ℝ) : ℂ) * cFun i (cFun i X) δ) ?_ ?_ γ
  · rw [key]
    congr 1
    have hout : ((diagHop A c i).amp γ : ℂ) * X ((diagHop A c i).shift γ)
        = ((A i i / 2 : ℝ) : ℂ) * aFun i (aFun i X) γ := by
      simp only [diagHop_amp, diagHop_shift, ampDiag, aFun, shDiag, raise_self]
      rw [Real.sqrt_mul (by positivity)]
      push_cast
      ring_nf
    rw [hout]
    ring
  · intro β
    simp only [diagHop_amp, diagHop_shift, ampDiag, cFun, shDiag, raise_self, lower_raise]
    rw [Real.sqrt_mul (by positivity)]
    push_cast
    ring_nf
  · intro δ hno
    have hlt : δ i < 2 := by
      by_contra hcon
      exact hno ⟨lower i (lower i δ), by
        have h1 : 1 ≤ (lower i δ) i := by simp only [lower_self]; omega
        simp only [diagHop_shift, shDiag]
        rw [raise_lower i h1, raise_lower i (by omega : 1 ≤ δ i)]⟩
    interval_cases h : δ i <;> simp [cFun, h, lower_self]
