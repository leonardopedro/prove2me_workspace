-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.span_hermiteTLp
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.ShiftedHermiteCore



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.ShiftedHermiteCore.span_hermiteTLp (a k : Vd d) :
    Submodule.span ℂ (Set.range (hermiteTLp (d := d) a k)) = polyGaussCoreT a k := by sorry
