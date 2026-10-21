-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.ndeg_dn
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_dn_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_support_dn
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) {α : Conf} (h : 1 ≤ α j) : ndeg (dn j α) + 1 = ndeg α := by

  classical
  have hj : j ∈ α.support := Finsupp.mem_support_iff.mpr (by omega)
  have h1 : (dn j α).support ⊆ α.support := support_dn j α
  rw [ndeg_eq_sum h1, ndeg_eq_sum (Finset.Subset.refl α.support),
    ← Finset.add_sum_erase _ (fun i => (dn j α) i) hj,
    ← Finset.add_sum_erase _ (fun i => α i) hj]
  have hoff : ∀ i ∈ α.support.erase j, dn j α i = α i := fun i hi =>
    dn_of_ne _ (Finset.ne_of_mem_erase hi)
  rw [Finset.sum_congr rfl hoff, dn_self]
  have heq : (α.support.erase j).sum ⇑α = ∑ x ∈ α.support.erase j, α x := rfl
  omega
