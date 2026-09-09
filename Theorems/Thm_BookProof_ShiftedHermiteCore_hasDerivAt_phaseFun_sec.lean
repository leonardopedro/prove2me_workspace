-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.hasDerivAt_phaseFun_sec
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
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
