-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.phaseArg_sec
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.ShiftedHermiteCore



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}


theorem BookProof.ShiftedHermiteCore.phaseArg_sec (k x : Vd d) (i : Fin d) (t : ℝ) :
    phaseArg k (sec i x t) = phaseArg k x + k i * (t - x i) := by sorry
