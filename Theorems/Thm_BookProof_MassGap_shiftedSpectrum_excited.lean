-- Generated from ChapterMassGap.lean — theorem BookProof.MassGap.shiftedSpectrum_excited
import Mathlib
import Definitions.Def_ChapterMassGap
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.MassGap



open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {n : ℕ}

theorem BookProof.MassGap.shiftedSpectrum_excited (E : Fin (n + 2) → ℝ) (lam : ℝ)
    {i : Fin (n + 2)} (hi : i ≠ 0) :
    shiftedSpectrum E lam i = E i + lam := by sorry
