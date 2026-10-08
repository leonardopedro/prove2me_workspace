-- Generated from ChapterTensorPermutation.lean — theorem BookProof.TensorPerm.inner_purePow
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

theorem BookProof.TensorPerm.inner_purePow : ∀ (n : ℕ) (f g : Fin n → E.carrier),
    (inner ℂ (purePow E n f) (purePow E n g) : ℂ) = ∏ i, inner ℂ (f i) (g i) := by sorry
