-- Generated from ChapterNavierStokesShiftHamiltonian.lean — solution of BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.norm_crossB
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

set_option maxHeartbeats 1000000 in
theorem solution (X Y : ι → ℂ) (β : ι) :
    ‖S.crossB X Y β‖ = S.amp β * ‖X (S.shift β)‖ * ‖Y β‖ := by

  simp only [crossB, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (S.amp_nonneg β), RCLike.norm_conj]
