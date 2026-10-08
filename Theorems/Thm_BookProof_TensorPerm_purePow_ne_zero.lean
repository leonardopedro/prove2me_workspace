-- Generated from ChapterTensorPermutation.lean — theorem BookProof.TensorPerm.purePow_ne_zero
import Definitions.Def_ChapterGroupAverageEsa
import Mathlib
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorPerm



open scoped TensorProduct
open BookProof.TensorCore BookProof.GroupAverage

noncomputable section

variable (E : BookProof.TensorCore.IPSpace)

theorem BookProof.TensorPerm.purePow_ne_zero {n : ℕ} {f : Fin n → E.carrier} (hf : ∀ i, f i ≠ 0) :
    purePow E n f ≠ 0 := by sorry
