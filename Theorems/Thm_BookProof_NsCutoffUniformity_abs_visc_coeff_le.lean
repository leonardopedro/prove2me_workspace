-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.abs_visc_coeff_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity



open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {ι : Type*}

theorem BookProof.NsCutoffUniformity.abs_visc_coeff_le {nu Λ : ℝ} {k : Fin 3 → ℝ} (hΛ : 0 ≤ Λ) (hk : ∀ j, |k j| ≤ Λ) :
    |nu * ∑ j : Fin 3, (k j) ^ 2| ≤ 3 * |nu| * Λ ^ 2 := by sorry
