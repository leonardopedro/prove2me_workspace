-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.gaussInt_zero
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

ply, LinearMap.smul_apply,
    Submodule.coe_sum, Submodule.coe_add, := by sorry
