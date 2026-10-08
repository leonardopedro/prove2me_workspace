-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.coreEquivT_coe
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ShiftedHermiteCore



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.ShiftedHermiteCore.coreEquivT_coe (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) :
    ((coreEquivT a k p : polyGaussCoreT a k) : L2d d) = pgLpT a k p := by sorry
