-- Generated from ChapterQg3DCrossTermEsa.lean — theorem BookProof.Qg3DCrossTermEsa.qgWithCoupling_eq_fqOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Mathlib
import Definitions.Def_ChapterQg3DCrossTermEsa
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterYangMillsHermite
open BookProof.FullQuadratic
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.Qg3DGaugeEsa
open BookProof.QuantumGravity3DGauge
open BookProof.YangMillsHermite
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

theorem BookProof.Qg3DCrossTermEsa.qgWithCoupling_eq_fqOp (kappa : Fin 84 → ℝ) (Q' C : Fin 84 → Fin 84 → ℝ)
    (b b' : Fin 84 → ℝ) :
    qgWithCoupling kappa Q' C b b' = fqOp (qgFqP kappa) (qgFqQ + Q') C b b' := by sorry
