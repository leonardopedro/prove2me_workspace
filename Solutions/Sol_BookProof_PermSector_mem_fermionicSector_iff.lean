-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.mem_fermionicSector_iff
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
    x ∈ sector (fermionicProj Hs n)
      ↔ ∀ σ : Equiv.Perm (Fin n),
          permOp Hs n σ x = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by

  rw [sector, fermionicProj, (signRep Hs n).mem_range_avgProj_iff]
  have hsq : ∀ σ : Equiv.Perm (Fin n),
      ((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign σ : ℤ) : ℂ) = 1 := by
    intro σ
    rcases Int.units_eq_one_or (Equiv.Perm.sign σ) with h | h <;> simp [h]
  constructor
  · intro h σ
    have hσ := h σ⁻¹
    rw [signRep_act, inv_inv, Equiv.Perm.sign_inv] at hσ
    calc permOp Hs n σ x
        = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
            (((Equiv.Perm.sign σ : ℤ) : ℂ) • permOp Hs n σ x) := by
          rw [smul_smul, hsq, one_smul]
      _ = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by rw [hσ]
  · intro h σ
    rw [signRep_act, h σ⁻¹, Equiv.Perm.sign_inv, smul_smul, hsq, one_smul]
