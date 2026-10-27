-- Generated from ChapterTensorPermutation.lean — solution of BookProof.TensorPerm.permOp_succ
import Mathlib
import Definitions.Def_ChapterTensorPermutation
open BookProof.TensorPerm




open scoped TensorProduct
open BookProof.TensorCore BookProof.GroupAverage

noncomputable section

variable (E : BookProof.TensorCore.IPSpace)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin (n + 1))) :
    permOp E (n + 1) σ = (swap0 E (n + 1) (Equiv.Perm.decomposeFin σ).1).trans
      (liftTail E (permOp E n (Equiv.Perm.decomposeFin σ).2)) := rfl
