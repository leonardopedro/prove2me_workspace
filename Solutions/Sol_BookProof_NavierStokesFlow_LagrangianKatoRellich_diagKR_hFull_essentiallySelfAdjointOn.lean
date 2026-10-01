-- Generated from ChapterNavierStokesLagrangianKatoRellich.lean — solution of BookProof.NavierStokesFlow.LagrangianKatoRellich.diagKR_hFull_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_hFull_essentiallySelfAdjointOn_of_drive_eq_P
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_drive
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_constraint_bound
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianKatoRellich_diagKR_secondOrder_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianKatoRellich



open Filter Topology



open FullEsa LagrangianEsa BookProof.FarisLavine BookProof.KatoRellich
open BookProof.EsaClosure BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin

set_option maxHeartbeats 1000000 in
ine diagOp_not_bounded _ fun C => ?_
  refine ⟨⌈|C|⌉₊ + 1, ?_⟩
  have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
  have hc : C ≤ |C| := le_abs_self C
  have h0 : (0 : ℝ) ≤ (⌈|C|⌉₊ : ℝ) := Nat.cast_nonneg _
  have habs : |3 * ((⌈|C|⌉₊ + 1 : ℕ) : ℝ)| = 3 * ((⌈|C|⌉ :=
  ₊ : ℝ) + 1) := by
      push_cast
      rw [abs_of_nonneg (by positivity)]
    rw [habs]
    linarith
  
  /-- **The full transformed Hamiltonian of the unbounded instance is essentially
  self-adjoint** — by Kato–Rellich, from the essential self
