-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.hasDerivAt_phaseFun_sec
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteProductCore
open BookProof.MixedLinearEsa
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.ShiftedHermiteCore



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.ShiftedHermiteCore.hasDerivAt_phaseFun_sec (k x : Vd d) (i : Fin d) :
    HasDerivAt (fun t : ℝ => phaseFun k (sec i x t))
      (phaseFun k x * (Complex.I * ((k i : ℝ) : ℂ))) (x i) := by sorry
