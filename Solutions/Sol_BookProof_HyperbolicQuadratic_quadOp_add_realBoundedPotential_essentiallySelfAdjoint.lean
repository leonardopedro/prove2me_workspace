import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadOp_add_realBoundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_add_boundedPotential_essentiallySelfAdjoint
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
open scoped ENNReal in
theorem solution (c : Fin d → ℝ)
    (W : Vd d → ℝ)
    (hW : MeasureTheory.MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure (Vd d))) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp c + ((BookProof.StrichartzWave.mulL2 (hW.toLp _)).toLinearMap ∘ₗ
        (polyGaussCore (d := d)).subtype)) := by

  refine quadOp_add_boundedPotential_essentiallySelfAdjoint c (hW.toLp _) ?_
  filter_upwards [hW.coeFn_toLp] with x hx
  rw [hx]
  simp
