-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadOp_add_boundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

open scoped ENNReal in
theorem BookProof.HyperbolicQuadratic.quadOp_add_boundedPotential_essentiallySelfAdjoint (c : Fin d → ℝ)
    (W : MeasureTheory.Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (Vd d)))
    (hW : ∀ᵐ x ∂(volume : Measure (Vd d)), (starRingEnd ℂ) (W x) = W x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp c + ((BookProof.StrichartzWave.mulL2 W).toLinearMap ∘ₗ
        (polyGaussCore (d := d)).subtype)) := by sorry
