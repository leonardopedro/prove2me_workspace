-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.exists_ne_zero_bosonic
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_PermSector_mem_bosonicSector_iff
import Theorems.Thm_BookProof_PermSector_purePow_mem_sectorCore
import Theorems.Thm_BookProof_TensorPerm_purePow_ne_zero
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D)
    (ha0 : a ≠ 0) : ∃ x : redDom (bosonicProj Hs n) (sectorCore Hs D₂ D n), x ≠ 0 := by

  set v : (Hs.pow n).carrier := purePow Hs n (fun _ => a) with hv
  have hcore : v ∈ sectorCore Hs D₂ D n :=
    purePow_mem_sectorCore Hs D₂ D n _ hD (fun _ => haD)
  have hsec : v ∈ sector (bosonicProj Hs n) := by
    refine (mem_bosonicSector_iff Hs n).mpr (fun σ => ?_)
    rw [hv, permOp_purePow]
    rfl
  have hv0 : v ≠ 0 := purePow_ne_zero Hs (fun _ => ha0)
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))
