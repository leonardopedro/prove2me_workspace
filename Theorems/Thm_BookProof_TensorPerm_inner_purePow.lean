-- Generated from ChapterTensorPermutation.lean — theorem BookProof.TensorPerm.inner_purePow
import Mathlib
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.TensorPerm

variable (E : BookProof.TensorCore.IPSpace)



open scoped TensorProduct
open BookProof.TensorCore BookProof.GroupAverage

noncomputable section

theorem BookProof.TensorPerm.inner_purePow : ∀ (n : ℕ) (f g : Fin n → E.carrier),
    (inner ℂ (purePow E n f) (purePow E n g) : ℂ) = ∏ i, inner ℂ (f i) (g i) := by sorry
