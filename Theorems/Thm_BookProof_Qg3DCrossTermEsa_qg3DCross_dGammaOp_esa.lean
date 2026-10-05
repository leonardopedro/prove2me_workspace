-- Generated from ChapterQg3DCrossTermEsa.lean — theorem BookProof.Qg3DCrossTermEsa.qg3DCross_dGammaOp_esa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.FockSecondQuantization
open BookProof.FullQuadratic
open BookProof.Qg3DGaugeEsa
open BookProof.QuadFockEsa
open BookProof.QuantumGravity3DGauge
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

theorem BookProof.Qg3DCrossTermEsa.qg3DCross_dGammaOp_esa (e : ℕ ≃ (Fin 84 →₀ ℕ)) (Q' : Fin 84 → Fin 84 → ℝ) :
    EssentiallySelfAdjointOn (BookProof.NavierStokesFlow.lpFiniteModes Conf)
      (dGammaOp (hermCol e (fqPoly (qgFqP qgKappa) (qgFqQ + Q') bookCrossMat 0 0))) := by sorry
