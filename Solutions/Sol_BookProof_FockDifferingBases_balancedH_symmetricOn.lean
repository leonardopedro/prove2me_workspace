-- Generated from ChapterFockDifferingBasesEsa.lean — solution of BookProof.FockDifferingBases.balancedH_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockDifferingBasesEsa
import Theorems.Thm_BookProof_FockQuadratic_freeOp_symmetricOn
import Theorems.Thm_BookProof_FockQuadratic_pairOp_symmetricOn
import Theorems.Thm_BookProof_OperatorSeries_seriesOp_symmetricOn
open BookProof.FockDifferingBases




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries BookProof.FockQuadratic

noncomputable section

variable {ι κ : Type*} {ω : ι → ℝ}

variable {ι κ : Type*} {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2) (hsum : Summable fun k => ‖g k‖) :
    SymmetricOn (maxDom (sig ω)) (balancedH hω P Q g hPQ hsum) := by

  intro x y
  have h1 := freeOp_symmetricOn hω x y
  have h2 := seriesOp_symmetricOn (couplingT_norm_le hω P Q g hPQ) (hsum.mul_left 4)
    (fun k => pairOp_symmetricOn hω (g k) (P k) (Q k) (hPQ k)) x y
  simp only [balancedH, LinearMap.add_apply, inner_add_left, inner_add_right, h1, h2]
