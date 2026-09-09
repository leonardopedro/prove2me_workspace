-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.le_relBound_of_sq_le
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative









open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





variable {d : ℕ}

theorem BookProof.HermiteRelative.le_relBound_of_sq_le {t A B c0 e : ℝ} (hA : 0 ≤ A) (hB : 0 ≤ B)
    (hc0 : 0 < c0) (he : 0 < e) (h : t ^ 2 ≤ (4 / c0) * (B * A)) :
    t ≤ e * A + (2 / (c0 * e)) * B := by sorry
