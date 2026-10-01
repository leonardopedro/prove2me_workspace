-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGammaOp_finsetSum_col_eq
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGammaOp_finsetSum_col
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ)) :
    dGammaOp (fun k => ∑ i ∈ s, cols i k) = ∑ i ∈ s, dGammaOp (cols i) := by

  refine LinearMap.ext fun x => ?_
  rw [dGammaOp_finsetSum_col s cols x, LinearMap.sum_apply]
