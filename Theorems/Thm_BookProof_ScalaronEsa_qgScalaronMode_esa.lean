-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.qgScalaronMode_esa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.FarisLavine
open BookProof.QuantumGravityDensitized
open BookProof.ScalaronEsa

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]
variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc phi : ℕ → ℝ)


open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section


/
theorem BookProof.ScalaronEsa.qgScalaronMode_esa :
    EssentiallySelfAdjointOn := by sorry
