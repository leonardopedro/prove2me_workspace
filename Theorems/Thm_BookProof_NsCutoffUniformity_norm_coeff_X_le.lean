-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_X_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_X_le (a : ι) (m : ι →₀ ℕ) : ‖coeff m (X a : MvPolynomial ι ℂ)‖ ≤ 1 := by sorry
