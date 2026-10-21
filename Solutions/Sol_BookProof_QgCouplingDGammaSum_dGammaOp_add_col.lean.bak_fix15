-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGammaOp_add_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_creVec_add
import Theorems.Thm_BookProof_FockSecondQuantization_coe_dGammaOp
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes Conf) :
    dGammaOp (fun k => a k + b k) x = dGammaOp a x + dGammaOp b x := by

  rw [coe_dGammaOp, coe_dGammaOp, coe_dGammaOp,
    dGamma_eq_sum _ (Finset.Subset.refl (modes (fockEquiv.symm x))),
    dGamma_eq_sum a (Finset.Subset.refl (modes (fockEquiv.symm x))),
    dGamma_eq_sum b (Finset.Subset.refl (modes (fockEquiv.symm x))),
    ← toLpL_apply, ← toLpL_apply, ← toLpL_apply, ← map_add]
  congr 1
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun k _ => creVec_add (a k) (b k) _
