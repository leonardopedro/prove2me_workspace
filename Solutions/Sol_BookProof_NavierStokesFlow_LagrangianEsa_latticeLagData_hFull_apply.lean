-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.latticeLagData_hFull_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow.FullEsa.NSFullData

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in

theorem solution (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) (x : (latticeLagData v w fr hnu).D) :
    ((latticeLagData v w fr hnu).hFull x : L2Z) = latticeLagCLM v w fr nu (x : L2Z) := by
  simp only [LagrangianFullData.hFull, LagrangianFullData.kinetic, LagrangianFullData.viscous,
    LagrangianFullData.drift, latticeLagData, latticeLagCLM]
  simp only [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.sum_apply, LinearMap.comp_apply,
    Submodule.coe_add, Submodule.coe_smul, Submodule.coe_sum, restrictCLM_apply,
    ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sum_apply,
    ContinuousLinearMap.mul_apply]
  show ↑((((1 / 2 : ℝ) : ℂ) • (∑ i, restrictCLM momentum finiteModes _
            ∘ₗ restrictCLM momentum finiteModes _)
      + (((nu : ℝ) : ℂ) • (∑ i, restrictCLM momentum finiteModes _
            ∘ₗ restrictCLM momentum finiteModes _))
      + (∑ i, ((fr i : ℝ) : ℂ) • restrictCLM (velocityOp (v i)) finiteModes _)
      + restrictCLM (velocityOp w) finiteModes _) x)
      = (((1 / 2 : ℝ) : ℂ) • (∑ i, momentum (momentum ↑x)))
        + (((nu : ℝ) : ℂ) • (∑ i, momentum (momentum ↑x)))
        + (∑ i, ((fr i : ℝ) : ℂ) • (velocityOp (v i)) ↑x)
        + (velocityOp w) ↑x
  rfl
