-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.norm_dGamma_le
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_dGamma_inSector
import Theorems.Thm_BookProof_FockSchur_normSq_toLp_of_subset
import Theorems.Thm_BookProof_FockSchur_norm_dGamma_le_of_sector
import Theorems.Thm_BookProof_FockSchur_sectorPart_inSector
import Theorems.Thm_BookProof_FockSchur_sectorPart_apply
import Theorems.Thm_BookProof_FockSchur_sum_sectorPart
import Theorems.Thm_BookProof_FockSchur_normSq_sum_of_sectors
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K)
    (u : FockAlg) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ∑ α ∈ u.support, ((ndeg α : ℝ)) ^ 2 * ‖u α‖ ^ 2 := by

  classical
  set D : Finset ℕ := u.support.image ndeg with hD
  have hsplit : dGamma col u = ∑ n ∈ D, dGamma col (sectorPart n u) := by
    conv_lhs => rw [← sum_sectorPart u]
    rw [map_sum]
  have hsec : ∀ n ∈ D, InSector n (dGamma col (sectorPart n u)) := fun n _ =>
    dGamma_inSector col (sectorPart_inSector n u)
  rw [hsplit, normSq_sum_of_sectors _ hsec]
  have hterm : ∀ n ∈ D, ‖toLp (dGamma col (sectorPart n u))‖ ^ 2
      ≤ K ^ 2 * ((n : ℝ) ^ 2 * ‖toLp (sectorPart n u)‖ ^ 2) := by
    intro n _
    have h := norm_dGamma_le_of_sector hK hherm hK0 (sectorPart_inSector n u)
    have h0 : 0 ≤ ‖toLp (dGamma col (sectorPart n u))‖ := norm_nonneg _
    have h1 : 0 ≤ ‖toLp (sectorPart n u)‖ := norm_nonneg _
    nlinarith [h, h0, h1]
  refine le_trans (Finset.sum_le_sum hterm) ?_
  rw [← Finset.mul_sum]
  refine mul_le_mul_of_nonneg_left (le_of_eq ?_) (sq_nonneg K)
  have hnorm : ∀ n : ℕ, ‖toLp (sectorPart n u)‖ ^ 2
      = ∑ α ∈ u.support.filter (fun α => ndeg α = n), ‖u α‖ ^ 2 := by
    intro n
    have hsub : (sectorPart n u).support ⊆ u.support.filter (fun α => ndeg α = n) := by
      rw [sectorPart, Finsupp.support_filter]
    rw [normSq_toLp_of_subset hsub]
    refine Finset.sum_congr rfl fun α hα => ?_
    rw [sectorPart_apply, if_pos (Finset.mem_filter.mp hα).2]
  calc ∑ n ∈ D, (n : ℝ) ^ 2 * ‖toLp (sectorPart n u)‖ ^ 2
      = ∑ n ∈ D, ∑ α ∈ u.support.filter (fun α => ndeg α = n),
          ((ndeg α : ℝ)) ^ 2 * ‖u α‖ ^ 2 := by
        refine Finset.sum_congr rfl fun n _ => ?_
        rw [hnorm n, Finset.mul_sum]
        exact Finset.sum_congr rfl fun α hα => by rw [(Finset.mem_filter.mp hα).2]
    _ = ∑ α ∈ u.support, ((ndeg α : ℝ)) ^ 2 * ‖u α‖ ^ 2 :=
        Finset.sum_fiberwise_of_maps_to (fun α hα => Finset.mem_image_of_mem ndeg hα) _
