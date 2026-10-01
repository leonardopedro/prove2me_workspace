-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_nonneg
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite

variable {X : Type*}


open scoped ENNReal InnerProductSpace

Z) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) : := by sorry
