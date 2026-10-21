-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.balancedH_norm_le
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockQuadratic_freeOp_norm_le
import Theorems.Thm_BookProof_OperatorSeries_seriesOp_norm_le
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖)
    (x : maxDom (sig ω)) :
    ‖(balancedH hω P Q g hPQ hsum x : L2I (Idx ι))‖
      ≤ (1 + ∑' k, 4 * ‖g k‖) * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by

  have h1 := freeOp_norm_le hω x
  have h2 := seriesOp_norm_le (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4) x
  have hn : (0 : ℝ) ≤ ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := norm_nonneg _
  have hadd : ‖(balancedH hω P Q g hPQ hsum x : L2I (Idx ι))‖
      ≤ ‖(freeOp hω x : L2I (Idx ι))‖
        + ‖(seriesOp (couplingT hω P Q g hPQ) (fun k => 4 * ‖g k‖)
              (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4) x : L2I (Idx ι))‖ := by
    simpa only [balancedH, LinearMap.add_apply] using
      norm_add_le (freeOp hω x : L2I (Idx ι))
        (seriesOp (couplingT hω P Q g hPQ) (fun k => 4 * ‖g k‖)
          (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4) x : L2I (Idx ι))
  nlinarith [hadd, h1, h2]
