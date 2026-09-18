-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.qgScalaron_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterMajoranaClifford
import Definitions.Def_ChapterMajoranaClifford
open BookProof.MajoranaClifford
open BookProof.ScalaronEsa


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

theorem BookProof.ScalaronEsa.qgScalaron_stone_flow :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgScalaronModeHamiltonian a b M alpha Rc phi) T.op ∧
        IsStoneFlow T U := by sorry
