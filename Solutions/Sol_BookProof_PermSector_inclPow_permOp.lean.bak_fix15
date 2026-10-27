-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.inclPow_permOp
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
    inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) = permOp Hs n σ (inclPow Hs D₂ n t) := (good_permOp Hs D₂ 0 ⊤ n σ).incl t
