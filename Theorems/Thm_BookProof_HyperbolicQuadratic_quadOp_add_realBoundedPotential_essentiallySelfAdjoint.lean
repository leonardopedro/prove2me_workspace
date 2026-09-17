-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadOp_add_realBoundedPotential_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

open scoped ENNReal in
theorem BookProof.HyperbolicQuadratic.quadOp_add_realBoundedPotential_essentiallySelfAdjoint (c : Fin d → ℝ)
    (W : Vd d → ℝ)
    (hW : MeasureTheory.MemLp (fun x => (W x : ℂ)) (⊤ : ℝ≥0∞) (volume : Measure (Vd d))) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp c + ((BookProof.StrichartzWave.mulL2 (hW.toLp _)).toLinearMap ∘ₗ
        (polyGaussCore (d := d)).subtype)) := by sorry
