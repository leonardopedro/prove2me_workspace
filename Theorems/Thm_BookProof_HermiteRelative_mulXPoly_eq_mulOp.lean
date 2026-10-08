-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.mulXPoly_eq_mulOp
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.ChapterF7
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

theorem BookProof.HermiteRelative.mulXPoly_eq_mulOp (i : Fin d) :
    mulXPoly i = BookProof.YangMillsHermite.mulOp (X i : MvPolynomial (Fin d) ℂ) := by sorry
