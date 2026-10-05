-- Generated from ChapterMassGap.lean — solution of BookProof.MassGap.shiftedSpectrum_excited
import Mathlib
import Definitions.Def_ChapterMassGap
open BookProof.MassGap




open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (E : Fin (n + 2) → ℝ) (lam : ℝ)
    {i : Fin (n + 2)} (hi : i ≠ 0) :
    shiftedSpectrum E lam i = E i + lam := by

  unfold shiftedSpectrum numberOp; aesop;
