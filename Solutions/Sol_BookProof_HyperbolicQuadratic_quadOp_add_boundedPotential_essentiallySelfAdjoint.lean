import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadOp_add_boundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_symmetric
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_essentiallySelfAdjoint
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
open scoped ENNReal in
theorem solution (c : Fin d → ℝ)
    (W : MeasureTheory.Lp ℂ (⊤ : ℝ≥0∞) (volume : Measure (Vd d)))
    (hW : ∀ᵐ x ∂(volume : Measure (Vd d)), (starRingEnd ℂ) (W x) = W x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp c + ((BookProof.StrichartzWave.mulL2 W).toLinearMap ∘ₗ
        (polyGaussCore (d := d)).subtype)) :=
  BookProof.KatoRellich.essentiallySelfAdjointOn_add_bounded _ (quadOp_symmetric c)
      (quadOp_essentiallySelfAdjoint c) (BookProof.StrichartzWave.mulL2 W)
      (BookProof.StrichartzWave.mulL2_symmetric W hW)
