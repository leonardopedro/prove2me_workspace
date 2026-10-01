-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGammaOp_diagCol_eq
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGamma_diagCol_apply
import Theorems.Thm_BookProof_FockSecondQuantization_coe_dGammaOp
import Theorems.Thm_BookProof_FockSecondQuantization_coe_fockEquiv_symm
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) :
    dGammaOp (diagCol lam)
      = (diagMax (occEnergy lam)).comp
          (Submodule.inclusion (finiteModes_le_maxDom (occEnergy lam))) := by

  refine LinearMap.ext fun x => ?_
  refine lp.ext (funext fun α => ?_)
  have hx : ((x : lpFiniteModes Conf) : Fock) = toLp (fockEquiv.symm x) := coe_fockEquiv_symm x
  have hxα : ((x : lpFiniteModes Conf) : Fock) α = (fockEquiv.symm x) α := by
    rw [hx]; rfl
  rw [coe_dGammaOp]
  change (dGamma (diagCol lam) (fockEquiv.symm x)) α = _
  rw [dGamma_diagCol_apply]
  change ((occEnergy lam α : ℝ) : ℂ) * (fockEquiv.symm x) α
      = ((occEnergy lam α : ℝ) : ℂ) * (((x : lpFiniteModes Conf) : Fock) : Conf → ℂ) α
  rw [hxα]
