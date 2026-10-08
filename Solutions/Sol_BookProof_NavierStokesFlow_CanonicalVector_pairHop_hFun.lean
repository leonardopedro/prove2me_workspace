-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.pairHop_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_raise_comm
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_hFun_eq_of_incoming
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    (pairHop A c i k).hFun X γ
      = Complex.I * (((coefPair A i k : ℝ) : ℂ)
        * (cFun i (cFun k X) γ - aFun i (aFun k X) γ)) := by

  by_cases hik : i = k
  · subst hik
    have hz : coefPair A i i = 0 := by simp [coefPair]
    have hamp : ∀ β, ampPair A i i β = 0 := by intro β; simp [ampPair, hz]
    have key := hFun_eq_of_incoming (pairHop A c i i) X (fun _ => 0)
      (by intro β; simp only [pairHop_amp, hamp]; simp)
      (by intro δ _; rfl) γ
    rw [key, hz]
    simp [pairHop_amp, hamp]
  · have key := hFun_eq_of_incoming (pairHop A c i k) X
      (fun δ => ((coefPair A i k : ℝ) : ℂ) * cFun i (cFun k X) δ) ?_ ?_ γ
    · rw [key]
      congr 1
      have hout : ((pairHop A c i k).amp γ : ℂ) * X ((pairHop A c i k).shift γ)
          = ((coefPair A i k : ℝ) : ℂ) * aFun i (aFun k X) γ := by
        simp only [pairHop_amp, pairHop_shift, ampPair, aFun, shPair,
          raise_of_ne (Ne.symm hik), raise_comm k i γ]
        rw [Real.sqrt_mul (by positivity)]
        push_cast
        ring
      rw [hout]
      ring
    · intro β
      simp only [pairHop_amp, pairHop_shift, ampPair, cFun, shPair, raise_self,
        raise_of_ne hik, lower_raise]
      rw [Real.sqrt_mul (by positivity)]
      push_cast
      ring
    · intro δ hno
      have hz : δ i = 0 ∨ δ k = 0 := by
        by_contra hcon
        push_neg at hcon
        refine hno ⟨lower k (lower i δ), ?_⟩
        have hik1 : 1 ≤ δ i := Nat.one_le_iff_ne_zero.mpr hcon.1
        have hkk1 : 1 ≤ δ k := Nat.one_le_iff_ne_zero.mpr hcon.2
        have h1 : 1 ≤ (lower i δ) k := by
          rw [lower_of_ne (Ne.symm hik)]; omega
        simp only [pairHop_shift, shPair]
        rw [raise_lower k h1, raise_lower i hik1]
      rcases hz with h0 | h0
      · simp [cFun, h0]
      · simp [cFun, lower_of_ne (Ne.symm hik), h0]
