-- Generated from ChapterMassGap.lean — theorem BookProof.MassGap.shiftedSpectrum_vacuum
import Mathlib
import Definitions.Def_ChapterMassGap
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.MassGap



open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {n : ℕ}

theorem BookProof.MassGap.shiftedSpectrum_vacuum (E : Fin (n + 2) → ℝ) (lam : ℝ) :
    shiftedSpectrum E lam 0 = E 0 := by sorry
