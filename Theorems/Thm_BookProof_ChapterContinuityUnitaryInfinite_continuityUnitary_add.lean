-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.continuityUnitary_add
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite

variable {X : Type*}


open scoped ENNReal InnerProductSpace

1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem BookProof.ChapterContinuityUnitaryInfinite.continuityUnitary_add (v : LinfZ) : continuityUnitary := by sorry
