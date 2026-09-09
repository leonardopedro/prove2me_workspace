-- Generated from ChapterShiftedHermiteCore.lean — theorem BookProof.ShiftedHermiteCore.eq_zero_of_inner_coreT
import Mathlib
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.ShiftedHermiteCore










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

theorem BookProof.ShiftedHermiteCore.eq_zero_of_inner_coreT (a k : Vd d) (v : L2d d)
    (h : ∀ z ∈ polyGaussCoreT a k, (inner ℂ z v : ℂ) = 0) : v = 0 := by sorry
