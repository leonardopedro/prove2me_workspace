-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.inner_pgLpT_left
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

theorem BookProof.ShiftedHermiteCore.inner_pgLpT_left (a k : Vd d) (p : MvPolynomial (Fin d) ℂ) (u : L2d d) :
    (inner ℂ (pgLpT a k p) u : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFunT a k p x) * (u : Vd d → ℂ) x := by sorry
