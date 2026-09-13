-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.norm_P_sq_le
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_secondOrder_inner
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (v : L.D) (i : Fin 3) :
    ‖(L.P i v : F)‖ ^ 2 ≤ 2 * (‖(v : F)‖ * ‖(secondOrder L v : F)‖) := by

  have hk : (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re
      = (1 / 2 : ℝ) * ∑ j : Fin 3, ‖(L.P j v : F)‖ ^ 2 := by
    rw [L.kinetic_inner v, Complex.ofReal_re]
  have hsingle : ‖(L.P i v : F)‖ ^ 2 ≤ ∑ j : Fin 3, ‖(L.P j v : F)‖ ^ 2 :=
    Finset.single_le_sum (f := fun j : Fin 3 => ‖(L.P j v : F)‖ ^ 2)
      (fun j _ => sq_nonneg _) (Finset.mem_univ i)
  have hv : 0 ≤ (inner ℂ (v : F) (L.viscous v : F) : ℂ).re := L.viscous_nonneg v
  have hform : (1 / 2 : ℝ) * ‖(L.P i v : F)‖ ^ 2
      ≤ (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re := by
    rw [secondOrder_inner L v, hk]
    nlinarith
  have hcs : (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
      ≤ ‖(v : F)‖ * ‖(secondOrder L v : F)‖ := by
    calc (inner ℂ (v : F) (secondOrder L v : F) : ℂ).re
        ≤ ‖(inner ℂ (v : F) (secondOrder L v : F) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖(v : F)‖ * ‖(secondOrder L v : F)‖ := norm_inner_le_norm _ _
  linarith
