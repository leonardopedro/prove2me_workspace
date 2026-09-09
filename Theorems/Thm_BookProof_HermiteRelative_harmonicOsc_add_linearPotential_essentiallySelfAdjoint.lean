-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.harmonicOsc_add_linearPotential_essentiallySelfAdjoint
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

theorem BookProof.HermiteRelative.harmonicOsc_add_linearPotential_essentiallySelfAdjoint (b : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (quadOp (fun _ => (1 : ℝ)) + foOp b 0) := by sorry
