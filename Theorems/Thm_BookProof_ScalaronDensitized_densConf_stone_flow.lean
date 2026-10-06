-- Generated from ChapterScalaronDensitizedTransfer.lean — theorem BookProof.ScalaronDensitized.densConf_stone_flow
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.QuantumGravityHalfDensity
open BookProof.StoneBridge
open BookProof.ScalaronDensitized

variable (M alpha : ℝ)
variable {X : Type*} [MeasurableSpace X]



open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.ScalaronDensitized.densConf_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 qgSrcMeasure))
      (U : ℝ → (Lp ℂ 2 qgSrcMeasure →L[ℂ] Lp ℂ 2 qgSrcMeasure)),
      IsSelfAdjointExtension
        ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) T.op ∧ IsStoneFlow T U := by sorry
