-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.pgFunT_apply_sum
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_pgFunT_apply_zero
import Theorems.Thm_BookProof_ShiftedHermiteCore_pgFunT_apply_add
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (a k : Vd d) (s : Finset ι)
    (f : ι → MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (∑ v ∈ s, f v) x = ∑ v ∈ s, pgFunT a k (f v) x := by

  classical
  induction s using Finset.induction with
  | empty => simp [pgFunT_apply_zero]
  | insert v s hv ih => rw [Finset.sum_insert hv, Finset.sum_insert hv, pgFunT_apply_add, ih]
