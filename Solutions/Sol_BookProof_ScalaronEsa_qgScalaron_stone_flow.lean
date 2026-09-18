import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.qgScalaron_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Theorems.Thm_BookProof_ScalaronEsa_qgScalaronMode_symmetric
import Theorems.Thm_BookProof_ScalaronEsa_qgScalaronMode_esa
import Theorems.Thm_BookProof_Starobinsky_mulSymbolDomain_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint L2Nat) (U : ℝ → (L2Nat →L[ℂ] L2Nat)),
      IsSelfAdjointExtension (qgScalaronModeHamiltonian a b M alpha Rc phi) T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa (qgScalaronModeHamiltonian a b M alpha Rc phi)
      (mulSymbolDomain_dense _) (qgScalaronMode_symmetric a b M alpha Rc phi)
      (qgScalaronMode_esa a b M alpha Rc phi)
