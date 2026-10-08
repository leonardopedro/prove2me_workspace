-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.diagonal_starAlgebra_package
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_injective
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_mul
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_one
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_star
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, diagOp (d * e) = (diagOp d).comp (diagOp e)) ∧
      diagOp (1 : EllInf) = ContinuousLinearMap.id ℂ Ell2C ∧
      (∀ d : EllInf, ∀ f g : Ell2C,
        (inner ℂ (diagOp d f) g : ℂ) = (inner ℂ f (diagOp (star d) g) : ℂ)) := ⟨diagOp_injective, diagOp_mul, diagOp_one, diagOp_star⟩
