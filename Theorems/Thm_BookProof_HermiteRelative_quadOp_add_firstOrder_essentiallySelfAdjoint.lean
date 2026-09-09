-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.quadOp_add_firstOrder_essentiallySelfAdjoint
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

theorem BookProof.HermiteRelative.quadOp_add_firstOrder_essentiallySelfAdjoint (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0)
    (hc : ∀ i, c0 ≤ c i) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOp c + foOp b b') := by sorry
