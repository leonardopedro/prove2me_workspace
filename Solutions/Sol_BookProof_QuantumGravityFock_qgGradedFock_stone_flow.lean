-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgGradedFock_stone_flow
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_qgGradedHam_symmetricOn
import Theorems.Thm_BookProof_QuantumGravityFock_qgGradedFock_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (omega g : ℕ → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (lp (fun _ : GradedIdx => ℂ) 2))
      (U : ℝ → (lp (fun _ : GradedIdx => ℂ) 2 →L[ℂ] lp (fun _ : GradedIdx => ℂ) 2)),
      IsSelfAdjointExtension
        ((lpFiniteModes GradedIdx).subtype.comp (qgGradedHam omega g)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ lpFiniteModes_dense (qgGradedHam_symmetricOn omega g)
      (qgGradedFock_essentiallySelfAdjointOn omega g)
