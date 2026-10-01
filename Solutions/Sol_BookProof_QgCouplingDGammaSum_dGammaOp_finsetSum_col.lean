-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGammaOp_finsetSum_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGamma_finsetSum_col
import Theorems.Thm_BookProof_FockSecondQuantization_coe_dGammaOp
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (s : Finset ι) (cols : ι → ℕ → (ℕ →₀ ℂ))
    (x : lpFiniteModes Conf) :
    dGammaOp (fun k => ∑ i ∈ s, cols i k) x = ∑ i ∈ s, dGammaOp (cols i) x := by

  rw [coe_dGammaOp, dGamma_finsetSum_col]
  rw [show (∑ i ∈ s, dGamma (cols i) (fockEquiv.symm x)) =
      ∑ i ∈ s, dGamma (cols i) (fockEquiv.symm x) from rfl]
  rw [← toLpL_apply, map_sum]
  exact Finset.sum_congr rfl fun i _ => by rw [toLpL_apply, coe_dGammaOp]
