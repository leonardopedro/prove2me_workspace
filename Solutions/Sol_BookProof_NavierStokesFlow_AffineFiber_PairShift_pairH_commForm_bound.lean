-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_commForm_add
import Theorems.Thm_BookProof_NavierStokesFlow_ShiftHamiltonian_ShiftData_shiftH_commForm_bound
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom P.sym) :
    |commForm (pairH P) (diagMax P.sym) x|
      ≤ (2 * P.step₁ * (1 / 4 + P.K) + 2 * P.step₂ * (1 / 4 + P.K))
        * quadForm (diagMax P.sym) x := by

  have h₁ := ShiftData.shiftH_commForm_bound P.fst x
  have h₂ := ShiftData.shiftH_commForm_bound P.snd x
  have hadd : commForm (pairH P) (diagMax P.sym) x
      = commForm (ShiftData.shiftH P.fst) (diagMax P.sym) x
        + commForm (ShiftData.shiftH P.snd) (diagMax P.sym) x :=
    commForm_add _ _ _ x
  have e₁ : commForm (ShiftData.shiftH P.fst) (diagMax P.fst.sym) x
      = commForm (ShiftData.shiftH P.fst) (diagMax P.sym) x := rfl
  have e₂ : commForm (ShiftData.shiftH P.snd) (diagMax P.snd.sym) x
      = commForm (ShiftData.shiftH P.snd) (diagMax P.sym) x := rfl
  have q₁ : quadForm (diagMax P.fst.sym) x = quadForm (diagMax P.sym) x := rfl
  have q₂ : quadForm (diagMax P.snd.sym) x = quadForm (diagMax P.sym) x := rfl
  rw [e₁, q₁] at h₁
  rw [e₂, q₂] at h₂
  have hK₁ : P.fst.K = P.K := rfl
  have hK₂ : P.snd.K = P.K := rfl
  have hs₁ : P.fst.step = P.step₁ := rfl
  have hs₂ : P.snd.step = P.step₂ := rfl
  rw [hK₁, hs₁] at h₁
  rw [hK₂, hs₂] at h₂
  rw [hadd]
  refine le_trans (abs_add_le _ _) ?_
  linarith
