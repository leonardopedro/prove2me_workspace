-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.jacobiLag_drift_not_relativelyBounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hasZeroDeficiencyOn_zero
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_jacobiLag_secondOrder_eq_zero
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich

















open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)


























variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (L : LagrangianFullData F)








open LpNat DiagonalEsa

















open LpNat JacobiDeficiency

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ kap kap' : ℝ, 0 ≤ kap ∧ 0 ≤ kap' ∧ ∀ v : jacobiLagData.D,
      ‖(jacobiLagData.drift v : L2N)‖
        ≤ kap * (∑ j : Fin 3, ‖(jacobiLagData.P j v : L2N)‖) + kap' * ‖(v : L2N)‖ := by

  rintro ⟨kap, kap', hkap, hkap', h⟩
  have hC : ∀ v : jacobiLagData.D, ‖(jacobiLagData.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
    intro v
    have hzero : jacobiLagData.constraintOp = 0 := rfl
    rw [hzero]
    simp
  have hT : HasZeroDeficiencyOn jacobiLagData.D (secondOrder jacobiLagData) := by
    rw [jacobiLag_secondOrder_eq_zero]
    exact hasZeroDeficiencyOn_zero jacobiLagData.dense
  have hesa : HasZeroDeficiencyOn jacobiLagData.D jacobiLagData.hFull :=
    hFull_hasZeroDeficiencyOn jacobiLagData hkap hkap' le_rfl h hC hT
  rw [jacobiLagData_hFull] at hesa
  exact jacobiOp_not_hasZeroDeficiencyOn hesa
