-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.mem_bosonicSector_iff
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_mem_range_avgProj_iff
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (bosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), permOp Hs n σ x = x := by

  rw [sector, bosonicProj, (permRep Hs n).mem_range_avgProj_iff]
  constructor
  · intro h σ
    simpa using h σ⁻¹
  · intro h σ
    simpa using h σ⁻¹
