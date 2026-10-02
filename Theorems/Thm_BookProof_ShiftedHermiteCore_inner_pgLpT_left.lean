-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.inner_pgLpT_left
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ShiftedHermiteCore

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.ShiftedHermiteCore.inner_pgLpT_left (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) (u : L2d d) :
    (inner ℂ (pgLpT a k p) u : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFunT a k p x) * (u : Vd d → ℂ) x := by sorry
