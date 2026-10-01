-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.norm_crossA
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat FarisLavine IkebeKato

set_option maxHeartbeats 1000000 in
theorem solution (X Y : ι → ℂ) (β : ι) :
    ‖S.crossA X Y β‖ = S.ampSeq X β * ‖Y (S.shift β)‖ := by

  simp only [crossA, ampSeq, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (S.amp_nonneg β), RCLike.norm_conj]
