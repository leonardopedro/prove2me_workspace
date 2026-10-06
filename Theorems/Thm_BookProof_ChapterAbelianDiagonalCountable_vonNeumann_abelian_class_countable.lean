-- Generated from ChapterAbelianDiagonalCountable.lean — theorem BookProof.ChapterAbelianDiagonalCountable.vonNeumann_abelian_class_countable
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable


open scoped ENNReal

noncomputable section

theorem BookProof.ChapterAbelianDiagonalCountable.vonNeumann_abelian_class_countable :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, (diagOp d).comp (diagOp e) = (diagOp e).comp (diagOp d)) ∧
      (∀ T : Ell2C →L[ℂ] Ell2C,
        (∀ d : EllInf, T.comp (diagOp d) = (diagOp d).comp T) ↔ ∃ d : EllInf, T = diagOp d) := by sorry
