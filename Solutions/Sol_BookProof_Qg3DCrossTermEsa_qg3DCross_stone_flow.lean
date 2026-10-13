-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.qg3DCross_stone_flow
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Theorems.Thm_BookProof_Qg3DCrossTermEsa_qg3DCross_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_stone_flow
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.Qg3DCrossTermEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa BookProof.FockSecondQuantization BookProof.QuadFockEsa
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Q' : Fin 84 → Fin 84 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d 84)) (U : ℝ → (L2d 84 →L[ℂ] L2d 84)),
      IsSelfAdjointExtension (qg3DCrossHamiltonian Q') T.op ∧ IsStoneFlow T U := by

  rw [qg3DCross_eq_fqOp]
  exact fqOp_stone_flow _ _ _ _ _
