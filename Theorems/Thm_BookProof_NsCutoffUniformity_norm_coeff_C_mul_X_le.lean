-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity



open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {ι : Type*}

theorem BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_le (c : ℂ) (a : ι) (m : ι →₀ ℕ) :
    ‖coeff m (C c * X a : MvPolynomial ι ℂ)‖ ≤ ‖c‖ := by sorry
