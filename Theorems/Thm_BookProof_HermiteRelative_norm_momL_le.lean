-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.norm_momL_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

le_relBound_of_sq_le (norm_nonneg _) (norm_nonneg _) hc0 he
    (norm_posL_sq_le c hc0 hc i u)

theorem BookProof.HermiteRelative.norm_momL_le (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0) (hc : ∀ i, c0 ≤ c i)
    {e : ℝ} (he : 0 < e) (i : Fin d) (u : polyGaussCo := by sorry
