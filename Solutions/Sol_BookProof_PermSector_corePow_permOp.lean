-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.corePow_permOp
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
    {t : ((domSpace Hs D₂).pow n).carrier} (ht : t ∈ corePow Hs D₂ D n) :
    permOp (domSpace Hs D₂) n σ t ∈ corePow Hs D₂ D n := (good_permOp Hs D₂ 0 D n σ).core t ht
