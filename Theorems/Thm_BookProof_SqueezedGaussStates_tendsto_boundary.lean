-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.tendsto_boundary
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.tendsto_boundary (ρ : ℝ) (h0 : 0 ≤ ρ) (h1 : ρ < 1) :
    Filter.Tendsto (fun M : ℕ => (2 * (M : ℝ) + 1) * ρ ^ M) Filter.atTop (nhds 0) := by sorry
