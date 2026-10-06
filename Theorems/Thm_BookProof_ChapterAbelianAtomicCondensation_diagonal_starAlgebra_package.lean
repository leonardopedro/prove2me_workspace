-- Generated from ChapterAbelianAtomicCondensation.lean — theorem BookProof.ChapterAbelianAtomicCondensation.diagonal_starAlgebra_package
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianAtomicCondensation


open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

theorem BookProof.ChapterAbelianAtomicCondensation.diagonal_starAlgebra_package :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, diagOp (d * e) = (diagOp d).comp (diagOp e)) ∧
      diagOp (1 : EllInf) = ContinuousLinearMap.id ℂ Ell2C ∧
      (∀ d : EllInf, ∀ f g : Ell2C,
        (inner ℂ (diagOp d f) g : ℂ) = (inner ℂ f (diagOp (star d) g) : ℂ)) := by sorry
