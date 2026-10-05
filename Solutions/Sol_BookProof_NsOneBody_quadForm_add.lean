-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.quadForm_add
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D' : Submodule ℂ F} (A B : D' →ₗ[ℂ] F) (x : D') :
    quadForm (A + B) x = quadForm A x + quadForm B x := by

  simp [quadForm, LinearMap.add_apply, inner_add_right, Complex.add_re]
