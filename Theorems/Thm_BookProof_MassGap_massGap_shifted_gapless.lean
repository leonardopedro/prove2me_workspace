-- Generated from ChapterMassGap.lean — theorem BookProof.MassGap.massGap_shifted_gapless
import Mathlib
import Definitions.Def_ChapterMassGap
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.MassGap



open scoped BigOperators

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]
variable {n : ℕ}

theorem BookProof.MassGap.massGap_shifted_gapless (lam : ℝ) :
    massGap (shiftedSpectrum (fun _ : Fin (n + 2) => (0 : ℝ)) lam) = lam := by sorry
