-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.normSq_dGamma_le_w
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wdeg_nonneg
import Theorems.Thm_BookProof_FockWeightedSchur_ndeg_le_wdeg
import Theorems.Thm_BookProof_FockWeightedSchur_normSq_dGamma_le_of_sector
import Theorems.Thm_BookProof_FockSchur_dGamma_inSector
import Theorems.Thm_BookProof_FockSchur_normSq_sum_of_sectors
import Theorems.Thm_BookProof_FockSchur_sectorPart_apply
import Theorems.Thm_BookProof_FockSchur_sum_sectorPart
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K) (u : FockAlg) :
    ‖toLp (dGamma col u)‖ ^ 2 ≤ K ^ 2 * ∑ α ∈ u.support, wSym w α ^ 2 * ‖u α‖ ^ 2 := by

  classical
  set D : Finset ℕ := u.support.image ndeg with hD
  have hsplit : dGamma col u = ∑ n ∈ D, dGamma col (sectorPart n u) := by
    conv_lhs => rw [← sum_sectorPart u]
    rw [map_sum]
  have hsec : ∀ n ∈ D, InSector n (dGamma col (sectorPart n u)) := fun n _ =>
    dGamma_inSector col (sectorPart_inSector n u)
  rw [hsplit, normSq_sum_of_sectors _ hsec]
  have hterm : ∀ n ∈ D, ‖toLp (dGamma col (sectorPart n u))‖ ^ 2
      ≤ K ^ 2 * ∑ α ∈ u.support.filter (fun α => ndeg α = n), wSym w α ^ 2 * ‖u α‖ ^ 2 := by
    intro n _
    set F : Finset Conf := u.support.filter (fun α => ndeg α = n) with hF
    have hsub : (sectorPart n u).support ⊆ F := by
      rw [sectorPart, Finsupp.support_filter]
    have h1 : ∑ α ∈ (sectorPart n u).support, wdeg w α * ‖(sectorPart n u) α‖ ^ 2
        = ∑ α ∈ F, wdeg w α * ‖u α‖ ^ 2 := by
      rw [Finset.sum_subset hsub (fun α _ hα => by
        rw [Finsupp.notMem_support_iff.mp hα]; simp)]
      refine Finset.sum_congr rfl fun α hα => ?_
      rw [sectorPart_apply, if_pos (Finset.mem_filter.mp hα).2]
    have hbase := normSq_dGamma_le_of_sector hw hherm hrow hcolg hK0
      (sectorPart_inSector n u)
    rw [h1] at hbase
    refine le_trans hbase ?_
    refine mul_le_mul_of_nonneg_left ?_ (sq_nonneg K)
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun α hα => ?_
    have hn : ndeg α = n := (Finset.mem_filter.mp hα).2
    have h2 : ((n : ℝ)) ≤ wdeg w α := by
      rw [← hn]; exact ndeg_le_wdeg hw α
    have h3 : (0:ℝ) ≤ wdeg w α := wdeg_nonneg α
    have h4 : (n : ℝ) * wdeg w α ≤ wSym w α ^ 2 := by
      have : wSym w α = wdeg w α + 1 := rfl
      nlinarith
    have h5 : (0:ℝ) ≤ ‖u α‖ ^ 2 := sq_nonneg _
    calc (n : ℝ) * (wdeg w α * ‖u α‖ ^ 2) = ((n : ℝ) * wdeg w α) * ‖u α‖ ^ 2 := by ring
      _ ≤ wSym w α ^ 2 * ‖u α‖ ^ 2 := mul_le_mul_of_nonneg_right h4 h5
  refine le_trans (Finset.sum_le_sum hterm) ?_
  rw [← Finset.mul_sum]
  refine mul_le_mul_of_nonneg_left (le_of_eq ?_) (sq_nonneg K)
  exact Finset.sum_fiberwise_of_maps_to (fun α hα => Finset.mem_image_of_mem ndeg hα) _
