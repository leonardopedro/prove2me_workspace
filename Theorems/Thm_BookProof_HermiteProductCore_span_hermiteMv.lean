-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

X_mul]
    exact add_mem (Submodule.subset_span ⟨_, rfl⟩)
      (Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, rfl⟩))
  | zero => simp
  | a := by sorry
