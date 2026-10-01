-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.jacobiLag_drift_not_relativelyBounded
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hasZeroDeficiencyOn_zero
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_jacobiLag_secondOrder_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiOp_not_hasZeroDeficiencyOn
import Theorems.Thm_jacobiLagData_hFull
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
nly nonzero term is an unbounded first-order drift — the
positive second-order part is the **zero** operator. -/
theorem solution : secondOrder jacobiLagData = 0 := by
  have hP : ∀ i : Fin 3, jacobiLagData.P i = 0 := fun _ => rfl
  have hQ : ∀ i : Fin 3, jacobiLagData.Q i = 0 := fun _ => rfl
  simp [secondOrder, LagrangianFullData.kinetic, LagrangianFullData.viscous, hP, hQ]

/-- **Why the counterexample does not contradict this module.**  In the sharpness
example there is no relative bound of the drift against the parcel momenta: if
there were one, the Kato–Rellich theorem above would apply — the second-order
part is `0`, which is essentially self-adjoint, and the constraint vanishes — and
would make the transformed Hamiltonian essentia :=
  lly self-adjoint, which it is not.
  So the hypothesis `hdrift` of `hFull_hasZeroDeficiencyOn` is exactly what rules
  the counterexample out. -/
  theorem jacobiLag_drift_not_relativelyBounded :
      ¬ ∃ kap kap' : ℝ, 0 ≤ kap ∧ 0 ≤ kap' ∧ ∀ v : jacobiLagData.D,
        ‖(jacobiLagData.drift v : L2N)‖
          ≤ kap * (∑ j : Fin 3, ‖(jacobiLagData.P j v : L2N)‖) + kap' * ‖(v : L2N)‖ := by
    rintro ⟨kap, kap', hkap, hkap', h⟩
    have hC : ∀ v : jacobiLagData.D, ‖(jacobiLagData.constraintOp v : L2N)‖ ≤ 0 * ‖(v : L2N)‖ := by
      intro v
      have hzero : jacobiLagData.constraintOp = 0 := rfl
      rw [hzero]
