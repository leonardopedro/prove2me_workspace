-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.purePow_mem_sectorCore
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_inclPow_purePow
import Theorems.Thm_BookProof_PermSector_purePow_mem_corePow
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (f : Fin n → Hs.carrier) (hD : D ≤ D₂)
    (hf : ∀ i, f i ∈ D) : purePow Hs n f ∈ sectorCore Hs D₂ D n := by

  refine ⟨purePow (domSpace Hs D₂) n (fun i => ⟨f i, hD (hf i)⟩),
    purePow_mem_corePow Hs D₂ D n _ (fun i => hf i), ?_⟩
  simpa using inclPow_purePow Hs D₂ n (fun i => ⟨f i, hD (hf i)⟩)
