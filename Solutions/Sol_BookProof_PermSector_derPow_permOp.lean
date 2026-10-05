-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.derPow_permOp
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_good_permOp
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (σ : Equiv.Perm (Fin n))
    (t : ((domSpace Hs D₂).pow n).carrier) :
    derPow Hs D₂ A n (permOp (domSpace Hs D₂) n σ t)
      = permOp Hs n σ (derPow Hs D₂ A n t) := (good_permOp Hs D₂ A ⊤ n σ).der t
