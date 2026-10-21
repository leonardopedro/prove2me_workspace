-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.normSq_toLp_of_subset
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp_of_subset
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} {S : Finset Conf} (hs : u.support ⊆ S) :
    ‖toLp u‖ ^ 2 = ∑ α ∈ S, ‖u α‖ ^ 2 := by

  have h := inner_toLp_of_subset hs u
  have hnorm : (inner ℂ (toLp u) (toLp u) : ℂ) = ((‖toLp u‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [hnorm] at h
  have h2 : ∀ α : Conf, (starRingEnd ℂ) (u α) * u α = ((‖u α‖ ^ 2 : ℝ) : ℂ) := by
    intro α
    rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]
  rw [Finset.sum_congr rfl (fun α _ => h2 α)] at h
  exact_mod_cast h
