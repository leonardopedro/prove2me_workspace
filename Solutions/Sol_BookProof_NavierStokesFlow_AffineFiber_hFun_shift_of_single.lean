-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.hFun_shift_of_single
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
open ShiftHamiltonian in
theorem solution (S : ShiftData ι) {X : ι → ℂ} {o : ι}
    (hXo : X o = 1) (hnext : X (S.shift (S.shift o)) = 0) :
    S.hFun X (S.shift o) = Complex.I * ((S.amp o : ℝ) : ℂ) := by

  unfold ShiftData.hFun
  rw [ShiftData.hop_shift, hXo, mul_one, hnext, mul_zero, sub_zero]
