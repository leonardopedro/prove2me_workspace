-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.norm_sum_P_le
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_norm_P_le
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (v : L.D) {eps : ℝ} (heps : 0 < eps) :
    ∑ j : Fin 3, ‖(L.P j v : F)‖
      ≤ 3 * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) := by

  calc ∑ j : Fin 3, ‖(L.P j v : F)‖
      ≤ ∑ _j : Fin 3, (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) :=
        Finset.sum_le_sum fun j _ => norm_P_le L v j heps
    _ = 3 * (eps * ‖(secondOrder L v : F)‖ + (1 / (2 * eps)) * ‖(v : F)‖) := by
        simp [Finset.sum_const]
        ring
