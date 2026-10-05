-- Generated from ChapterQg3DCrossTermEsa.lean — solution of BookProof.Qg3DCrossTermEsa.qg3DCross_dGammaOp_esa
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_fqPoly_essentiallySelfAdjointOn_core
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

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 84 →₀ ℕ)) (Q' : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly (qgFqP qgKappa) (qgFqQ + Q') bookCrossMat 0 0))) := dGamma_fqPoly_essentiallySelfAdjointOn_core e _ _ _ _ _
