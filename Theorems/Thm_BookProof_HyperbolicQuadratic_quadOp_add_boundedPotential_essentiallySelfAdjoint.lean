-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadOp_add_boundedPotential_essentiallySelfAdjoint
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterWaveBoundedPotential
open BookProof.HermiteProductCore
open BookProof.HyperbolicQuadratic

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.quadOp_add_boundedPotential_essentiallySelfAdjoint (c : Fin d → ℝ)
    (W : MeasureTheory.Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (Vd d)))
    (hW : ∀ᵐ x ∂(volume : Measure (Vd d)), (starRingEnd ℂ) (W x) = W x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp c + ((BookProof.StrichartzWave.mulL2 W).toLinearMap ∘ₗ
        (polyGaussCore (d := d)).subtype)) := by sorry
