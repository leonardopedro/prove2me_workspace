-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.rotHop_hFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise_of_ne
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_hFun_eq_of_incoming
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    (rotHop A c i k).hFun X γ
      = Complex.I * (((coefRot A i k : ℝ) : ℂ)
        * (cFun i (aFun k X) γ - aFun i (cFun k X) γ)) := by

  by_cases hik : i = k
  · subst hik
    have hz : coefRot A i i = 0 := by simp [coefRot]
    have hamp : ∀ β, ampRot A i i β = 0 := by intro β; simp [ampRot, hz]
    have key := hFun_eq_of_incoming (rotHop A c i i) X (fun _ => 0)
      (by intro β; simp only [rotHop_amp, hamp]; simp)
      (by intro δ _; rfl) γ
    rw [key, hz]
    simp [rotHop_amp, hamp]
  · have key := hFun_eq_of_incoming (rotHop A c i k) X
      (fun δ => ((coefRot A i k : ℝ) : ℂ) * cFun i (aFun k X) δ) ?_ ?_ γ
    · rw [key]
      congr 1
      have hout : ((rotHop A c i k).amp γ : ℂ) * X ((rotHop A c i k).shift γ)
          = ((coefRot A i k : ℝ) : ℂ) * aFun i (cFun k X) γ := by
        rcases Nat.eq_zero_or_pos (γ k) with h0 | hpos
        · simp [rotHop_amp, ampRot, aFun, cFun, raise_of_ne (Ne.symm hik), h0]
        · have hne : γ k ≠ 0 := by omega
          simp only [rotHop_amp, rotHop_shift, ampRot, aFun, cFun, shRot, if_neg hne,
            raise_of_ne (Ne.symm hik), lower_raise_of_ne hik]
          rw [Real.sqrt_mul (by positivity)]
          push_cast
          ring
      rw [hout]
      ring
    · intro β
      rcases Nat.eq_zero_or_pos (β k) with h0 | hpos
      · have hswap : (swapVel i k β) i = 0 := by
          rw [swapVel_apply, Equiv.swap_apply_left]; exact h0
        have hL : cFun i (aFun k X) (shRot i k β) = 0 := by
          simp only [shRot, if_pos h0, cFun, hswap]
          simp
        have hR : ampRot A i k β = 0 := by
          simp only [ampRot, h0]
          simp
        simp only [rotHop_amp, rotHop_shift]
        rw [hL, hR]
        simp
      · have hne : β k ≠ 0 := by omega
        have hcast : (((β k - 1 : ℕ) : ℝ) + 1) = ((β k : ℝ)) := by
          have h1 : (1 : ℕ) ≤ β k := hpos
          push_cast [Nat.cast_sub h1]
          ring
        simp only [rotHop_amp, rotHop_shift, ampRot, cFun, aFun, shRot, if_neg hne,
          raise_self, lower_raise, lower_of_ne hik, lower_self, hcast,
          raise_lower k hpos]
        rw [Real.sqrt_mul (by positivity)]
        push_cast
        ring
    · intro δ hno
      have hz : δ i = 0 := by
        by_contra hcon
        have hik1 : 1 ≤ δ i := Nat.one_le_iff_ne_zero.mpr hcon
        refine hno ⟨raise k (lower i δ), ?_⟩
        have hk : (raise k (lower i δ)) k ≠ 0 := by rw [raise_self]; omega
        simp only [rotHop_shift, shRot, if_neg hk]
        rw [lower_raise, raise_lower i hik1]
      simp [cFun, hz]
